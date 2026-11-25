#!/usr/bin/env ruby
# macOS installer for the v1.2-beta Bambu Third-Party Filament Pack.
# Uses only the Ruby standard library. No sudo or Windows tools required.
require 'json'
require 'fileutils'
require 'optparse'
require 'tmpdir'
require 'tempfile'

options = { printer: 'P1S', nozzle: '0.4', dry_run: false }
parser = OptionParser.new do |o|
  o.banner = 'Usage: ruby Install-Filament-Pack-macOS.rb [options] PACK_DIRECTORY'
  o.on('--printer MODEL', %w[P1S H2D H2C P2S], 'Printer (default: P1S)') { |v| options[:printer] = v }
  o.on('--nozzle SIZE', %w[0.4 0.6], 'Nozzle diameter (default: 0.4)') { |v| options[:nozzle] = v }
  o.on('--dry-run', 'Validate and preview without writing files') { options[:dry_run] = true }
  o.on('-h', '--help', 'Show help') { puts o; exit }
end

def read_json(path)
  JSON.parse(File.read(path, encoding: 'bom|utf-8'))
end

def fail_if(condition, message)
  raise message if condition
end

def relative_path(entry)
  path = entry.fetch('sub_path')
  fail_if(!path.is_a?(String) || !path.start_with?('filament/') ||
          path.include?('\\') || path.split('/').any? { |p| ['.', '..', ''].include?(p) } ||
          !path.end_with?('.json'), "Invalid manifest path: #{path.inspect}")
  path
end

def inside?(path, root)
  File.realpath(path).start_with?(File.realpath(root) + File::SEPARATOR)
end

def no_symlink_components!(root, relative)
  path = root
  relative.split('/').each do |part|
    path = File.join(path, part)
    fail_if(File.symlink?(path), "Refusing symbolic link: #{path}")
  end
end

