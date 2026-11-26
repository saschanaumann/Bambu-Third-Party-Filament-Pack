# Bambu Third-Party Filament Pack — macOS Edition

Native macOS installer for the original **Bambu Third-Party Filament Pack v1.2-beta** by Naumann Consulting / 3D Service. Community profiles for Bambu Lab H2C, P2S, P1S and H2D (0.4 mm / 0.6 mm), including AMS material selection.

**macOS release:** `v1.2-beta.3-macos` (pre-release)  
**Upstream profile data:** `v1.2-beta` (pinned, unchanged)  
**Original project:** [saschanaumann/Bambu-Third-Party-Filament-Pack](https://github.com/saschanaumann/Bambu-Third-Party-Filament-Pack)

[Download macOS release assets](https://github.com/WoozyFace/Bambu-Third-Party-Filament-Pack-MacOS/releases) · [Report an issue](https://github.com/WoozyFace/Bambu-Third-Party-Filament-Pack-MacOS/issues) · [Original Windows releases](https://github.com/saschanaumann/Bambu-Third-Party-Filament-Pack/releases)

## English

### What this does

The original pack makes third-party filament presets available in Bambu Studio's system profile registry, allowing supported materials to be selected in the AMS material menu. This macOS port installs the original profiles for the selected printer and nozzle, including their required base presets. Existing registry entries and files are not overwritten. Inheritance dependencies are resolved from the actual profile metadata; required stock presets must exist in the local Bambu Studio registry. Missing dependencies and conflicting files stop installation before changes. No Windows, Wine, Homebrew, administrator password, or manual JSON editing is required when the macOS system Ruby is available.

This does **not** enable automatic recognition of third-party RFID tags or change AMS firmware. Material and color must still be selected manually when required.

### Compatibility

| Printer | Nozzles | Status |
| --- | --- | --- |
| H2C | 0.4 / 0.6 mm | Upstream profiles physically tested by original author; macOS port needs community validation |
| P2S | 0.4 / 0.6 mm | Upstream profiles physically tested by original author; macOS port needs community validation |
| P1S | 0.4 / 0.6 mm | Beta; earlier macOS method reported working on Intel Mac with P1S 0.4 mm and AMS SA001 |
| H2D | 0.4 / 0.6 mm | Beta; community validation needed |

The revised installer has been tested with the actual checksum-verified upstream archive (3,254 profiles), using simulated Bambu Studio system registries for all eight printer/nozzle combinations. Preview, installation, repeat installation, restore and missing-dependency rejection passed. No physical macOS hardware was used. Intel and Apple Silicon are intended targets; the new installer has not yet been validated on either. Bambu Studio updates can alter the profile layout or replace system presets. Other printers/nozzles are not supported by this release.

### Requirements

- Bambu Studio installed and launched at least once with the intended printer/nozzle configured.
- macOS with Ruby 2.6+ (normally `/usr/bin/ruby`), `curl`, and `unzip`. The installer checks the expected local layout before changes.
- Internet access for automatic acquisition of the exact upstream ZIP, or the original ZIP placed next to the installer for offline use.
- No `sudo` required. Quit Bambu Studio completely with **Command-Q** before installation or restore.

### macOS installation — copy and paste (recommended)

1. Quit Bambu Studio completely (**Command-Q**).
2. Press **Command-Space**, type **Terminal**, and press Return.
3. Copy the entire command below, paste it into Terminal (**Command-V**) and press Return.

```bash
/bin/bash -c 'set -e; d=$(/usr/bin/mktemp -d); cleanup() { /bin/rm -rf -- "$d"; }; trap cleanup EXIT; f="$d/Install-Filament-Pack-macOS.rb"; /usr/bin/curl -fLsS --proto =https --proto-redir =https --retry 2 --connect-timeout 20 --max-time 120 -o "$f" "https://github.com/WoozyFace/Bambu-Third-Party-Filament-Pack-MacOS/releases/download/v1.2-beta.3-macos/Install-Filament-Pack-macOS.rb"; printf "%s  %s\n" "8d0cd5a4b1c9123eecdf7776480ce6f1e2ca999e3ef9dde9ed47a0b1e82fee5f" "$f" | /usr/bin/shasum -a 256 -c -; /usr/bin/ruby "$f"'
```

4. Select `preview` to validate first, or `install`. Choose your printer and nozzle and confirm. Press Return to accept the displayed default.
5. When the installer reports `Installation complete` or `Nothing to install`, reopen Bambu Studio and choose the desired material and color in the AMS device settings. Enable the filament presets if necessary.

The command downloads the versioned Ruby installer from this fork, verifies its SHA-256 before executing it, and removes the temporary installer when finished. The installer then verifies and downloads the original profile archive. No downloaded executable needs to be opened in Finder. This does not disable Gatekeeper or alter macOS security settings; a managed Mac may still enforce its own restrictions. Run only commands from a trusted source. If a checksum fails, stop and report the error.

### Local and offline installation

For advanced users, the ZIP asset contains the same Ruby installer and documentation. Extract it, then run the following in Terminal (adjust the path if necessary):

```bash
cd "$HOME/Downloads/Bambu-Filament-Pack-macOS-v1.2-beta.3"
/usr/bin/ruby Install-Filament-Pack-macOS.rb --printer P1S --nozzle 0.4 --dry-run
/usr/bin/ruby Install-Filament-Pack-macOS.rb --printer P1S --nozzle 0.4
```

### Offline installation

Download the [original v1.2-beta archive](https://github.com/saschanaumann/Bambu-Third-Party-Filament-Pack/releases/download/v1.2-beta/Bambu-Third-Party-Filament-Pack-H2C-P2S-P1S-H2D-v1.2-BETA.zip) while online. Keep the original filename and place it alongside the `.rb` file. The installer automatically uses this local ZIP and verifies the same checksum; no internet access is needed. You can also supply an absolute path with `--zip "/path/to/original.zip"`.

Original archive SHA-256:

```text
4ab267a83105ca9ee026e3b3b8df2dfd6eef1635f8a298b010b2529ed36a789b
```

### Backup and restore

The installer targets only:

```text
~/Library/Application Support/BambuStudio/system/BBL/
~/Library/Application Support/BambuStudio/system/BBL.json
```

Before installing, it backs up both in:

```text
~/Library/Application Support/BambuFilamentPack/Backups/MAC-PRE-INSTALL-.../
```

To undo the last completed installation, quit Bambu Studio and run the same recommended copy-and-paste command again, then select `restore`. With a locally extracted ZIP you can also use:

```bash
/usr/bin/ruby Install-Filament-Pack-macOS.rb --restore --dry-run
/usr/bin/ruby Install-Filament-Pack-macOS.rb --restore
```

Restore is deliberately conservative: it requires the current registry and all added files to match their recorded post-installation checksums. It restores the prior registry and removes only the files added by that installation. If Studio or another installer changed them, automatic restore refuses rather than discarding later changes. Backups remain available for manual recovery. Never delete the entire `system` folder. Repeated installs skip existing files; if upgrading the pack, review the current presets first.

### Windows installation

Windows users should use the original author's [Windows releases](https://github.com/saschanaumann/Bambu-Third-Party-Filament-Pack/releases). Stable v1.1 supports H2C and P2S; the legacy v1.2-beta also introduces P1S and H2D. Close Bambu Studio, extract the original package, run its included installation CMD, then reopen Studio and select the printer/nozzle and AMS material. For rollback, use the upstream `WIEDERHERSTELLEN.cmd`. This fork's macOS ZIP is not a Windows installer.

### Supported manufacturers (upstream v1.2-beta)

Amazon Basics · ANYCUBIC · BioPLA · Breakaway / Support · Eono · ERYONE · FLASHFORGE · GIANTARM · iSANMATE · JAYO · Overture · SMARTFIL · SUNLU · TECBEARS · TINMORRY · WINKLE.

Profiles use manufacturer specifications where available, otherwise appropriate Bambu reference values. Treat them as starting points; calibrate flow, temperature and volumetric speed for your own filament. A custom 1.80 mm Anycubic PLA profile from personal testing is deliberately not bundled: it is not a standard 1.75 mm manufacturer profile and the final calibration is not verified.

### Troubleshooting and feedback

- **Profiles not found:** launch Studio once, select the printer/nozzle, then quit Studio completely.
- **Missing parent / incompatible manifest:** no profile changes are made during validation; share the error, Bambu Studio version, printer and nozzle.
- **Download/checksum error:** use the pinned original ZIP, not a newer upstream release. Do not bypass checksum verification.
- **AMS brand missing:** confirm the correct printer/nozzle, enable presets, and restart Studio. Non-Bambu RFID tags are not automatically recognized by this installer.
- **Update removed presets:** preview and reinstall if the original profile format is still compatible.

Community reports should include macOS version, Intel/Apple Silicon, Bambu Studio version, printer, nozzle, AMS generation, material, selection/persistence/synchronization results, and any error. Do not upload personal configuration or backups containing account data.

## Deutsch

### Installation unter macOS — Kopieren und Einfügen

1. Bambu Studio mindestens einmal starten, Drucker und Düse auswählen und mit **Cmd-Q** vollständig beenden.
2. **Cmd-Leertaste** drücken, `Terminal` eingeben und mit Enter bestätigen.
3. Den vollständigen folgenden Befehl kopieren, mit **Cmd-V** einfügen und Enter drücken:

```bash
/bin/bash -c 'set -e; d=$(/usr/bin/mktemp -d); cleanup() { /bin/rm -rf -- "$d"; }; trap cleanup EXIT; f="$d/Install-Filament-Pack-macOS.rb"; /usr/bin/curl -fLsS --proto =https --proto-redir =https --retry 2 --connect-timeout 20 --max-time 120 -o "$f" "https://github.com/WoozyFace/Bambu-Third-Party-Filament-Pack-MacOS/releases/download/v1.2-beta.3-macos/Install-Filament-Pack-macOS.rb"; printf "%s  %s\n" "8d0cd5a4b1c9123eecdf7776480ce6f1e2ca999e3ef9dde9ed47a0b1e82fee5f" "$f" | /usr/bin/shasum -a 256 -c -; /usr/bin/ruby "$f"'
```

4. `preview` (Vorschau) oder `install` wählen, Drucker und Düse auswählen und bestätigen.
5. Nach erfolgreicher Installation Studio erneut öffnen, Filamentprofile aktivieren und Material/Farbe im AMS einstellen.

Der Befehl lädt den versionsgebundenen Ruby-Installer, prüft dessen SHA-256 und führt ihn erst danach aus. Der Installer lädt und prüft anschließend die Originalprofile. Es ist kein Doppelklick auf eine heruntergeladene ausführbare Datei nötig. Gatekeeper und die macOS-Sicherheitseinstellungen bleiben unverändert. Bei fehlerhafter Prüfsumme nicht fortfahren.

Voraussetzungen: macOS mit Ruby 2.6+, curl und unzip; Internet für die automatische Installation. Für die Offline-Installation siehe die englische Anleitung. Keine Administratorrechte, kein Wine, kein Homebrew erforderlich, sofern System-Ruby verfügbar ist.

### Kompatibilität, Backup und Wiederherstellung

H2C/P2S (0,4/0,6 mm): vom ursprünglichen Entwickler getestet, macOS-Port benötigt weitere Tests. P1S/H2D (0,4/0,6 mm): Beta. Die frühere Methode wurde auf Intel-Mac mit P1S 0,4 mm und AMS SA001 als erfolgreich gemeldet. Der überarbeitete Installer wurde mit dem echten, SHA-256-geprüften Originalarchiv (3.254 Profile) und simulierten Bambu-Studio-Systemregistrierungen für alle acht Drucker-/Düsenkombinationen geprüft; ein Test auf echter Mac-Hardware steht noch aus.

Das Backup liegt unter `~/Library/Application Support/BambuFilamentPack/Backups/`. Für Wiederherstellung Studio beenden, denselben Terminal-Befehl erneut ausführen und `restore` auswählen. Automatische Wiederherstellung wird verweigert, wenn seit der Installation Änderungen an der Registrierung oder den hinzugefügten Profilen vorgenommen wurden. Den vollständigen Studio-Systemordner nicht löschen.

Windows: bitte die [Original-Releases](https://github.com/saschanaumann/Bambu-Third-Party-Filament-Pack/releases) und die dort enthaltene Installations-CMD bzw. `WIEDERHERSTELLEN.cmd` verwenden.

Filamentprofile sind Ausgangswerte und benötigen gegebenenfalls Kalibrierung. Der Installer ändert weder AMS-Firmware noch RFID-Erkennung. Fehlerberichte bitte mit macOS-Version, Prozessorarchitektur, Studio-Version, Drucker, Düse, AMS, Material und Fehlertext einreichen.

## Credits and disclaimer / Danksagung und Hinweis

- Original filament profiles and Windows installer: **Naumann Consulting / 3D Service (saschanaumann)**.
- macOS adaptation: **WoozyFace / EasyComp Zeeland**.
- The original profile data remains hosted by its author. This fork retrieves the pinned original archive rather than republishing it; no upstream redistribution license was verified.
- Independent community project, not affiliated with or endorsed by Bambu Lab. / Unabhängiges Community-Projekt, nicht offiziell von Bambu Lab unterstützt.
