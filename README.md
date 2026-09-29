# Bambu Third-Party Filament Pack – H2C & P2S

Community filament profiles for **Bambu Lab H2C and P2S** with **0.4 mm nozzle** and AMS support.

## About

This project provides additional third-party filament profiles for Bambu Studio.

The goal is to make third-party filament manufacturers directly selectable in the AMS material settings without requiring users to manually edit Bambu Studio configuration files.

The profiles were prepared and tested with a focus on:

- Bambu Lab H2C
- Bambu Lab P2S
- 0.4 mm nozzle
- AMS / AMS 2 Pro
- Bambu Studio 2.8.2.61
- BBL configuration package 2.8.0.6

## Included manufacturers

Version 1.0 includes profiles for:

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

The v1.0 package contains **1,124 registered profile files**.

## Installation

1. Download the latest ZIP package from the **Releases** section.
2. Extract the ZIP completely.
3. Close Bambu Studio completely.
4. Double-click:

   `INSTALLIEREN-v1.0.cmd`

5. Follow the instructions in the installer window.
6. A successful installation will display:

   `INSTALLATION ERFOLGREICH - v1.0`

   `Registrierte Profile: 1124`

7. Start Bambu Studio.
8. Open the AMS material settings and select the desired manufacturer and filament.

No permanent change to the Windows PowerShell execution policy is required.

## Automatic backup

Before making changes, the installer automatically creates a **PRE-INSTALL backup**.

The backup contains the affected Bambu Studio profile data:

- `BambuStudio\system\BBL`
- `BambuStudio\system\BBL.json`

The package does **not** distribute or modify the user's `BambuStudio.conf`.

## Restore

If you want to return to the state before installation:

1. Close Bambu Studio completely.
2. Run:

   `WIEDERHERSTELLEN.cmd`

3. The latest PRE-INSTALL backup will be restored.

## Tested

Version 1.0 was tested on a clean installation using:

| Component | Tested version |
|---|---|
| Bambu Studio | 2.8.2.61 |
| BBL configuration package | 2.8.0.6 |
| Printer | Bambu Lab P2S |
| Nozzle | 0.4 mm |
| AMS | Yes |

Functional AMS tests included, among others:

- BioPLA PLA Wood
- ANYCUBIC PETG
- WINKLE ASA

The profiles remained assigned after confirmation in the AMS material settings and were correctly transferred to the project filament selection.

## Important

Filament behavior can vary depending on:

- filament color
- production batch
- printer
- nozzle
- environmental conditions
- manufacturer changes

These profiles should therefore be considered **starting points** and not a guarantee of optimal print results.

After major Bambu Studio or BBL configuration package updates, compatibility should be tested again before installation.

## Compatibility

The current release has been specifically prepared and tested for **H2C / P2S with 0.4 mm nozzle**.

Support for other Bambu Lab printers or nozzle sizes is not guaranteed by this release.

## Disclaimer

This is an independent community project.

It is not an official Bambu Lab product and is not affiliated with or endorsed by Bambu Lab or the listed filament manufacturers.

All trademarks and product names belong to their respective owners and are used only to identify compatible products.

Use of the profiles and installer is at your own risk.

## Version

**v1.0 – Initial public release**

Developed and tested as a community project by **Naumann Consulting / 3D Service**.
