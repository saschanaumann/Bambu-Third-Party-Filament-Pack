# Bambu Third-Party Filament Pack – H2C, P2S, P1S & H2D

Community filament profiles for **Bambu Lab H2C, P2S, P1S and H2D** with **0.4 mm and 0.6 mm nozzles** and AMS support.

Community-Filamentprofile für **Bambu Lab H2C, P2S, P1S und H2D** mit **0,4-mm- und 0,6-mm-Düsen** sowie AMS-Unterstützung.

**Stable release / Stabile Version: v1.1**  
**Current beta / Aktuelle Beta: v1.2-beta**

> ⚠️ **P1S and H2D support is currently BETA and requires community testing.**  
> ⚠️ **Die Unterstützung für P1S und H2D befindet sich aktuell in der BETA und benötigt Community-Tests.**

---

# 🇬🇧 English

## About

This project provides additional third-party filament profiles for Bambu Studio.

The goal is to make third-party filament manufacturers directly selectable in the AMS material settings without requiring users to manually edit Bambu Studio configuration files.

Version **1.1** added support for **0.6 mm nozzles** for H2C and P2S.

Version **1.2 BETA** additionally introduces profiles for **Bambu Lab P1S and H2D** with 0.4 mm and 0.6 mm nozzles.

---

## Printer support

### ✅ Physically tested

- Bambu Lab H2C – 0.4 mm
- Bambu Lab H2C – 0.6 mm
- Bambu Lab P2S – 0.4 mm
- Bambu Lab P2S – 0.6 mm

AMS selection, confirmation and synchronization were successfully tested with multiple third-party filament profiles on H2C and P2S.

### 🧪 BETA – community testing required

- Bambu Lab P1S – 0.4 mm
- Bambu Lab P1S – 0.6 mm
- Bambu Lab H2D – 0.4 mm
- Bambu Lab H2D – 0.6 mm

The P1S and H2D profiles are included in **v1.2-beta**, but have not yet been physically tested by the project author because these printers are not available for testing.

**P1S and H2D owners are invited to test the profiles and provide feedback.**

---

## Supported manufacturers

The package currently includes profiles for 16 third-party manufacturers:

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

Where reliable official manufacturer specifications are available for a specific filament or material variant, these values are used as the basis for the profile.

Where no reliable manufacturer-specific values are available, suitable Bambu Lab reference values for the corresponding material type are used as a starting point.

This means that not every value in every profile should be interpreted as an original manufacturer specification.

The profiles are intended as tested or prepared starting points. Depending on the filament, batch, printer and printing conditions, additional calibration may be required.

---

## AMS support

The project is designed to allow supported third-party filament manufacturers to be selected directly in the AMS material settings.

Successfully tested on H2C and P2S:

- Material selection
- Confirmation and persistence
- AMS synchronization with Bambu Studio
- Printer/nozzle-specific profile loading

Tested filament examples include:

- ANYCUBIC PETG
- BioPLA PLA Wood
- JAYO PLA
- WINKLE ASA
- SUNLU profiles

---

## Installation

### Stable v1.1

Use v1.1 if you have:

- Bambu Lab H2C
- Bambu Lab P2S

with 0.4 mm or 0.6 mm nozzle.

### Beta v1.2

Use v1.2-beta if you want to test:

- Bambu Lab P1S
- Bambu Lab H2D

The existing H2C and P2S profiles are also included.

### Installation steps

1. Close Bambu Studio completely.
2. Download the desired ZIP package from the Releases section.
3. Extract the ZIP file.
4. Run the included installation CMD file.
5. Start Bambu Studio.
6. Select the correct printer and nozzle diameter.
7. Select the desired third-party filament in the AMS material settings.

The installer creates a backup of the affected Bambu Studio profile data before installation.

---

## Restore

If you want to return to the previous Bambu Studio filament configuration, use the included:

`WIEDERHERSTELLEN.cmd`

Do **not** manually delete the complete Bambu Studio `system` directory.

---

## v1.2 BETA testers wanted

If you own a **Bambu Lab P1S or H2D**, your help is welcome.

Please test:

- 0.4 mm and/or 0.6 mm nozzle
- AMS material selection
- Whether the selected filament remains after confirmation
- Synchronization with Bambu Studio
- Correct filament profile loading

When reporting a test, please include:

- Printer model
- Nozzle size
- Bambu Studio version
- AMS / AMS 2 Pro
- Filament manufacturer
- Material
- Whether selection and synchronization worked
- Screenshot or error message if something failed

---

# 🇩🇪 Deutsch

## Über das Projekt

Dieses Projekt stellt zusätzliche Filamentprofile von Drittanbietern für Bambu Studio bereit.

Ziel ist es, Filamente verschiedener Hersteller direkt in den AMS-Materialeinstellungen auswählen zu können, ohne dass Anwender die Konfigurationsdateien von Bambu Studio manuell bearbeiten müssen.

Mit Version **1.1** wurde die Unterstützung für **0,6-mm-Düsen** auf H2C und P2S ergänzt.

