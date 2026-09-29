# Bambu Third-Party Filament Pack – H2C & P2S

Community filament profiles for **Bambu Lab H2C and P2S** with **0.4 mm and 0.6 mm nozzles** and AMS support.

Community-Filamentprofile für **Bambu Lab H2C und P2S** mit **0,4-mm- und 0,6-mm-Düsen** sowie AMS-Unterstützung.

**Current release / Aktuelle Version: v1.1**

---

# 🇬🇧 English

## About

This project provides additional third-party filament profiles for Bambu Studio.

The goal is to make third-party filament manufacturers directly selectable in the AMS material settings without requiring users to manually edit Bambu Studio configuration files.

Version **1.1** adds support for **0.6 mm nozzles** in addition to the existing 0.4 mm profiles.

The profiles were prepared and tested with a focus on:

- Bambu Lab H2C
- Bambu Lab P2S
- 0.4 mm nozzle
- 0.6 mm nozzle
- AMS / AMS 2 Pro
- Bambu Studio 2.8.2.61
- BBL configuration package 2.8.0.6

AMS selection, confirmation and synchronization were successfully tested with multiple third-party filament profiles on P2S and H2C.

---

## Included manufacturers

Version 1.1 includes profiles for:

- Amazon Basics
- ANYCUBIC
- BioPLA
- Breakaway / Support
- Eono
- ERYONE
- FLASHFORGE
- GIANTARM
- iSANMATE
- JAYO
- Overture
- SMARTFIL
- SUNLU
- TECBEARS
- TINMORRY
- WINKLE

---

## Filament parameters

Where reliable official manufacturer specifications were available, these values were used as the basis for the filament profiles.

Where no reliable manufacturer-specific values were available, suitable Bambu Lab material-type reference values were used as a starting point.

This applies to material groups such as:

- PLA
- PLA+
- PETG
- ABS
- ASA
- TPU
- Support materials
- and other supported filament types

Manufacturer variants may require additional calibration depending on printer, nozzle, filament batch and printing conditions.

The profiles should therefore be considered tested starting points rather than a guarantee of optimal settings for every filament spool.

---

## 0.4 mm and 0.6 mm support

Version 1.1 provides printer-specific profiles for both supported nozzle sizes:

**Bambu Lab H2C**
- 0.4 mm
- 0.6 mm

**Bambu Lab P2S**
- 0.4 mm
- 0.6 mm

The corresponding profile is automatically available when the matching printer and nozzle diameter are selected in Bambu Studio.

---

## AMS support

Third-party filament profiles can be selected directly in the AMS material settings.

The workflow was tested with several manufacturers and materials, including:

- ANYCUBIC PETG
- BioPLA PLA Wood
- JAYO PLA
- WINKLE ASA
- SUNLU profiles

Testing included:

- selecting the filament in AMS
- confirming the material
- synchronization with Bambu Studio
- persistence after confirmation
- loading the corresponding printer/nozzle profile

---

## Installation

1. Close Bambu Studio completely.
2. Download the latest release ZIP.
3. Extract the ZIP file.
4. Run:

`INSTALLIEREN-v1.1.cmd`

5. Follow the instructions displayed by the installer.
6. Start Bambu Studio.
7. Select your H2C or P2S and the correct nozzle diameter.
8. Open the AMS material settings and select the desired manufacturer/material.

The installer creates a backup of the affected Bambu Studio profile data before installation.

---

## Restore / Uninstall

If you need to restore the previous configuration, close Bambu Studio and run:

`WIEDERHERSTELLEN.cmd`

The restore function uses the backup created before installation.

---

## Important

Do not delete the complete Bambu Studio `system` directory.

The installer only works with the profile files required by this project.

The public package does not intentionally overwrite the user's complete Bambu Studio configuration.

---

## Compatibility

Major Bambu Studio or BBL configuration updates may change profile structures or compatibility requirements.

After major Bambu Studio updates, compatibility should therefore be checked again before relying on the profiles.

---

## Disclaimer

This is an independent community project.

It is **not an official Bambu Lab product** and is not affiliated with or endorsed by Bambu Lab.

Filament and manufacturer names are used only to identify compatible materials and profiles.

Use the profiles at your own risk. Always observe the filament manufacturer's safety and processing recommendations.

---

# 🇩🇪 Deutsch

## Über das Projekt

Dieses Projekt stellt zusätzliche Filamentprofile von Drittanbietern für Bambu Studio bereit.

Ziel ist es, Filamenthersteller von Drittanbietern direkt in den AMS-Materialeinstellungen auswählen zu können, ohne dass Benutzer die Konfigurationsdateien von Bambu Studio manuell bearbeiten müssen.

Version **1.1** erweitert das bestehende Paket um die Unterstützung für **0,6-mm-Düsen**.

Unterstützt und getestet wurden insbesondere:

- Bambu Lab H2C
- Bambu Lab P2S
- 0,4-mm-Düse
- 0,6-mm-Düse
- AMS / AMS 2 Pro
- Bambu Studio 2.8.2.61
- BBL-Konfigurationspaket 2.8.0.6

