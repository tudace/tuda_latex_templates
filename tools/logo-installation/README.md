# TU Darmstadt Logo Bundle

This is the source to create the logo installation bundle. As soon as it is published via TUDa internal structures we will provide the information here. This directory on GitHub does not include the actual logo files.

----------------

[English version below](#tu-darmstadt-logo-installation)

# Installationsanleitung TU Darmstadt Logos

Leider dürfen die Logo-Dateien nicht mit TUDa-CI verteilt werden.
Wir versuchen die Installation soweit wie möglich zu vereinfachen und stellen daher dieses Installationspaket zur Verfügung.

Es gibt mehrere Möglichkeiten, die normalerweise die Nutzung eines Terminals benötigen.
Unter Windows existiert zusätzlich ein Batch-Script um die Installation auch durch eine anklickbare Datei durchzuführen.
Diese führt allerdings diesselben Aktionen aus.

* [Klickbare Installation unter Windows](#klickbare-installation-unter-windows)
* [Installation mit l3build](#klickbare-installation-unter-windows)
<!--* [Manuelles Installation](#manuelle-installation)-->

## Klickbare Installation unter Windows

Das Paket enthält die Script-Datei `./l3build_install.bat`.
Beim Ausführen startet sie automatisch die Installation über l3build im Verzeichnis der aktuellen Nutzer*in.
Dieser Weg benötigt keine Admin-Rechte.
Es muss lediglich das LaTeX-Paket `l3build` installiert und ausführbar sein.
Bei vollständigen TeX Live installationen ist dies ohnehin der Fall.
Ansonsten kann sowohl bei TeX Live, wie auch bei MikTeX l3build über den Paketmanager installiert werden.

Die Datei kann über einen Doppelklick ausgeführt werden.

Das Script kopiert die Logo-Dateien an die richtig Stelle in das sogenannte `$TEXMFHOME`-Verzeichnis.
Dieses liegt normalerweise unter `C:\Benutzer\<Nutzername>\texmf` und dort können die LaTeX-Compiler sie dann finden.

## Installation mit l3build (Alle Betriebssysteme)

Das Paket enthält eine `build.lua` Konfigurationsdatei, die weiß wohin welche Dateien installiert werden müssen.
Es genügt das Ausführen von

```shell
l3build install
```

im Basisverzeichnis dieses Pakets über ein Terminal. Diese Variante der Installtion gilt nur für die Benutzer*in, die das Kommando ausgeführt hat. Für eine Systemweite Installation ist etwas mehr notwendig.
Das ist im folgenden Abschnitt beschrieben.

### Systemweite Installation in TEXMFLOCAL

Statt `l3build install` wird hier nicht in TEXMFHOME im Nutzer*innenverzeichnis installiert, sondern im globalen `$TEXMFLOCAL`.
Dort kann es durch alle Nutzer*innen des Systems gefunden werden.

```shell
sudo l3build install --texmfhome "$(kpsewhich --var-value TEXMFLOCAL)"
sudo mktexlsr
```

Auf Windows-Systemen muss man vermutlich bei kpsewhich die Endung `.exe` mit angeben und das Kommando als Administrator ausführen:

```shell
l3build uninstall --texmfhome $(kpsewhich.exe --var-value TEXMFLOCAL)
l3build install --texmfhome $(kpsewhich.exe --var-value TEXMFLOCAL)
mktexlsr
``

# TU Darmstadt Logo installation

The logo sadly may not be included in the release of TUDa-CI.
Therefore we provide this bundle to help you to install the logo file permanently in your TeX Distribution.

## Clickable-installation on Windows

As some Windows users are scared of Terminal usage we provide a batch script to simplify the installation procedure.
Just start the batch script `./l3build_install.bat` by double-clicking the file.
It will copy the logo files from this bundle into your `TEXMFHOME` directory. This is usually located in `C:\Users\<User>\texmfhome`.
The LaTeX compilers will then be able to find it.

The alternative `l3build_install_admin.bat` can be used for a system wide installation as described in [System Wide Installation](#system-wide-installation-in-texmflocal) but may require to be run as admin.

## Installation

Run the following command in a terminal while inside the directory of this installation bundle.

```shell
l3build install
```

This will install the files to be accessible by the user. In case you want to install them system wide have a look at the following instructions.

### System wide installation in TEXMFLOCAL

```shell
sudo l3build install --texmfhome "$(kpsewhich --var-value TEXMFLOCAL)"
sudo texhash
```

On Windows based systems one might need to restructure these commands to run in an Admin shell:

```shell
l3build uninstall --texmfhome $(kpsewhich.exe --var-value TEXMFLOCAL)
l3build install --texmfhome $(kpsewhich.exe --var-value TEXMFLOCAL)
texhash
``
