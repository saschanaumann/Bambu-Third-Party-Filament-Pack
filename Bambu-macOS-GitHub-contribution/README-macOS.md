# macOS installation / Installation unter macOS (beta)

Native macOS installer for the **v1.2-beta** release of [Bambu Third-Party Filament Pack](https://github.com/saschanaumann/Bambu-Third-Party-Filament-Pack). The original Windows installer and the supplied filament settings are unchanged.

## English

### Requirements

- macOS with Ruby 2.6 or later available at `/usr/bin/ruby` (or run the Ruby script with your installed Ruby).
- Bambu Studio, launched at least once and then fully quit with Command-Q.
- The extracted **v1.2-beta** release ZIP, containing `manifest.json` and `Profiles/`.
- No administrator privileges, Windows, Wine, PowerShell or Homebrew required when system Ruby is available.

### Installation

1. Download and extract [v1.2-beta](https://github.com/saschanaumann/Bambu-Third-Party-Filament-Pack/releases/tag/v1.2-beta).
2. Copy `Install-Filament-Pack-macOS.command` and `Install-Filament-Pack-macOS.rb` into the extracted directory next to `manifest.json`.
3. Quit Bambu Studio completely. Open Terminal, change to the extracted directory (type `cd ` and drag the folder into Terminal), then run:

```bash
/bin/bash ./Install-Filament-Pack-macOS.command . --printer P1S --nozzle 0.4 --dry-run
/bin/bash ./Install-Filament-Pack-macOS.command . --printer P1S --nozzle 0.4
```

4. Restart Bambu Studio. Select the correct printer/nozzle and enable the desired third-party presets in the filament selection interface.

The default printer/nozzle is P1S/0.4. The installer also accepts H2C, P2S and H2D and 0.6 mm where included in the pack; these combinations are **not yet confirmed on macOS**. Run the dry-run first. To use a separately installed Ruby, run `ruby Install-Filament-Pack-macOS.rb --dry-run /path/to/extracted-pack` with the appropriate printer/nozzle options.

### Safety and backups

- The installer adds missing entries and their base profiles to `~/Library/Application Support/BambuStudio/system/BBL.json` and `system/BBL/`.
- Existing registered names/paths and existing profile files are skipped. This is intentionally not an upgrade or repair mechanism for conflicting profiles.
- It validates source JSON and dependencies before changes, creates a timestamped backup of `BBL` and `BBL.json` outside the repository at `~/Library/Application Support/BambuFilamentPack/Backups/`, and writes the registry using an atomic rename.
- Dry-run makes no changes. Bambu Studio updates may replace these system profiles.
- Do not commit your backups, local configuration or personal logs to GitHub.

### Manual restore

Quit Bambu Studio. In Finder choose Go > Go to Folder and open `~/Library/Application Support/BambuStudio/system/`. Move the current `BBL` folder and `BBL.json` to a separate safe directory (do not merge directories). Copy the matching `BBL` folder and `BBL.json` from a single pre-installation backup back into `system/`. Restart Bambu Studio. This restores the previous snapshot and will remove system-profile changes made after that snapshot. Do not delete the entire `system` directory.

### Community testing

The initial add-only installation procedure was successfully run on an **Intel Mac (x86_64), Bambu Lab P1S, 0.4 mm nozzle, original AMS (SA001)** with v1.2-beta. Its log reported 354 printer-specific entries and 354 base entries considered, 701 added and 7 skipped. The user confirmed that installation worked. This does not establish successful printing with every preset, AMS synchronization for every material, or compatibility with Apple Silicon. The packaged installer adds validation, dry-run and printer selection; these changes need native macOS retesting. Exact macOS and Bambu Studio versions were not recorded.

## Deutsch

### Voraussetzungen und Installation

macOS mit Ruby (mindestens 2.6), Bambu Studio und das entpackte ZIP-Archiv der Version **v1.2-beta**. Beide Installationsdateien neben `manifest.json` und dem Ordner `Profiles/` ablegen. Bambu Studio vollständig mit Cmd-Q beenden. Im Terminal in den entpackten Ordner wechseln und zuerst den Testlauf, danach die Installation ausführen:

```bash
/bin/bash ./Install-Filament-Pack-macOS.command . --printer P1S --nozzle 0.4 --dry-run
/bin/bash ./Install-Filament-Pack-macOS.command . --printer P1S --nozzle 0.4
```

Anschließend Bambu Studio starten und die gewünschten Filamentprofile aktivieren. Weitere Druckermodelle (H2C, P2S, H2D) und 0,6-mm-Düsen sind auswählbar, wurden unter macOS jedoch noch nicht bestätigt. Keine Administratorrechte und keine Windows-Umgebung notwendig, sofern Ruby verfügbar ist.

Vorhandene Profile werden nicht überschrieben. Ein Backup von `BBL` und `BBL.json` wird unter `~/Library/Application Support/BambuFilamentPack/Backups/` gespeichert. Für eine Wiederherstellung Bambu Studio beenden, die aktuellen Dateien `BBL` und `BBL.json` aus `~/Library/Application Support/BambuStudio/system/` separat sichern und beide aus demselben Backup zurückkopieren. Nicht den gesamten `system`-Ordner löschen. Updates von Bambu Studio können die installierten Systemprofile ersetzen.

Der ursprüngliche Installationsablauf wurde auf einem **Intel-Mac (x86_64) mit P1S, 0,4-mm-Düse und AMS SA001** erfolgreich ausgeführt (701 Einträge hinzugefügt, 7 übersprungen). Die erweiterte Skriptversion und weitere Plattformen benötigen zusätzliche Tests. Die Installation allein bestätigt noch keine Druckqualität oder vollständige AMS-Synchronisierung.