AMS-Auswahl, Bestätigung und Synchronisierung wurden mit mehreren Drittanbieter-Filamentprofilen auf P2S und H2C erfolgreich getestet.

---

## Enthaltene Hersteller

Version 1.1 enthält Profile für:

- Amazon Basics
- ANYCUBIC
- BioPLA
- Breakaway / Support
- Eono
- ERYONE
- FLASHFORGE
- GIANTARM
- iSANMATE
- JAYO
- Overture
- SMARTFIL
- SUNLU
- TECBEARS
- TINMORRY
- WINKLE

---

## Filamentparameter

Wo zuverlässige offizielle Herstellerangaben verfügbar waren, wurden diese als Grundlage für die Filamentprofile verwendet.

Wo keine eindeutigen herstellerspezifischen Angaben verfügbar waren, wurden passende Bambu-Lab-Referenzwerte des entsprechenden Materialtyps als Ausgangspunkt verwendet.

Dies betrifft beispielsweise:

- PLA
- PLA+
- PETG
- ABS
- ASA
- TPU
- Supportmaterialien
- weitere unterstützte Filamenttypen

Je nach Hersteller, Filamentvariante, Drucker, Düse, Charge und Druckbedingungen kann eine zusätzliche Kalibrierung erforderlich sein.

Die Profile sind deshalb als getestete Ausgangswerte zu verstehen und nicht als Garantie für optimale Einstellungen bei jeder Filamentrolle.

---

## Unterstützung für 0,4 mm und 0,6 mm

Version 1.1 stellt druckerspezifische Profile für beide unterstützten Düsengrößen bereit:

**Bambu Lab H2C**
- 0,4 mm
- 0,6 mm

**Bambu Lab P2S**
- 0,4 mm
- 0,6 mm

Bei Auswahl des entsprechenden Druckers und Düsendurchmessers in Bambu Studio steht das dazugehörige Filamentprofil zur Verfügung.

---

## AMS-Unterstützung

Die Drittanbieter-Filamentprofile können direkt in den AMS-Materialeinstellungen ausgewählt werden.

Der Ablauf wurde mit mehreren Herstellern und Materialien getestet, unter anderem:

- ANYCUBIC PETG
- BioPLA PLA Wood
- JAYO PLA
- WINKLE ASA
- SUNLU Profile

Geprüft wurden:

- Auswahl des Filaments im AMS
- Bestätigung des Materials
- Synchronisierung mit Bambu Studio
- Erhalt des Profils nach der Bestätigung
- Laden des passenden Drucker-/Düsenprofils

---

## Installation

1. Bambu Studio vollständig schließen.
2. Die ZIP-Datei des aktuellen Releases herunterladen.
3. ZIP-Datei entpacken.
4. Folgende Datei starten:

`INSTALLIEREN-v1.1.cmd`

5. Den Anweisungen des Installers folgen.
6. Bambu Studio starten.
7. H2C oder P2S und den richtigen Düsendurchmesser auswählen.
8. AMS-Materialeinstellungen öffnen und gewünschten Hersteller bzw. Material auswählen.

Vor der Installation erstellt der Installer eine Sicherung der betroffenen Bambu-Studio-Profildaten.

---

## Wiederherstellung

Soll die vorherige Konfiguration wiederhergestellt werden, Bambu Studio vollständig schließen und folgende Datei starten:

`WIEDERHERSTELLEN.cmd`

Die Wiederherstellung verwendet die vor der Installation erstellte Sicherung.

---

## Wichtig

Nicht den kompletten `system`-Ordner von Bambu Studio löschen.

Der Installer arbeitet ausschließlich mit den für dieses Projekt erforderlichen Profildaten.

Das öffentliche Paket ist nicht dafür vorgesehen, die vollständige persönliche Bambu-Studio-Konfiguration des Benutzers zu überschreiben.

---

## Kompatibilität

Größere Aktualisierungen von Bambu Studio oder des BBL-Konfigurationspakets können die Profilstruktur oder Kompatibilität verändern.

Nach größeren Bambu-Studio-Updates sollte deshalb die Kompatibilität erneut geprüft werden.

---

## Haftungsausschluss

Dies ist ein unabhängiges Community-Projekt.

Es handelt sich **nicht um ein offizielles Produkt von Bambu Lab** und es besteht keine Verbindung, Partnerschaft oder Unterstützung durch Bambu Lab.

Filament- und Herstellernamen dienen ausschließlich der Identifikation der entsprechenden Materialien und Profile.

Die Verwendung erfolgt auf eigene Verantwortung. Sicherheits- und Verarbeitungshinweise der jeweiligen Filamenthersteller sind zu beachten.

---

## Credits

Developed and tested as a community project by **Naumann Consulting / 3D Service**.

Entwickelt und getestet als Community-Projekt von **Naumann Consulting / 3D Service**.
