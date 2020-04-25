# TUDa-CI – Corporate Design LaTeX-Templates for TU Darmstadt

 Copyright (C) Marei Peischl <marei@peitex.de>, 2018–2020

 tuda-ci 2020/04/25 v2.10

***************************************************************************

 This material is subject to the LaTeX Project Public License version 1.3c
 or later. See http://www.latex-project.org/lppl.txt for details.

***************************************************************************

[Link to the github repository](https://github.com/tudace/tuda_latex_templates)

[English version below](#summary)

# Zusammenfassung
Das TUDa-CI-Bundle ist die Umsetzung des Corporate Designs der TU Darmstadt in LaTeX.
Es liefert neben den Klassen-, Paket- und Konfigurationsdateien auch Anwenderdokumentation in Form von Templatedateien für verschiedene Dokumententypen.

Das Gesamtpaket wurde in Teilen inspiriert von Clemens von Loewenichs and Joe Werners TUD-Design Paket.

Derzeit existieren diese Templates nur in Deutscher Sprache.

## Verwendungshinweis
Die Richtlinien des Corporate Designs, sowie die Anforderungen der Universitätsbibliothek erfordern einige spezielle Konfigurationen. Beispielsweise ist für wissenschaftliche Veröffentlichungen und Abschlussarbeiten die Erzeugung einer archivierbaren PDF-Datei (PDF/A) vorgesehen.
Dies ist mit aktuellen LaTeX-Paketen und dem Compiler LuaLaTeX deutlich konsequenter umzusetzen.
Aus diesem Grund wird empfohlen, die verwendete Distribution vorab zu aktualisieren und LuaLaTeX zu verwenden.
Weitere Hinweise finden sich in den Beispieldateien dokumentiert.

## Abhängigkeiten
Das Bundle verwendet Pakete der Standard-LaTeX-Distributionen. Bei der Verwendung von paketierten Versionen über die Linux-Paketverwaltung kann dies ggf. zu Schwierigkeiten führen.

In den häufigsten Fällen fehlt ein Teilpaket mit dem Namen URspecialopts.sty. Dieses Paket wird für die Optionsdurchreichung genutzt und ist Teil des urcls-Bundle: https://ctan.org/pkg/urcls

## Installation
Für die Verwendung der Klassen und Pakete muss entweder der gesamte Inhalt des tex-Verzeichnisses im Arbeitsverzeichnis liegen oder in der TeX-Distribution installiert werden. Dies ist entweder über die Paketverwaltung der Distribution möglich oder das Paket kann manuell mithilfe der Release Informationen im GitHub Repository installiert werden.

### Logos & verwendete Bilddateien
Die verwendeten Logos sind nicht Bestandteil dieses Bundles und können von Mitgliedern der TU Darmstadt über das interne Netzwerk heruntergeladen werden.

https://download.hrz.tu-darmstadt.de/protected/CE/TUDa_LaTeX/tuda_logo.pdf

Für die permanente Installation der Logodateien findet sich unter
https://www.ce.tu-darmstadt.de/ce/latex_tuda/index.de.jsp
ein Paket mit entsprechenden Hinweisen.

Für Nicht-Mitglieder ist eine Möglichkeit zur Platzierung eines Ersatzlogos dokumentiert.

## Enthaltene Templatedateien

Dokumententyp				 | Templatedatei(en)									| Dokumentenklasse
---------------------------------------- | ------------------------------------------------------------------------------------ | ----------------
Interne Berichte (minimales template)	 | DEMO-TUDaReport.tex									| tudapub.cls mit tudasize9pt.clo
Wissenschaftliche Artikel   	     	 | DEMO-TUDaPub.tex, verwendet auch DEMO-TUDaBibliography.bib				| tudapub.cls
Abschlussarbeiten 			 | DEMO-TUDaThesis.tex/DEMO-TUDaPhD.tex, verwendet auch DEMO-TUDaBibliography.bib	| tudapub.cls mit tudathesis.cfg
Wissenschaftliche Poster		 | DEMO-TUDaSciPoster.tex		 	   					| tudasciposter.cls
Veranstaltungsankündigungen		 | DEMO-TUDaPoster.tex									| tudaposter.cls
Ausschreibungen				 | DEMO-TUDaAnnouncement.tex								| tudaposter.cls
Präsentationen				 | DEMO-TUDaBeamer.tex									| tudabeamer.cls
Briefe					 | DEMO-TUDaLetter.tex, verwendet auch DEMO-TUDaFromaddress.lco 			| tudaletter.cls mit tudalettersize10pt.clo
Übungsblätter				 | DEMO-TUDaExercise.tex	       							| tudaexercise.cls
Flyer/Faltblätter			 | DEMO-TUDaLeaflet.tex									| tudaleaflet.cls

Darüber hinaus existieren Beispieldateien für:
Kompatibilitätsmodus TUDexercise: https://github.com/tudace/tuda_latex_templates/blob/master/example/Examples-TUDexercise-compat.tex
Farbskalen von tuda-pgfplots: https://github.com/tudace/tuda_latex_templates/blob/master/example/Examples-TUDa-pgfplots.tex

## Liste aller enthaltenen Dateien:

* README.md
* example/
  - DEMO-TUDaAnnouncement.tex
  - DEMO-TUDaBeamer.tex
  - DEMO-TUDaBibliography.bib
  - DEMO-TUDaExercise.tex
  - DEMO-TUDaLeaflet.tex
  - DEMO-TUDaLetter.tex
  - DEMO-TUDaPhD.tex
  - DEMO-TUDaPoster.tex
  - DEMO-TUDaPub.tex
  - DEMP-TUDaReport.tex
  - DEMO-TUDaSciPoster.tex
  - DEMO-TUDaThesis.tex
  - TuDa_Demo.lco
* tex/
  - tudabeamer.cls
  - beamercolorthemeTUDa.sty
  - beamerfontthemeTUDa.sty
  - beamerinnerthemeTUDa.sty
  - beamerouterthemeTUDa.sty
  - beamerthemeTUDa.sty
  - tudacolors.cfg
  - tudacolors.def
  - tudacolors.sty
  - tudaexercise.cls
  - tudafonts.sty
  - tudaleaflet.cls
  - tudaletter.cls
  - tudalettersize10pt.clo
  - tudaposter.cls
  - tudapub.cls
  - tudarules.sty
  - tudasciposter.cls
  - tudasize9pt.clo
  - tudathesis.cfg
  - tuda-a0paper.clo
  - tuda-a1paper.clo
  - tuda-a2paper.clo
  - tuda-a3paper.clo
  - tuda-a4paper.clo
  - tuda-a5paper.clo


# Summary

The TUDa-CI-Bundle provides a possibility to use the Corporate Design of TU Darmstadt in LaTeX.
Therefore it contains documentclasses as well as some helper packages and config files together with some templates for user documentation, which currently are only available in German.

If you are not a German speaker and require some help using these files, please feel free to contact the maintainers.

## Includes templates and document types

document type				| name of template file							| used documentclass and config
--------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------
minimal Template for internal reports	| DEMO-TUDaReport.tex 							| tudapub.cls
scientific paper     	      		| DEMO-TUDaPub.tex, using DEMO-TUDaBibliography.bib 			| tudapub.cls and tudasize9pt.clo
theses	   				| DEMO-TUDaThesis.tex/DEMO-TUDaPhD.tex, using DEMO-TUDaBibliography.bib | tudapub.cls and tudathesis.cfg
scientific poster			| DEMO-TUDaSciPoster.tex 		      				| tudasciposter.cls
announcement poster			| DEMO-TUDaPoster.tex 							| tudaposter.cls
theses announcements	   		| DEMO-TUDaAnnouncement.tex 						| tudaposter.cls
presentation				| DEMO-TUDaBeamer.tex 							| tudaposter.cls
letter					| DEMO-TUDaLetter.tex, using DEMO-TUDaFromaddress.lco  			| tudaletter.cls and tudalettersize10pt.clo
exercise sheets/exams			| DEMO-TUDaExercise.tex      						| tudaexercise.cls
leaflets 				| DEMO-TUDaLeaflet.tex							| tudaleaflet.cls

# Version History

 * v1.00 First official version - published on 2019-07-20
 * v1.01 (2019-08-05) Smaller layout fixes and documentation enhancements
 * v1.10 (2019-09-09) Layout corrections + bugfixes
   - Corrections and changes concerning the margin definitions
   - Fix compatibility issue with datetime package
   - Improved implementation of the headline option
   - Add information on package dependencies
 * v1.11 (2019-09-25) bugfixes + smaller adjustments to simplify usage
 * v1.20 (2019-10-26 - was not published on CTAN)
   - Enhancements for exercise sheets/exams and pdfa-mode
   - Switch pdfa-mode to PDF/A-2b and enforce Type1 for valid documents
   - Add tudaexercise.cls and corresponding demo file
   - Documentation enhancements
   - Type=intern for tudapub for intern reports
   - Announcement mode for tudaposter
   - Layout adjustments on TUDabeamer
   - Additional pagestyle=false mode for tudapub
 * v2.00 (2019-11-07) Additional Template files + some improved implementations
   - changed title fontsize adjustments to use clo-files
   - additional options for tudaposter, to use it for job/thesis announcements
   - improved implementation of tudaexercise
   - bugfixes concerning the PDF/A-Mode
 * v2.01 (2019-11-13) small bugfixes
   - fix expansion of metadata for PDF/A mode
   - adjustment of english translation for thesis mode of tudapub
   - fix support for titlegraphic in announcement mode for tudaposter
 * v2.02 (2019-11-16) bugfixes
   - fix font issues and Type1 mode
   - improve marginpar adjustment for tudaposter
 * v2.03 (2019-11-28) bugfixes + small implemetation corrections
   - allow verbatim in solution environment for tudaexercise
   - add affidavit* to provide custom texts
   - add \AffidavitSignature
   - fix typos
   - extended documentation
 * v2.03a (2019-11-29) Fix CTAN Version, due to deployment issues
 * v2.04 (2019-12-17) Bugfixes & Layout adjustments
   - bugfixes in tudaexercise.cls (#114, #103, #113)
   - add mechanism to use \studentID for tudapub's thesis mode
   - extend documentation
   - improved implementation of tudaexercise's headline mechanism
 * v2.05 (2019-12-18) Fix identbarcolor mechanism in tudaexercise
 * v2.06 (2020-01-18) Reimplement pdf/a mechanisms to work with newer expl3 kernel
 * v2.07 (2020-01-28) Restore compatibility for older expl3 kernels
   - add key to change license information for `\tuprints`
 * v2.08 (2020-02-10) Bugfixes
   - disable missing ligatures for roboto in scshape (Type1 only)
   - implement KOMA-Script's new naming scheme
   - fix counter mechanisms for tudaexercise
 * v2.09 (2020-03-09) bugfixes and smaller feature extensions
   - intoduction of tudaleaflet
   - fix bug concerning the combination of twocolumn and marinpar=false
   - smaller Layout adjustments
   - documentation enhancements
 * v2.10 (2020-04-25) bugfixes + feature enhancement for tudaexercise
   - add a mechanism for credits in tudaexercise
   - captions & headings in leaflets no longer using \accentfont
   - fixing marginpar alignment
