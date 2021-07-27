\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudabeamer}
 [\filedate\space\fileversion\space]

\RequirePackage{l3keys2e}
\RequirePackage{URspecialopts}

\Define@specialopt@Module[ptxcd/beamer]
\PassOptionsToClass{10pt}{beamer}

\Module@DefineSpecialPassKey[ptxcd/beamer]{color}<tudacolors>

\ExplSyntaxOn
\str_new:N \g_ptxcd_department_str
\keys_define:nn {ptxcd/beamer} {
	accentcolor .code:n = \PassOptionsToPackage{accentcolor=#1}{tudacolors},
	colorframetitle .code:n = \exp_args:Nx \PassOptionsToPackage{\l_keys_key_tl=#1}{beamercolorthemeTUDa}
	\exp_args:Nx \PassOptionsToPackage{\l_keys_key_tl=#1}{beamerouterthemeTUDa},
	colorframetitle .default:n = true,
	logo .code:n = \PassOptionsToPackage{logo=#1}{beamerouterthemeTUDa},
	pdfa .bool_gset:N = \g_ptxcd_pdfa_bool,
	pdfa .initial:n = false,
	logofile .code:n = \PassOptionsToPackage{logofile=#1}{beamerouterthemeTUDa},
	serif .code:n = \PassOptionsToPackage{serif=#1}{beamerfontthemeTUDa},
	serif .default:n = true,
	sans-serif .code:n = \PassOptionsToPackage{sans-serif=#1}{beamerfontthemeTUDa},
	sans-serif .default:n = true,
	department .choice:,
	department / default .code:n = \str_gset:Nn \g_ptxcd_department_str {default},
	department / mecheng .code:n = {
		\keys_set:nn {ptxcd/beamer} {
			colorframetitle=false,
			centerframetitle,
			headsepline=false
		}
		\str_gset:Nn \g_ptxcd_department_str {mecheng}
	},
	department .initial:n = default,
	mecheng .meta:n = {department=mecheng},
	departmentlogofile .tl_gset:N = \g_ptxcd_departmentlogo_tl,
	departmentlogofile .initial:n =,
}


\clist_map_inline:nn {colortitle, colorbacktitle, colorback} {
	\Module@DeclarePassOption[ptxcd/beamer]{#1}{beamercolorthemeTUDa}
}

\clist_map_inline:nn {centerframetitle, logo, headsepline} {
		\Module@DeclarePassOption[ptxcd/beamer]{#1}{beamerouterthemeTUDa}
}
\Module@DeclarePassOption[ptxcd/beamer]{authorontitle}{beamerinnerthemeTUDa}

\ExplSyntaxOff



\PassOptionsToPackage{pdfpagelabels=false,plainpages=false}{hyperref}
\PassOptionsToClass{t}{beamer}

\Module@Process@SpecialOptions[ptxcd/beamer]

\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{beamer}
}

\ProcessKeysOptions{ptxcd/beamer}
\ProcessOptions*

\ExplSyntaxOn
\bool_if:NT  \g_ptxcd_pdfa_bool {\PassOptionsToPackage{RGB}{xcolor}}

\bool_if:NT  \g_ptxcd_pdfa_bool {
\RequirePackage{scrlfile}
\PreventPackageFromLoading{hyperref}
\def\hypersetup#1{}
}
\ExplSyntaxOff

% Load the latex-beamer class
\LoadClass{beamer}

\ExplSyntaxOn
\bool_if:NT \g_ptxcd_pdfa_bool {
	\UnPreventPackageFromLoading{hyperref}
	%only apply the hack if pdfx is older than the working version
	\@ifpackagelater{pdfx}{2021/07/06}{
		\PassOptionsToPackage{a-2b}{pdfx}
		\RequirePackage{pdfx}
	} {
		\msg_new:nnnn{tudapub} {dirty-hack-pdfa} {
			I~have~to~use~a~dirty~hack~to~workaround~some~incompatibilites~between~your~LaTeX~version~and~the~pdfa-mode.\\
			Please~use~pdfa=true~only~if~you~really~need~it.\\
			We~will~remove~this~hack~as~soon~as~all~incompatibilities~have~been~patched.
		} {
			See~the~corresponding~GitHub~Issue~for~more~information:~https://github.com/tudace/tuda_latex_templates/issues/321
		}
		\msg_warning:nn {tudapub} {dirty-hack-pdfa}
		%check if \par is expanable and add a dirty hack
		%Thanks to Ross Moore for the support
		\expandafter\ifx\csname tex_par:D\endcsname \relax
		\let\pdfx@par\par
		\else
		\expandafter\let\expandafter\pdfx@par\csname tex_par:D\endcsname
		\fi
		\let\orig@par\par
		\let\par\pdfx@par
		\PassOptionsToPackage{a-2b}{pdfx}
		\RequirePackage{pdfx}
		%restore\par
		\let\par\orig@par
	}
}
\hypersetup{hidelinks, unicode}


%\department command
\def\department{\@dblarg\ptxcd_beamer_department}

\long\def\ptxcd_beamer_department[#1]#2{%
	\def\beamer@temp{#2}%
	\ifx\beamer@temp\@empty
	\def\insertdepartment{}
	\else
	\def\insertdepartment{\def\inst{\beamer@instinst}\def\and{\qquad}#2}%
	\fi
	\def\beamer@shortdepartment{#1}}
\department{}

\newcommand\insertshortdepartment[1][]{%
	{%
		\let\thanks=\@gobble%
		\beamer@setupshort{#1}%
		\beamer@insertshort{\beamer@shortdepartment}%
}}
%end of \department command
\if_bool:N \g_ptxcd_pdfa_bool
\iow_new:N \ptxcd_xmpdata_stream
\iow_open:Nn \ptxcd_xmpdata_stream {\jobname.xmpdata}
\tl_new:N \g_ptxcd_xmp_title
\tl_new:N \g_ptxcd_xmp_author

\cs_new:Nn \ptxcd_pass_TitleData: {
	\begingroup
	\def\newline{}
	\def\\{}
	\let\thanks\use_none:n
	\cs_set:Npn \and {\exp_not:n {\exp_not:N \sep}}
	\bool_if:NTF \g_ptxcd_pass_TitleData_bool {
		\tl_gset:Nx \g_ptxcd_xmp_title {\insertshorttitle}
		\tl_gset:Nx \g_ptxcd_xmp_author {\insertshortauthor}
		\iow_now:Nx \ptxcd_xmpdata_stream
		{
			\exp_not:N \Title{\tl_to_str:V \g_ptxcd_xmp_title}
			^^J
			\exp_not:N \Author{\tl_to_str:V \g_ptxcd_xmp_author}
			^^J
			\exp_not:N \Creator{LaTeX~ using~ the~ TUDa-CI~ Bundle}
		}
	}{
		\begingroup
		\use:c {pdfx@localcommands}
		\prop_if_in:NnF \g_ptxcd_MetaData_prop {Creator} {\prop_gput:Nnn \g_ptxcd_MetaData_prop {Creator} {LaTeX~ using~ the~ TUDa-CI~ Bundle}}
		\prop_map_function:NN \g_ptxcd_MetaData_prop  \ptxcd_write_xmp_line:nn
		\endgroup
	}
	\endgroup
}
\cs_new:Nn \ptxcd_write_xmp_line:nn {
	%Fallback test for older kernels
	\cs_if_exist:NTF \str_uppercase:f {
	\tl_set:Nx \l_tmpa_tl {
		\str_uppercase:f {\tl_head:n {#1}}
		\str_lowercase:f { \tl_tail:n {#1}}
	}
	} {
	%may be removed in some time
	\tl_set:Nx \l_tmpa_tl {\tl_mixed_case:n {#1}}
	}
	\cs_if_exist:cTF {\l_tmpa_tl}{
		\iow_now:Nx \ptxcd_xmpdata_stream {
			\c_backslash_str \l_tmpa_tl {\exp_not:n {#2}}
		}
	}{
		\msg_error:nnn{tudapub} {unknown-metadata} {#1}
	}
}

\bool_new:N \g_ptxcd_pass_TitleData_bool
\bool_gset_true:N  \g_ptxcd_pass_TitleData_bool
\prop_new:N \g_ptxcd_MetaData_prop

\newcommand*{\Metadata}[1]{
	\bool_gset_false:N \g_ptxcd_pass_TitleData_bool
	\prop_gset_from_keyval:Nn \g_ptxcd_MetaData_prop {#1}
}

\msg_new:nnnn{tudapub} {unknown-metadata} {
	You~ used~ the~ #1~ metadata~ entry.\\
	I~ don't~ know~ how~ to~ handle~ that.\\
	It~ will~ be~ ignored.
} {See~ TUDa-CI~ or~ pdfx~ documentation~ for~ details.}
\else:
\msg_new:nnn{tudapub} {no-pdfa}{The~ tudapub~ class~ won't~ create~ PDF/A-mode.}
\msg_info:nn{tudapub} {no-pdfa}
\fi:

\str_if_empty:NF \g_ptxcd_department_str {}

% Load the TUDa theme
\usetheme{TUDa}%
\@input{\jobname.len}%
\@starttoc{len}%
\let\accentfont\normalfont%
\file_if_exist:nT {beamerthemeTUDa-\g_ptxcd_department_str.sty} {\usetheme{TUDa-\g_ptxcd_department_str}}

\ExplSyntaxOff

\endinput