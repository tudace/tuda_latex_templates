 # Version History (full)

 * v4.02 (2025-02-25)
   - use tuprints DOI by default
   - bugfix in tudaexercise #503
 * v4.01 (2025-02-11)
   - bugfix in tudaexercise #501
 * v4.00 (2025-01-23)
   - complete refactoring including the addition of English template files and bugfixes
   - option to ignore missing logos
   - feature enhancements for tudaexercise
 * v3.41 (2024-07-01)
   - change package loading order to support updated version of pdfx
 * v3.40 (2024-07-01)
   - implement workaround for the pdfx package bug. Thanks to Ulrike Fischer for the hint!
   - fix `ìn_department` strings for theses
 * v3.39 (2024-06-27)
   - update all templates to no longer use pdfx by default due to the pdfx bug
   - fix letter last page reference
 * v3.38 (2024-05-07)
   - update PhD affidavit
 * v3.37 (2024-04-21)
   - refactoring the bundle
   -  small layout adjustments and bugfixes
 * v3.36 (2024-01-05)
   - compatibility to create PDF/A via pdfmangement
   - small adjustments for \tuprints
 * v3.35 (2023-12-11)
   - first CTAN release of the new slide layout
   - fix issues with headwidth calculation if custommargins=true is used
 * v3.34 (2023-07-12)
   - fix typo in affidavit
 * v3.33 (2023-07-05)
   - disable affidavit by default, see https://github.com/tudace/tuda_latex_templates/issues/432 for more information
   - rename color={} option of tudabeamer to tudacolors={} to avoid conflicts with siunitx
 * v3.32 (2023-06-19)
   - remove affidavit=print
 * v3.31 (2023-06-16)
   - Update the digital affidavit text
   - Fix bug in calculation of points using subtasks in tudaexercise
 * v3.30 (2023-04-24)
   - Add affidavit option to remove subject specific information
   - Fix titleblock caclulation with tudasciposter
   - Extend points mechanism to allow acessing subtask points
 * v3.29 (2022-12-11)
   - Fix bug with subtask=runin for TUDaExercise
   - Add support for lists in solutions of TUDaExercise
   - Rename some internal mechanisms to unify the structure
 * v3.28 (2022-11-04)
   - Fix loading mechanism for department specific beamer templates with prefix
   - Internal adjustments to increase flexability
 * v3.27 (2022-08-03)
   - Fix reference issues with subtask* in TUDaExercise
 * v3.26 (2022-06-10)
   - Update TUprints data scheme
   - Fix incompatibility with TUDaLeaflet and recent KOMA-Script updates
 * v3.25 (2022-04-25)
   - Fix departmnt specific configuration mechanism in TUDa-SciPoster
   - Add support for specific configuration paths
 * v3.24 (2022-04-20)
   - Fix paper=landscape for TUDa-SciPoster.
   - Improve internals for advanced department configuration in TUDa-SciPoster
 * v3.23 (2022-03-21)
   - fix font selection for reviewers in uppertitleback
 * v3.22 (2022-02-08)
   - improve alignment for reviewers if `type=thesis`
   - fix bug in handling of `\Metadata`
 * v3.21 (2022-01-11)
   - fix title width for the combination of `custommargins=geometry` and `titlepage=false`
   - remove some obsolete warnings
   - improve TUDaLetter documentation
 * v3.20 (2021-10-12)
   - add signature-image mechanism for affidavit
   - unify \titlegraphic mechanism in tudapub and tudabeamer
 * v3.19 (2021-10-09)
   - enhance title  mechanism for tudaposter
   - fix block spacing if colorframetitle=false
 * v3.18 (2021-08-05)
   - fix bug in tudabeamer block spacing
 * v3.17 (2021-07-27)
   - add a temporary workaround to avoid incompatibilities with pdfa=true
   - fix footer positions
 * v3.16 (2021-06-03)
   - adjust option expansion due to changes in the LaTeX kernel
 * v3.15 (2021-05-26)
   - add \inst to tudasciposter to support multiple affiliations
   - fix calculation of headwidth with department=mecheng
   - improve documentation on document margins for tudapub and tudapub based examples
 * v3.14 (2021-05-18)
   - fix bug in pagestyle init for department=mecheng
   - fix beamer mode selection
   - fix error in tudaexercise documentation
 * v3.13a (2021-03-19)
   - patch to fix the automatic reset of points=auto option (tudaexercise)
 * v3.13 (2021-03-16)
   - enhancement of tudaexercise to be more flexible to be used with exams
   - convert points to a floating point variable
 * v3.12 (2021-03-06)
   - fix color conversion for PDF/A
   - fix margin restore after titlepage for custommargins=geometry
   - enhance information on installation
 * v3.11 (2021-02-22)
   - add Info for DVI-Outputs
 * v3.10 (2021-02-05)
   - fix \thanks for titlepage=false
   - extend support for all CreativeCommons 4.0 Licenses
   - improve documentation
 * v3.09 (2021-01-12)
   - small patch including layout adjustments for department=mecheng
 * v3.08 (2020-11-12)
   - fix titleback margins
   - add predefined values for some cc licenses in tudathesis
   - additional options to adjust titlepage color scheme
 * v3.07 (2020-10-21)
   - improve language selection
   - fix linebreak issues in affidavit
 * v3.06 (2020-10-20)
   - add affidavit for digital thesis submission
   - small adjustments on tudathesis titlepage
   - simplify change of reviewer description
 * v3.05 (2020-10-13) fix \@author expansion for tudaexercise
 * v3.04 (2020-10-05) feature enhancements of tudaexercise
   - enable pdfusetitle for tudaexercise
   - add solution* and IfSolution mechanism for tudaexercise
   - extend documentation on further configuration
 * v3.03 (2020-09-19) remove obsolete Type1 enforcement for pdfa mode
 * v3.02 (2020-09-12) fix bug in tudaexercise caused by 3.01
 * v3.01 (2020-09-11) small bugfixes caused by the internal restructuring
 * v3.00 (2020-09-08)
   - feature enhancement for more flexible usage and department specific requirements
   - introduce department specific mode *mecheng*
   - restructure internals (ptxcd module)
 * v2.11 (2020-06-12) add translation for ThesisStatus
   - add option for a custom status
 * v2.10 (2020-04-25) bugfixes + feature enhancement for tudaexercise
   - add a mechanism for credits in tudaexercise
   - captions & headings in leaflets no longer using \accentfont
   - fixing marginpar alignment
 * v2.09 (2020-03-09) bugfixes and smaller feature extensions
   - intoduction of tudaleaflet
   - fix bug concerning the combination of twocolumn and marinpar=false
   - smaller Layout adjustments
   - documentation enhancements
 * v2.08 (2020-02-10) Bugfixes
   - disable missing ligatures for roboto in scshape (Type1 only)
   - implement KOMA-Script's new naming scheme
   - fix counter mechanisms for tudaexercise
 * v2.07 (2020-01-28) Restore compatibility for older expl3 kernels
   - add key to change license information for `\tuprints`
 * v2.06 (2020-01-18) Reimplement pdf/a mechanisms to work with newer expl3 kernel
 * v2.05 (2019-12-18) Fix identbarcolor mechanism in tudaexercise
 * v2.04 (2019-12-17) Bugfixes & Layout adjustments
   - bugfixes in tudaexercise.cls (#114, #103, #113)
   - add mechanism to use \studentID for tudapub's thesis mode
   - extend documentation
   - improved implementation of tudaexercise's headline mechanism
 * v2.03a (2019-11-29) Fix CTAN Version, due to deployment issues
 * v2.03 (2019-11-28) bugfixes + small implemetation corrections
   - allow verbatim in solution environment for tudaexercise
   - add affidavit* to provide custom texts
   - add \AffidavitSignature
   - fix typos
   - extended documentation
 * v2.02 (2019-11-16) bugfixes
   - fix font issues and Type1 mode
   - improve marginpar adjustment for tudaposter
 * v2.01 (2019-11-13) small bugfixes
   - fix expansion of metadata for PDF/A mode
   - adjustment of english translation for thesis mode of tudapub
   - fix support for titlegraphic in announcement mode for tudaposter
 * v2.00 (2019-11-07) Additional Template files + some improved implementations
   - changed title fontsize adjustments to use clo-files
   - additional options for tudaposter, to use it for job/thesis announcements
   - improved implementation of tudaexercise
   - bugfixes concerning the PDF/A-Mode
 * v1.20 (2019-10-26 - was not published on CTAN)
   - Enhancements for exercise sheets/exams and pdfa-mode
   - Switch pdfa-mode to PDF/A-2b and enforce Type1 for valid documents
   - Add tudaexercise.cls and corresponding demo file
   - Documentation enhancements
   - Type=intern for tudapub for intern reports
   - Announcement mode for tudaposter
   - Layout adjustments on TUDabeamer
   - Additional pagestyle=false mode for tudapub
 * v1.11 (2019-09-25) bugfixes + smaller adjustments to simplify usage
 * v1.10 (2019-09-09) Layout corrections + bugfixes
   - Corrections and changes concerning the margin definitions
   - Fix compatibility issue with datetime package
   - Improved implementation of the headline option
   - Add information on package dependencies
 * v1.01 (2019-08-05) Smaller layout fixes and documentation enhancements
 * v1.00 (2019-07-20) First official version
