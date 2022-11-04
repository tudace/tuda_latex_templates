# TUDa-CI – Corporate Design LaTeX-Templates for TU Darmstadt

 Copyright (C) Marei Peischl <marei@peitex.de>, 2018–2022

 tuda-ci 2022/11/04 v3.28

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

Derzeit existieren diese Templates nur in Deutscher Sprache.

## Verwendungshinweis
Die Richtlinien des Corporate Designs (https://www.intern.tu-darmstadt.de/media/medien_stabsstelle_km/services/medien_cd/das_bild_der_tu_darmstadt.pdf), sowie die Anforderungen der Universitätsbibliothek erfordern einige spezielle Konfigurationen. Beispielsweise ist für wissenschaftliche Veröffentlichungen und Abschlussarbeiten die Erzeugung einer archivierbaren PDF-Datei (PDF/A) vorgesehen.
Dies ist mit aktuellen LaTeX-Paketen und dem Compiler LuaLaTeX deutlich besser umzusetzen, als mit älteren Formaten.
Aus diesem Grund sollten Sie vor der Verwendung von TUDa-CI Ihre TeX-Distribution aktualisieren und nach Möglichkeit LuaLaTeX als Compiler verwenden.
Die Nutzung anderer Kompilierungsprogramme ist grundsätzlich möglich, allerdings werden dann ggf. nicht alle Funktionen unterstützt. Es kann sogar notwendig sein, die Erzeugung von PDF/A zu unterbinden.
Weitere Hinweise finden sich in den Beispieldateien dokumentiert. Diese sind auch als kompilierte PDFs unter http://mirror.ctan.org/macros/latex/contrib/tuda-ci/doc oder – falls das Paket installiert ist – im ensprechenden Doku-Verzeichnis (<Pfad zu Ihrer LaTeX-Installation>/doc/latex/tuda-ci) verfügbar.

## Abhängigkeiten
Das Bundle verwendet Pakete der Standard-LaTeX-Distributionen. Bei der Verwendung von paketierten Versionen über die Linux-Paketverwaltung kann dies ggf. zu Schwierigkeiten führen.

In den häufigsten Fällen fehlt ein Teilpaket mit dem Namen URspecialopts.sty. Dieses Paket wird für die Optionsdurchreichung genutzt und ist Teil des urcls-Bundle: https://ctan.org/pkg/urcls

## Installation
TUDa-CI ist Bestandteil der beiden populären TeX Distributionen ([MikTeX](https://miktex.org/download) & [TeX Live](https://tug.org/texlive/), und damit auch im MacTeX-Paket).
Es ist somit möglich die Templates über die TeX Distribution zu installieren und zu updaten.

Bei TeX Live werden Updates und Paketinstalation durch das Programm „TeX Live Manager“ (tlmgr) ausgeführt. Das Analogon unter MikTeX heißt „MikTeX Console”.
Unter Mac und Windows existieren bei Standardeinstellungen auch grafische Nutzeroberflächen, die durch das Update/die Installation führen.

Falls Sie noch keine Distribution installiert haben, finden Sie die notwendigen Informationen zur Installation von TeX Live unter:
- Windows/Linux https://tug.org/texlive/acquire-netinstall.html
- MacTeX  http://tug.org/mactex/

#### Sonderfall: Paketverwaltung des Betriebssystems (Linux/BSD)
Für einige Linux/BSD-Varianten existieren texlive-Pakete die über die Paketverwaltung des Systems installierbar sind.
Da TUDa-CI sehr speziell ist, ist es meistens nur in der Paketen *texlive-full* enthalten.
Allerdings sind die in den Paketverwaltungen enthalten TeX Live Versionen häufig stark veraltet und die Logo-Dateien müssen ohnehin zusätzlich installiert werden.
Wir empfehlen daher die Installation von TeX Live über den TeX Live Manager: https://tug.org/texlive/doc/texlive-en/texlive-en.html#installation.

### Nutzung von TUDa-CI über Overleaf

Die TUDa verfügt über eine eigene Overleaf-Installation, auf die alle Mitglieder Zugriff haben. Die DEMO-Dateien werden dort in der jeweils aktuellen Version als Templates bereitgestellt: https://sharelatex01.ca.hrz.tu-darmstadt.de/templates/all
Somit ist eine Nutzung ohne lokale Installation möglich.

### Logos & verwendete Bilddateien
Die verwendeten Logos sind nicht Bestandteil dieses Bundles und können von Mitgliedern der TU Darmstadt über das interne Netzwerk heruntergeladen werden.

https://download.hrz.tu-darmstadt.de/protected/CE/TUDa_LaTeX/tuda_logo.pdf

Für die permanente Installation der Logodateien findet sich unter
https://www.ce.tu-darmstadt.de/ce/latex_tuda/index.de.jsp
ein Paket mit entsprechenden Hinweisen.

Für Nicht-Mitglieder ist eine Möglichkeit zur Platzierung eines Ersatzlogos dokumentiert.

## TeXnischer Support für TUDa-Mitglieder

Neben dem Supportangebot zu TUDa-CI gibt es ab April 2021 eine TeXnische Sprechstunde. Details und die für den Zugang notwendigen Informationen finden TUDa-Mitglieder unter https://www.ce.tu-darmstadt.de/ce/latex_tuda/index.de.jsp

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

## Installation
TUDa-CI is part of the popular TeX distributions ([MikTeX](https://miktex.org/download) & [TeX Live](https://tug.org/texlive/), which is included by [MacTeX](https://www.tug.org/mactex/)).
It's possible to install the templates using the TeX Live Manager or the MikTeX Console.

In case you don't have any installed TeX system the following links might be useful:
- Windows/Linux https://tug.org/texlive/acquire-netinstall.html
- MacTeX  http://tug.org/mactex/

It's also possible to use the TUDa-CI-DEMO files as Overleaf-Templates on TUDa's own installation: https://sharelatex01.ca.hrz.tu-darmstadt.de/templates/all (requires TUDa Account)

#### Remark on texlive packages provided by Linux/BSD package managers:
In case you already use a texlive package of your OS TUDa-CI might not be included.
Since it's a corporate design package you might need to install *texlive-full* to use it without further adjustments.
These packages also will lack the logo and – this depends on your OS – the provided package might be outdated.
In this case we recommend the setup using tlmgr (as described in the upper links).

### Logos
The used Logos can not be published within this bundle. Members of TU Darmstadt can download these via intranet:
https://download.hrz.tu-darmstadt.de/protected/CE/TUDa_LaTeX/tuda_logo.pdf

If you are not a member of TU Darmstadt the example files include information on how to use a replacement image instead of the logo.

## Included templates and document types

document type				| name of template file							| used documentclass and config
--------------------------------------- | --------------------------------------------------------------------- | ------------------------------------------
minimal Template for internal reports	| DEMO-TUDaReport.tex 							| tudapub.cls
scientific paper     	      		| DEMO-TUDaPub.tex, using DEMO-TUDaBibliography.bib 			| tudapub.cls and tudasize9pt.clo
theses	   				| DEMO-TUDaThesis.tex/DEMO-TUDaPhD.tex, using DEMO-TUDaBibliography.bib | tudapub.cls and tudathesis.cfg
scientific poster			| DEMO-TUDaSciPoster.tex 		      				| tudasciposter.cls
announcement poster			| DEMO-TUDaPoster.tex 							| tudaposter.cls
theses announcements	   		| DEMO-TUDaAnnouncement.tex 						| tudaposter.cls
presentation				| DEMO-TUDaBeamer.tex 							| tudabeamer.cls
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
 * v2.11 (2020-06-12) add translation for ThesisStatus
   - add option for a custom status
 * v3.00 (2020-09-08)
   - feature enhancement for more flexible usage and department specific requirements
   - introduce department specific mode *mecheng*
   - restructure internals (ptxcd module)
 * v3.01 (2020-09-11) small bugfixes caused by the internal restructuring
 * v3.02 (2020-09-12) fix bug in tudaexercise caused by 3.01
 * v3.03 (2020-09-19) remove obsolete Type1 enforcement for pdfa mode
 * v3.04 (2020-10-05) feature enhancements of tudaexercise
   - enable pdfusetitle for tudaexercise
   - add solution* and IfSolution mechanism for tudaexercise
   - extend documentation on further configuration
 * v3.05 (2020-10-13) fix \@author expansion for tudaexercise
 * v3.06 (2020-10-20)
   - add affidavit for digital thesis submission
   - small adjustments on tudathesis titlepage
   - simplify change of reviewer description
 * v3.07 (2020-10-21)
   - improve language selection
   - fix linebreak issues in affidavit
 * v3.08 (2020-11-12)
   - fix titleback margins
   - add predefined values for some cc licenses in tudathesis
   - additional options to adjust titlepage color scheme
 * v3.09 (2021-01-12)
   - small patch including layout adjustments for department=mecheng
 * v3.10 (2021-02-05)
   - fix \thanks for titlepage=false
   - extend support for all CreativeCommons 4.0 Licenses
   - improve documentation
 * v3.11 (2021-02-22)
   - add Info for DVI-Outputs
 * v3.12 (2021-03-06)
   - fix color conversion for PDF/A
   - fix margin restore after titlepage for custommargins=geometry
   - enhance information on installation
 * v3.13 (2021-03-16)
   - enhancement of tudaexercise to be more flexible to be used with exams
   - convert points to a floating point variable
 * v3.13a (2021-03-19)
   - patch to fix the automatic reset of points=auto option (tudaexercise)
 * v3.14 (2021-05-18)
   - fix bug in pagestyle init for department=mecheng
   - fix beamer mode selection
   - fix error in tudaexercise documentation
 * v3.15 (2021-05-26)
   - add \inst to tudasciposter to support multiple affiliations
   - fix calculation of headwidth with department=mecheng
   - improve documentation on document margins for tudapub and tudapub based examples
 * v3.16 (2021-06-03)
   - adjust option expansion due to changes in the LaTeX kernel
 * v3.17 (2021-07-27)
   - add a temporary workaround to avoid incompatibilities with pdfa=true
   - fix footer positions
 * 3.18 (2021-08-05)
   - fix bug in tudabeamer block spacing
 * 3.19 (2021-10-09)
   - enhance title  mechanism for tudaposter
   - fix block spacing if colorframetitle=false
 * 3.20 (2021-10-12)
   - add signature-image mechanism for affidavit
   - unify \titlegraphic mechanism in tudapub and tudabeamer
 * 3.21 (2022-01-11)
   - fix title width for the combination of `custommargins=geometry` and `titlepage=false`
   - remove some obsolete warnings
   - improve TUDaLetter documentation
 * 3.22 (2022-02-08)
   - improve alignment for reviewers if `type=thesis`
   - fix bug in handling of `\Metadata`
 * 3.23 (2022-03-21)
   - fix font selection for reviewers in uppertitleback
 * 3.24 (2022-04-20)
   - Fix paper=landscape for TUDa-SciPoster.
   - Improve internals for advanced department configuration in TUDa-SciPoster
 * 3.25 (2022-04-25)
   - Fix departmnt specific configuration mechanism in TUDa-SciPoster
   - Add support for specific configuration paths
 * 3.26 (2022-06-10)
   - Update TUprints data scheme
   - Fix incompatibility with TUDaLeaflet and recent KOMA-Script updates
 * 3.27 (2022-08-03)
   - Fix reference issues with subtask* in TUDaExercise
 * 3.28 (2022-11-04)
   - Fix loading mechanism for department specific beamer templates with prefix
   - Internal adjustments to increase flexability