Version **1.2 BETA** erweitert das Paket zusätzlich um Profile für **Bambu Lab P1S und H2D** mit 0,4-mm- und 0,6-mm-Düsen.

---

## Drucker-Unterstützung

### ✅ Von mir physisch getestet

- Bambu Lab H2C – 0,4 mm
- Bambu Lab H2C – 0,6 mm
- Bambu Lab P2S – 0,4 mm
- Bambu Lab P2S – 0,6 mm

AMS-Auswahl, Bestätigung, Speicherung und Synchronisierung wurden mit mehreren Drittanbieter-Filamenten erfolgreich auf H2C und P2S getestet.

### 🧪 BETA – Community-Tester gesucht

- Bambu Lab P1S – 0,4 mm
- Bambu Lab P1S – 0,6 mm
- Bambu Lab H2D – 0,4 mm
- Bambu Lab H2D – 0,6 mm

Die P1S- und H2D-Profile sind in **v1.2-beta** enthalten, konnten vom Projektentwickler jedoch noch nicht physisch getestet werden, da diese Drucker nicht zur Verfügung stehen.

**Besitzer eines P1S oder H2D sind ausdrücklich eingeladen, die Profile zu testen und Rückmeldung zu geben.**

---

## Unterstützte Hersteller

Aktuell sind Profile für 16 Drittanbieter enthalten:

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

Soweit für ein bestimmtes Filament bzw. eine Materialvariante zuverlässige offizielle Herstellerangaben verfügbar sind, werden diese als Grundlage für das Profil verwendet.

Wo keine zuverlässigen herstellerspezifischen Angaben verfügbar sind, dienen passende Bambu-Lab-Referenzwerte des entsprechenden Materialtyps als Ausgangspunkt.

Daher sollten nicht sämtliche Werte aller Profile als originale Herstellerangaben verstanden werden.

Die Profile sind als getestete bzw. vorbereitete Ausgangswerte gedacht. Je nach Filament, Charge, Drucker und Druckbedingungen kann eine zusätzliche Kalibrierung erforderlich sein.

---

## AMS-Unterstützung

Das Projekt ermöglicht die direkte Auswahl unterstützter Drittanbieter-Filamente in den AMS-Materialeinstellungen.

Auf H2C und P2S erfolgreich getestet:

- Materialauswahl
- Bestätigung und dauerhafte Speicherung
- Synchronisierung mit Bambu Studio
- korrektes Laden des drucker- und düsenspezifischen Profils

Getestete Beispiele:

- ANYCUBIC PETG
- BioPLA PLA Wood
- JAYO PLA
- WINKLE ASA
- SUNLU Profile

---

## Installation

### Stabile Version v1.1

Verwende v1.1 für:

- Bambu Lab H2C
- Bambu Lab P2S

mit 0,4-mm- oder 0,6-mm-Düse.

### Beta-Version v1.2

Verwende v1.2-beta, wenn du die neuen Profile für folgende Drucker testen möchtest:

- Bambu Lab P1S
- Bambu Lab H2D

Die bestehenden H2C- und P2S-Profile sind ebenfalls enthalten.

### Installation

1. Bambu Studio vollständig schließen.
2. Gewünschte ZIP-Datei im Bereich „Releases“ herunterladen.
3. ZIP-Datei vollständig entpacken.
4. Die enthaltene Installations-CMD starten.
5. Bambu Studio starten.
6. Richtigen Drucker und Düsendurchmesser auswählen.
7. Gewünschtes Drittanbieter-Filament in den AMS-Materialeinstellungen auswählen.

Vor der Installation wird automatisch ein Backup der betroffenen Bambu-Studio-Profildaten erstellt.

---

## Wiederherstellung

Um zur vorherigen Bambu-Studio-Filamentkonfiguration zurückzukehren, die enthaltene Datei

`WIEDERHERSTELLEN.cmd`

verwenden.

**Nicht den kompletten `system`-Ordner von Bambu Studio manuell löschen.**

---

## 🧪 Tester für v1.2 BETA gesucht

Wenn du einen **Bambu Lab P1S oder H2D** besitzt, kannst du das Projekt unterstützen.

Bitte teste insbesondere:

- 0,4-mm- und/oder 0,6-mm-Düse
- Auswahl des Filaments im AMS
- ob das Filament nach der Bestätigung ausgewählt bleibt
- Synchronisierung mit Bambu Studio
- korrektes Laden des Filamentprofils

Bei einer Rückmeldung bitte möglichst angeben:

- Druckermodell
- Düsengröße
- Bambu-Studio-Version
- AMS / AMS 2 Pro
- Filamenthersteller
- Material
- ob Auswahl und Synchronisierung funktioniert haben
- bei Fehlern möglichst Screenshot oder Fehlermeldung

---

## Disclaimer / Hinweis

This is an independent community project and is **not affiliated with or endorsed by Bambu Lab**.

Dies ist ein unabhängiges Community-Projekt und **kein offizielles Projekt oder Produkt von Bambu Lab**.

---

## Credits

Developed and tested as a community project by **Naumann Consulting / 3D Service**.

Entwickelt und getestet als Community-Projekt von **Naumann Consulting / 3D Service**.
