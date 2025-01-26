# TUDa-CI – Corporate Design LaTeX-Templates for TU Darmstadt

Copyright (C) Marei Peischl <marei@peitex.de>, 2018–2025

tuda-ci v4.00 (2025-01-26)

***************************************************************************

This material is subject to the LaTeX Project Public License version 1.3c
or later. See http://www.latex-project.org/lppl.txt for details.

***************************************************************************

[Link to the github repository](https://github.com/tudace/tuda_latex_templates)

[English version below](#summary)

## Zusammenfassung

Das TUDa-CI-Bundle ist die Umsetzung des Corporate Designs der TU Darmstadt in LaTeX.
Es liefert neben den Klassen-, Paket- und Konfigurationsdateien auch Anwenderdokumentation in Form von Templatedateien für verschiedene Dokumententypen.

Das Gesamtpaket wurde in Teilen inspiriert von Clemens von Loewenichs and Joe Werners TUD-Design Paket.

Die Beispieldateien existieren auf Deutsch und Englisch.
Im CTAN Release sind nur die Englischsprachigen Dateien enthalten.
Die Deutschsprachigen sind unter sind im [GitHub Repository](https://github.com/tudace/tuda_latex_templates/tree/main/examples) zu finden.

## Support und Hilfe

Die ULB bietet über das Team Infokompetenz LaTeX-Support und insbesondere Hilfe bei der Verwendung von TUDa-CI an. (https://www.ulb.tu-darmstadt.de/finden_nutzen/medien_nutzen/dokumente_erstellen/latex/index.de.jsp). Darüber hinaus findet auch die Sprechstunde wieder statt und bietet die Möglichkeit individuelle Fragestellungen zu bearbeiten.
Die Termine zu allen Lernformaten finden sich auf der [Website der ULB](https://www.ulb.tu-darmstadt.de/lernen_arbeiten/lehr_und_lernformate/textverarbeitung/textverarbeitung.de.jsp).

## Verwendungshinweis

Die Richtlinien des Corporate Designs (https://www.intern.tu-darmstadt.de/media/medien_stabsstelle_km/services/medien_cd/das_bild_der_tu_darmstadt.pdf), sowie die Anforderungen der Universitätsbibliothek erfordern einige spezielle Konfigurationen. Beispielsweise ist für wissenschaftliche Veröffentlichungen und Abschlussarbeiten die Erzeugung einer archivierbaren PDF-Datei (PDF/A) vorgesehen.
Dies ist mit aktuellen LaTeX-Paketen und dem Compiler LuaLaTeX deutlich besser umzusetzen, als mit älteren Formaten.
Aus diesem Grund sollten Sie vor der Verwendung von TUDa-CI Ihre TeX-Distribution aktualisieren und nach Möglichkeit LuaLaTeX als Compiler verwenden.
Die Nutzung anderer Kompilierungsprogramme ist grundsätzlich möglich, allerdings werden dann ggf. nicht alle Funktionen unterstützt.
Weitere Hinweise finden sich in den Beispieldateien dokumentiert. Diese sind auch als kompilierte PDFs auf [CTAN](http://mirror.ctan.org/macros/latex/contrib/tuda-ci/doc) oder – falls das Paket installiert ist – im ensprechenden Doku-Verzeichnis (<Pfad zu Ihrer LaTeX-Installation>/doc/latex/tuda-ci) verfügbar.

## Abhängigkeiten

Das Bundle verwendet Pakete der Standard-LaTeX-Distributionen. Bei der Verwendung von paketierten Versionen über die Linux-Paketverwaltung kann dies ggf. zu Schwierigkeiten führen.

## Installation

TUDa-CI ist Bestandteil der beiden populären TeX Distributionen ([MikTeX](https://miktex.org/download) & [TeX Live](https://tug.org/texlive/), und damit auch im MacTeX-Paket).
Es ist somit möglich die Templates über die TeX Distribution zu installieren und zu updaten.

Bei TeX Live werden Updates und Paketinstalation durch das Programm „TeX Live Manager“ (tlmgr) ausgeführt. Das Analogon unter MikTeX heißt „MikTeX Console”.
Unter Mac und Windows existieren bei Standardeinstellungen auch grafische Nutzeroberflächen, die durch das Update/die Installation führen.

Falls Sie noch keine Distribution installiert haben, finden Sie die notwendigen Informationen zur Installation von TeX Live unter:

- Windows/Linux https://tug.org/texlive/acquire-netinstall.html
- MacTeX http://tug.org/mactex/

#### Sonderfall: Paketverwaltung des Betriebssystems (Linux/BSD)

Für einige Linux/BSD-Varianten existieren texlive-Pakete die über die Paketverwaltung des Systems installierbar sind.
Da TUDa-CI sehr speziell ist, ist es meistens nur in der Paketen _texlive-full_ enthalten.
Allerdings sind die in den Paketverwaltungen enthalten TeX Live Versionen häufig stark veraltet und die Logo-Dateien müssen ohnehin zusätzlich installiert werden.
Wir empfehlen daher die Installation von TeX Live über den TeX Live Manager: https://tug.org/texlive/doc/texlive-en/texlive-en.html#installation.

### Nutzung von TUDa-CI über Overleaf

Die TUDa verfügt über eine eigene Overleaf-Installation, auf die alle Mitglieder Zugriff haben. Die DEMO-Dateien werden dort in der jeweils aktuellen Version als Templates bereitgestellt: https://sharelatex.tu-darmstadt.de/templates/all
Somit ist eine Nutzung ohne lokale Installation möglich.

### Logos & verwendete Bilddateien

Die verwendeten Logos sind nicht Bestandteil dieses Bundles und können von Mitgliedern der TU Darmstadt über das interne Netzwerk heruntergeladen werden.

Der Download sowie ein Paket, mit Installtionsskripten für die permanente Installation der Logodateien findet sich auf der (zugehörige Seite der ULB)[https://www.ulb.tu-darmstadt.de/finden_nutzen/medien_nutzen/dokumente_erstellen/latex/index.de.jsp].

Für Nicht-Mitglieder ist eine Möglichkeit zur Platzierung eines Ersatzlogos dokumentiert und es existiert die Möglichkeit Fehlende Logos per Option zu ignorieren.

## Enthaltene Templatedateien

Eine vollständige Liste aller Dateien, die zu diesem Projekt gehören kann findet sich in `MANIFEST.md`.

| Dokumententyp                         | Templatedatei(en)                                                              | Dokumentenklasse                          |
| ------------------------------------- | ------------------------------------------------------------------------------ | ----------------------------------------- |
| Interne Berichte (minimales template) | DEMO-TUDaReport.tex                                                            | tudapub.cls mit tudasize9pt.clo           |
| Wissenschaftliche Artikel             | DEMO-TUDaPub.tex, verwendet auch DEMO-TUDaBibliography.bib                     | tudapub.cls                               |
| Abschlussarbeiten                     | DEMO-TUDaThesis.tex/DEMO-TUDaPhD.tex, verwendet auch DEMO-TUDaBibliography.bib | tudapub.cls mit tudathesis.cfg            |
| Wissenschaftliche Poster              | DEMO-TUDaSciPoster.tex                                                         | tudasciposter.cls                         |
| Veranstaltungsankündigungen           | DEMO-TUDaPoster.tex                                                            | tudaposter.cls                            |
| Ausschreibungen                       | DEMO-TUDaAnnouncement.tex                                                      | tudaposter.cls                            |
| Präsentationen                        | DEMO-TUDaBeamer.tex                                                            | tudabeamer.cls                            |
| Briefe                                | DEMO-TUDaLetter.tex, verwendet auch DEMO-TUDaFromaddress.lco                   | tudaletter.cls mit tudalettersize10pt.clo |
| Übungsblätter                         | DEMO-TUDaExercise.tex                                                          | tudaexercise.cls                          |
| Flyer/Faltblätter                     | DEMO-TUDaLeaflet.tex                                                           | tudaleaflet.cls                           |

Darüber hinaus existieren deutschsprachige Versionen der Template-Dateien im [GitHub Repository](https://github.com/tudace/tuda_latex_templates) sowie spezielle Anwendungsbeispiele:

Kompatibilitätsmodus TUDexercise: (Examples-TUDexercise-compat.tex)[https://github.com/tudace/tuda_latex_templates/blob/master/exercises/Examples-TUDexercise-compat.tex]
Farbskalen von tuda-pgfplots: (Examples-TUDa-pgfplots.tex)[https://github.com/tudace/tuda_latex_templates/blob/master/exercises/Examples-TUDa-pgfplots.tex]

# Summary

The TUDa-CI-Bundle provides a possibility to use the Corporate Design of TU Darmstadt in LaTeX.
Therefore it contains documentclasses as well as some helper packages and config files together with some templates for user documentation, which currently are only available in German.

If you are not a German speaker and require some help using these files, please feel free to contact the maintainers.

## Support

ULB is offering support for LaTeX in general and TUDa-CI. Contact email address can be found at https://www.ulb.tu-darmstadt.de/finden_nutzen/medien_nutzen/dokumente_erstellen/latex/index.en.jsp. Additionally there is a TeXnical office hour. Questions can also be answered in English. The dates can be found at https://www.ulb.tu-darmstadt.de/lernen_arbeiten/lehr_und_lernformate/textverarbeitung/textverarbeitung.en.jsp searching for “TeXnische Sprechstunde”.

## Installation

TUDa-CI is part of the popular TeX distributions ([MikTeX](https://miktex.org/download) & [TeX Live](https://tug.org/texlive/), which is included by [MacTeX](https://www.tug.org/mactex/)).
It's possible to install the templates using the TeX Live Manager or the MikTeX Console.

In case you don't have any installed TeX system the following links might be useful:

- Windows/Linux https://tug.org/texlive/acquire-netinstall.html
- MacTeX http://tug.org/mactex/

It's also possible to use the TUDa-CI-DEMO files as Overleaf-Templates on TUDa's own installation: https://sharelatex.tu-darmstadt.de/templates/all (requires TUDa Account)

#### Remark on texlive packages provided by Linux/BSD package managers:

In case you already use a texlive package of your OS TUDa-CI might not be included.
Since it's a corporate design package you might need to install _texlive-full_ to use it without further adjustments.
These packages also will lack the logo and – this depends on your OS – the provided package might be outdated.
In this case we recommend the setup using tlmgr (as described in the upper links).

### Logos

The used Logos can not be published within this bundle. Members of TU Darmstadt can download these via intranet:
https://download.hrz.tu-darmstadt.de/protected/ULB/tuda_logo.pdf

If you are not a member of TU Darmstadt the example files include information on how to use a replacement image instead of the logo.

## Included templates and document types

A full list of all files of this Project including the additional example files can be found in `MANIFEST.md`.

| document type                         | name of template file                                                 | used documentclass and config             |
| ------------------------------------- | --------------------------------------------------------------------- | ----------------------------------------- |
| minimal Template for internal reports | DEMO-TUDaReport.tex                                                   | tudapub.cls                               |
| scientific paper                      | DEMO-TUDaPub.tex, using DEMO-TUDaBibliography.bib                     | tudapub.cls and tudasize9pt.clo           |
| theses                                | DEMO-TUDaThesis.tex/DEMO-TUDaPhD.tex, using DEMO-TUDaBibliography.bib | tudapub.cls and tudathesis.cfg            |
| scientific poster                     | DEMO-TUDaSciPoster.tex                                                | tudasciposter.cls                         |
| announcement poster                   | DEMO-TUDaPoster.tex                                                   | tudaposter.cls                            |
| theses announcements                  | DEMO-TUDaAnnouncement.tex                                             | tudaposter.cls                            |
| presentation                          | DEMO-TUDaBeamer.tex                                                   | tudabeamer.cls                            |
| letter                                | DEMO-TUDaLetter.tex, using DEMO-TUDaFromaddress.lco                   | tudaletter.cls and tudalettersize10pt.clo |
| exercise sheets/exams                 | DEMO-TUDaExercise.tex                                                 | tudaexercise.cls                          |
| leaflets                              | DEMO-TUDaLeaflet.tex                                                  | tudaleaflet.cls                           |

# Version History (latest versions)

Older version information can be found in (`CHANGELOG.md` in the Repository)[https://github.com/tudace/tuda_latex_templates/blob/main/CHANGELOG.md].

- v4.00 (2025-01-26)
  - complete refactoring including the addition of English template files and bugfixes
  - option to ignore missing logos
  - feature enhancements for tudaexercise
