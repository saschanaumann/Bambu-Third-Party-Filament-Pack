#!/usr/bin/env ruby
# macOS port of Bambu Third-Party Filament Pack v1.2-beta (WoozyFace).
# Original profiles: Naumann Consulting / 3D Service (saschanaumann).
require 'json'
require 'fileutils'
require 'optparse'
require 'tmpdir'
require 'tempfile'
require 'digest'

module FilamentPack
  ASSET = 'Bambu-Third-Party-Filament-Pack-H2C-P2S-P1S-H2D-v1.2-BETA.zip'.freeze
  URL = "https://github.com/saschanaumann/Bambu-Third-Party-Filament-Pack/releases/download/v1.2-beta/#{ASSET}".freeze
  SHA = '4ab267a83105ca9ee026e3b3b8df2dfd6eef1635f8a298b010b2529ed36a789b'.freeze
  MODELS = %w[P1S H2D H2C P2S].freeze
  NOZZLES = %w[0.4 0.6].freeze
  module_function

  def check(condition, message)
    raise message unless condition
  end

  def read_json(path)
    JSON.parse(File.read(path, encoding: 'bom|utf-8'))
  end

  def sha(path)
    Digest::SHA256.file(path).hexdigest
  end

  def relative(entry)
    rel = entry.fetch('sub_path')
    check(rel.is_a?(String) && rel.start_with?('filament/') && rel.end_with?('.json') &&
          !rel.include?('\\') && !rel.split('/', -1).any? { |p| ['', '.', '..'].include?(p) },
          "Invalid filament path: #{rel.inspect}")
    rel
  end

  def safe_path(root, rel)
    path = root
    rel.split('/').each do |p|
      path = File.join(path, p)
      check(!File.symlink?(path), "Refusing symbolic link: #{path}")
    end
    path
  end

  def layout(system_dir)
    bbl = File.join(system_dir, 'BBL')
    registry = File.join(system_dir, 'BBL.json')
    check(File.directory?(bbl) && File.file?(registry), 'Bambu Studio system profiles not found. Launch Studio once, then quit it.')
    check(!File.symlink?(system_dir) && !File.symlink?(bbl) && !File.symlink?(registry), 'Unexpected symlink in Studio profile directories.')
    [bbl, registry]
  end

  def atomic_registry(registry, content, expected)
    Tempfile.create(['BBL-', '.json'], File.dirname(registry)) do |tmp|
      tmp.binmode
      tmp.write(content)
      tmp.flush
      tmp.fsync
      read_json(tmp.path)
      File.chmod(File.stat(registry).mode & 0777, tmp.path)
      check(sha(registry) == expected, 'Registry changed during operation; close Studio and retry.')
      File.rename(tmp.path, registry)
    end
  end

  def with_lock(backup_root)
    FileUtils.mkdir_p(backup_root)
    File.open(File.join(backup_root, '.installer.lock'), File::RDWR | File::CREAT, 0600) do |lock|
      check(lock.flock(File::LOCK_EX | File::LOCK_NB), 'Another installer or restore operation is running.')
      yield
    end
  end

  def with_package(local_zip, dry_run: false)
    Dir.mktmpdir('bambu-filament-pack-') do |tmp|
      archive = local_zip || File.join(tmp, ASSET)
      unless local_zip
        puts "Downloading the original, pinned v1.2-beta profile archive..."
        check(system('/usr/bin/curl', '--fail', '--location', '--show-error', '--retry', '2', '--connect-timeout', '20', '--max-time', '180', '--proto', '=https', '--proto-redir', '=https', '-o', archive, URL), 'Download failed. Check your connection or place the original ZIP alongside this installer.')
      end
      check(File.file?(archive), "Archive not found: #{archive}")
      check(sha(archive) == SHA, 'SHA-256 mismatch. No installation performed. Use the exact original v1.2-beta archive.')
      puts 'Original archive SHA-256 verified.'
      extracted = File.join(tmp, 'extracted')
      FileUtils.mkdir_p(extracted)
      check(system('/usr/bin/unzip', '-q', archive, '-d', extracted), 'Could not extract the upstream archive.')
      candidates = Dir.glob(File.join(extracted, '**', 'manifest.json')).map { |p| File.dirname(p) }.select { |p| File.directory?(File.join(p, 'Profiles')) }
      check(candidates.length == 1, 'Expected exactly one manifest.json next to a Profiles directory. Unsupported archive structure.')
      yield candidates.first
    end
  end

  def install(pkg, system_dir, backup_root, printer, nozzle, dry_run: false)
    check(MODELS.include?(printer) && NOZZLES.include?(nozzle), 'Unsupported printer/nozzle combination.')
    bbl, registry = layout(system_dir)
    registry_before = sha(registry)
    config = read_json(registry)
    entries = config.fetch('filament_list')
    profiles = read_json(File.join(pkg, 'manifest.json')).fetch('profiles')
    check(entries.is_a?(Array) && profiles.is_a?(Array), 'Unsupported registry or manifest format.')
    profiles_root = File.join(pkg, 'Profiles')
    suffix = " @BBL #{printer} #{nozzle} nozzle"
    selected = profiles.select { |p| p.fetch('name').end_with?(suffix) }
    check(!selected.empty?, "No profiles found for #{printer} / #{nozzle} mm.")
    by_name = {}
    profiles.each do |p|
      name = p.fetch('name')
      check(!by_name.key?(name), "Duplicate manifest name: #{name}")
      by_name[name] = p
    end
    names = {}; paths = {}
    entries.each do |e|
      names[e.fetch('name').downcase] = e
      paths[e.fetch('sub_path').downcase] = e
    end
    planned = []; skipped = []; visiting = {}; completed = {}
    resolve = lambda do |name|
      key = name.downcase
      return if completed[key]
      check(!visiting[key], "Circular inheritance: #{name}")
      visiting[key] = true
      existing = names[key]
      if existing
        existing_path = safe_path(bbl, relative(existing))
        check(File.file?(existing_path), "Registered profile file missing: #{name}")
        check(read_json(existing_path)['name'] == existing.fetch('name'), "Registered profile name mismatch: #{name}")
        skipped << name if by_name.key?(name)
      else
        p = by_name[name]
        check(p, "Missing parent #{name}; update Bambu Studio or enable its official profiles. No profiles written.")
        rel = relative(p)
        src = safe_path(profiles_root, rel.sub(/\Afilament\//, ''))
        dst = safe_path(bbl, rel)
        check(File.file?(src) && File.realpath(src).start_with?(File.realpath(profiles_root) + File::SEPARATOR), "Missing/invalid source: #{src}")
        profile = read_json(src)
        check(profile['name'] == name && profile['type'] == 'filament', "Profile metadata mismatch: #{src}")
        check(!paths.key?(rel.downcase) && !File.exist?(dst), "Existing unregistered or conflicting profile: #{rel}; no profiles written.")
        parent = profile['inherits']
        resolve.call(parent) if parent && !parent.empty?
        record = { 'name' => name, 'sub_path' => rel }
        planned << { name: name, src: src, dst: dst, rel: rel, record: record, sha: sha(src) }
        paths[rel.downcase] = record
      end
      visiting.delete(key)
      completed[key] = true
    end
    selected.each { |p| resolve.call(p.fetch('name')) }
    puts "Printer profiles selected: #{selected.size}; dependency profiles to add: #{planned.count { |p| !p[:name].end_with?(suffix) }}"
    puts "To add: #{planned.size}; to skip: #{skipped.size}"
    if dry_run || planned.empty?
      puts(dry_run ? 'Dry run complete; no Studio files changed.' : 'Nothing to install.')
      return
    end
    with_lock(backup_root) do
      check(sha(registry) == registry_before, 'Registry changed after validation; retry.')
      backup = Dir.mktmpdir("MAC-PRE-INSTALL-#{Time.now.strftime('%Y%m%d_%H%M%S')}-", backup_root)
      FileUtils.cp_r(bbl, File.join(backup, 'BBL'))
      FileUtils.cp(registry, File.join(backup, 'BBL.json'))
      check(sha(File.join(backup, 'BBL.json')) == registry_before, 'Registry changed during backup; retry.')
      puts "Backup: #{backup}"
      written = []
      begin
        planned.each do |item|
          FileUtils.mkdir_p(File.dirname(item[:dst]))
          File.open(item[:dst], File::WRONLY | File::CREAT | File::EXCL, 0644) do |out|
            written << item[:dst]
            File.open(item[:src], 'rb') { |input| IO.copy_stream(input, out) }
          end
          check(sha(item[:dst]) == item[:sha], "Copy verification failed: #{item[:name]}")
          entries << item[:record]
        end
        new_content = JSON.pretty_generate(config) + "\n"
        ledger = { 'before' => registry_before, 'after' => Digest::SHA256.hexdigest(new_content),
                   'added' => planned.map { |item| { 'sub_path' => item[:rel], 'sha256' => item[:sha] } } }
        File.write(File.join(backup, 'install-ledger.json'), JSON.pretty_generate(ledger) + "\n")
        atomic_registry(registry, new_content, registry_before)
      rescue StandardError, Interrupt
        if sha(registry) == registry_before
          written.reverse_each { |path| File.delete(path) if File.file?(path) }
          FileUtils.rm_f(File.join(backup, 'install-ledger.json'))
        end
        raise
      end
      puts "Installation complete. Added: #{planned.size}; skipped: #{skipped.size}."
      puts 'Restart Bambu Studio, select the printer/nozzle, enable presets if needed, then edit the AMS slot.'
    end
  end

  def restore(system_dir, backup_root, dry_run: false)
    bbl, registry = layout(system_dir)
    with_lock(backup_root) do
      backups = Dir.glob(File.join(backup_root, 'MAC-PRE-INSTALL-*', 'install-ledger.json')).sort_by { |p| File.mtime(p) }.reverse
      check(!backups.empty?, 'No completed installation ledger found.')
      ledger_path = backups.first
      backup = File.dirname(ledger_path)
      ledger = read_json(ledger_path)
      check(sha(registry) == ledger.fetch('after'), 'Registry changed since the last install. Automatic restore refused to protect later changes. Keep the backup for manual recovery.')
      old = File.join(backup, 'BBL.json')
      check(sha(old) == ledger.fetch('before'), 'Backup registry failed verification.')
      files = ledger.fetch('added').map do |item|
        path = safe_path(bbl, relative(item))
        check(File.file?(path) && sha(path) == item.fetch('sha256'), "Profile changed since installation: #{path}; restore refused.")
        path
      end
      puts "Restore from: #{backup}; remove #{files.length} added profiles."
      return if dry_run
      # Registry first: interruption cannot leave registered profiles pointing at deleted files.
      atomic_registry(registry, File.binread(old), ledger.fetch('after'))
      files.each { |path| File.delete(path) }
      File.rename(ledger_path, File.join(backup, 'restored-ledger.json'))
      puts 'Restore complete. Backup retained. Restart Bambu Studio.'
    end
  end

  def prompt(question, allowed, default)
    loop do
      print "#{question} (#{allowed.join('/')}) [#{default}]: "
      value = $stdin.gets
      check(value, 'Input cancelled.')
      value = value.strip
      value = default if value.empty?
      value = value.upcase if question == 'Printer'
      return value if allowed.include?(value)
      puts 'Invalid selection; try again.'
    end
  end

  def main(argv)
    opts = { dry_run: false, restore: false }
    interactive = argv.empty? && $stdin.tty?
    parser = OptionParser.new do |o|
      o.banner = 'Usage: ruby Install-Filament-Pack-macOS.rb [--printer P1S --nozzle 0.4] [--dry-run] [--zip PATH] [--restore]'
      o.on('--printer MODEL', MODELS) { |v| opts[:printer] = v }
      o.on('--nozzle SIZE', NOZZLES) { |v| opts[:nozzle] = v }
      o.on('--dry-run', 'Preview without changing Studio profiles') { opts[:dry_run] = true }
      o.on('--zip PATH', 'Use a local, original release ZIP instead of downloading') { |v| opts[:zip] = File.expand_path(v) }
      o.on('--restore', 'Restore the most recent completed install if unchanged') { opts[:restore] = true }
      o.on('-h', '--help') { puts o; return }
    end
    parser.parse!(argv)
    check(argv.empty?, parser.to_s)
    check(RUBY_PLATFORM.include?('darwin'), 'This installer is intended for macOS.')
    check(!system('/usr/bin/pgrep', '-ix', 'BambuStudio|Bambu Studio', out: File::NULL, err: File::NULL), 'Quit Bambu Studio completely (Command-Q) before running the installer.')
    system_dir = File.expand_path('~/Library/Application Support/BambuStudio/system')
    backup_root = File.expand_path('~/Library/Application Support/BambuFilamentPack/Backups')
    layout(system_dir)
    if interactive
      action = prompt('Action', %w[install preview restore cancel], 'install')
      return if action == 'cancel'
      opts[:restore] = action == 'restore'
      opts[:dry_run] = action == 'preview'
      if opts[:restore]
        return unless prompt('Restore last installation?', %w[yes no], 'no') == 'yes'
      else
        opts[:printer] = prompt('Printer', MODELS, 'P1S')
        opts[:nozzle] = prompt('Nozzle (mm)', NOZZLES, '0.4')
        if !opts[:dry_run]
          return unless prompt("Install for #{opts[:printer]} / #{opts[:nozzle]} mm?", %w[yes no], 'yes') == 'yes'
        end
      end
    end
    if opts[:restore]
      restore(system_dir, backup_root, dry_run: opts[:dry_run])
    else
      printer = opts.fetch(:printer, 'P1S')
      nozzle = opts.fetch(:nozzle, '0.4')
      puts "Target: #{printer} / #{nozzle} mm; mode: #{opts[:dry_run] ? 'preview' : 'install'}"
      local = opts[:zip] || File.join(__dir__, ASSET)
      local = nil if !opts[:zip] && !File.file?(local)
      with_package(local) { |pkg| install(pkg, system_dir, backup_root, printer, nozzle, dry_run: opts[:dry_run]) }
    end
  end
end

if $PROGRAM_NAME == __FILE__
  begin
    FilamentPack.main(ARGV)
  rescue StandardError, Interrupt => e
    warn "ERROR: #{e.message}"
    exit 1
  end
end