begin
  parser.parse!
  fail_if(ARGV.length != 1, parser.to_s)
  fail_if(RUBY_PLATFORM !~ /darwin/, 'This installer is intended for macOS.')
  if system('/usr/bin/pgrep', '-ix', 'BambuStudio|Bambu Studio', out: File::NULL, err: File::NULL)
    raise 'Quit Bambu Studio completely (Command-Q) before running the installer.'
  end

  pkg = File.expand_path(ARGV.first)
  system_dir = File.expand_path('~/Library/Application Support/BambuStudio/system')
  bbl = File.join(system_dir, 'BBL')
  registry = File.join(system_dir, 'BBL.json')
  profiles_root = File.join(pkg, 'Profiles')
  fail_if(!File.directory?(bbl) || !File.file?(registry), 'Bambu Studio system profiles not found. Launch Bambu Studio once, then quit it.')
  fail_if(File.symlink?(bbl) || File.symlink?(registry), 'Unexpected symbolic link in Bambu Studio system profiles.')
  manifest = read_json(File.join(pkg, 'manifest.json'))
  config = read_json(registry)
  entries = config.fetch('filament_list')
  profiles = manifest.fetch('profiles')
  fail_if(!entries.is_a?(Array) || !profiles.is_a?(Array), 'Unsupported registry or manifest format.')

  suffix = " @BBL #{options[:printer]} #{options[:nozzle]} nozzle"
  selected = profiles.select { |p| p.fetch('name').end_with?(suffix) }
  fail_if(selected.empty?, "No profiles found for #{suffix.strip}.")
  by_name = {}
  profiles.each do |p|
    name = p.fetch('name')
    fail_if(by_name.key?(name), "Duplicate manifest name: #{name}")
    by_name[name] = p
  end
  bases = selected.map do |p|
    base_name = p.fetch('name').delete_suffix(suffix) + ' @base'
    by_name.fetch(base_name) { raise "Missing base profile: #{base_name}" }
  end.uniq
  puts "Printer profiles: #{selected.size}; base profiles: #{bases.size}"
  puts 'Mode: add only; existing files and registry entries will not be overwritten.'

  names = {}; paths = {}
  entries.each do |e|
    names[e.fetch('name').downcase] = e
    paths[e.fetch('sub_path').downcase] = e
  end
  planned = []; skipped = []
  (bases + selected).each do |p|
    name = p.fetch('name')
    relative = relative_path(p)
    src = File.join(profiles_root, relative.sub(/\Afilament\//, ''))
    dst = File.join(bbl, relative)
    fail_if(!File.file?(src) || !inside?(src, profiles_root), "Missing or invalid source: #{src}")
    profile = read_json(src)
    fail_if(profile['name'] != name || profile['type'] != 'filament', "Profile metadata mismatch: #{src}")
    no_symlink_components!(bbl, relative)
    if names.key?(name.downcase) || paths.key?(relative.downcase) || File.exist?(dst)
      skipped << name
      puts "SKIP (already present or conflicting): #{name}"
      next
    end
    parent = profile['inherits']
    fail_if(parent && !parent.empty? && !names.key?(parent.downcase), "Missing parent #{parent} for #{name}; no files have been changed.")
    # An existing parent must be registered with an actual file, or be in this plan.
    if parent && !parent.empty?
      parent_entry = names.fetch(parent.downcase)
      parent_rel = relative_path(parent_entry)
      unless planned.any? { |item| item[:name].downcase == parent.downcase }
        no_symlink_components!(bbl, parent_rel)
        fail_if(!File.file?(File.join(bbl, parent_rel)), "Registered parent file missing: #{parent}")
      end
    end
    record = { 'name' => name, 'sub_path' => relative }
    planned << { name: name, src: src, dst: dst, record: record }
    names[name.downcase] = record
    paths[relative.downcase] = record
  end

  puts "To add: #{planned.size}; to skip: #{skipped.size}"
  if options[:dry_run] || planned.empty?
    puts(options[:dry_run] ? 'Dry run complete; no files written.' : 'Nothing to install.')
    exit
  end

  # Keep the backup outside the pack/repository to avoid accidentally committing it.
  backup_root = File.expand_path('~/Library/Application Support/BambuFilamentPack/Backups')
  FileUtils.mkdir_p(backup_root)
  backup = Dir.mktmpdir("MAC-PRE-INSTALL-#{Time.now.strftime('%Y%m%d_%H%M%S')}-", backup_root)
  FileUtils.cp_r(bbl, File.join(backup, 'BBL'))
  FileUtils.cp(registry, File.join(backup, 'BBL.json'))
  puts "Backup: #{backup}"

  written = []
  begin
    planned.each do |item|
      FileUtils.mkdir_p(File.dirname(item[:dst]))
      # Exclusive create prevents overwriting a file that appears after validation.
      File.open(item[:dst], File::WRONLY | File::CREAT | File::EXCL, 0644) do |out|
        written << item[:dst]
        File.open(item[:src], 'rb') { |input| IO.copy_stream(input, out) }
      end
      entries << item[:record]
      puts "ADDED: #{item[:name]}"
    end
    Tempfile.create(['BBL-', '.json'], system_dir) do |tmp|
      tmp.write(JSON.pretty_generate(config) + "\n")
      tmp.flush
      tmp.fsync
      read_json(tmp.path)
      File.chmod(File.stat(registry).mode & 0777, tmp.path)
      fail_if(File.binread(registry) != File.binread(File.join(backup, 'BBL.json')), 'Registry changed during installation; quit Bambu Studio and retry.')
      File.rename(tmp.path, registry)
    end
  rescue StandardError, Interrupt
    # The original registry is unchanged unless the final atomic rename succeeded.
    # Avoid removing files if the registry was already committed.
    if File.binread(registry) == File.binread(File.join(backup, 'BBL.json'))
      written.reverse_each { |path| File.delete(path) if File.file?(path) }
    end
    raise
  end
  puts "Installation complete. Added: #{planned.size}; skipped: #{skipped.size}"
  puts 'Restart Bambu Studio and enable the desired filament presets.'
rescue StandardError, Interrupt => e
  warn "ERROR: #{e.message}"
  exit 1
end
