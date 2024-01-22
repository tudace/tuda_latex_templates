%% This is file `tudabeamer.cls' version 3.36 (2024-01-05),
%% it is part of
%% TUDa-CI -- Corporate Design for TU Darmstadt
%% ----------------------------------------------------------------------------
%%
%%  Copyright (C) 2018--2023 by Marei Peischl <marei@peitex.de>
%%
%% ============================================================================
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%% http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008/05/04 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainers of this work are
%%   Marei Peischl <tuda-ci@peitex.de>
%%
%% The development respository can be found at
%% https://github.com/tudace/tuda_latex_templates
%% Please use the issue tracker for feedback!
%%
%% ============================================================================
%%
\def\fileversion{3.36}
\def\filedate{2024-01-05}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudabeamer}
 [\filedate\space\fileversion\space]

\PassOptionsToClass{10pt}{beamer}

\ExplSyntaxOn
\str_new:N \g_ptxcd_department_str
\tl_new:N \g__ptxcd_design_tl
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
	department / unknown .code:n = {
		\str_gset:Nx \g_ptxcd_department_str {\l_keys_value_tl}
	},
	departmentconfigprefix .tl_gset:N = \g__ptxcd_config_prefix_tl,
	departmentconfigprefix .initial:n = ,
	mecheng .meta:n = {department=mecheng},
	departmentlogofile .tl_gset:N = \g_ptxcd_departmentlogo_tl,
	departmentlogofile .initial:n =,
	color .code:n = {
		\tl_if_in:nnTF {#1} {=} {
			\msg_new:nnn {tudabeamer} {color-option-warning} {
				The~color~option~should~no~longer~be~used~to~pass~options~to~the~tudacolors~package.\\
				Please~use~tudacolors={##1}~instead~of~color={##1}.\\
				See~the~tudabeamer~documentation~for~more~information.
			}
			\msg_warning:nnn {tudabeamer} {color-option-warning} {#1}
			\PassOptionsToPackage{#1}{tudacolors}
		} {
			\PassOptionsToPackage{color=#1}{tudacolors}
		}
	},
	tudacolors .code:n = \PassOptionsToPackage{#1}{tudacolors},
	design .choice:,
	design / 2023 .code:n = {
		\tl_gset:Nn  \g__ptxcd_design_tl {2023}
		\PassOptionsToClass{aspectratio=169}{beamer}
	},
	design / 2008 .code:n = {
		\tl_gset:Nn  \g__ptxcd_design_tl {2008}
	},
	design / default .code:n = {
			\tl_gset:Nn  \g__ptxcd_design_tl {default}
	},
	design .initial:n = default,
	design2023 .meta:n = {design=2023},
	design2008 .meta:n = {design=2008},
	design .usage:n = load,
}
\ExplSyntaxOff

\PassOptionsToPackage{pdfpagelabels=false,plainpages=false}{hyperref}
\PassOptionsToClass{t}{beamer}

\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{beamer}
}

\ProcessKeyOptions[ptxcd/beamer]
\ProcessOptions*

\ExplSyntaxOn
\tl_if_eq:NnT \g__ptxcd_design_tl  {default} {
	\msg_new:nnn {tudabeamer} {default-design-changed} {
			With~version~4.0~tudabeamer~switched~to~the~new~corporate~design~layout.\\
			In~case~this~is~not~intended,~it's~possible~switch~back~using~`design=2008`~option.\\
			`design=2023`~will~disable~this~warning.
	}
	\msg_warning:nn {tudabeamer} {default-design-changed}
	\keys_set:nn {ptxcd/beamer} {design=2023}
}

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
	\PassOptionsToPackage{a-2b}{pdfx}
	\RequirePackage{pdfx}
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
\usetheme{TUDa\g__ptxcd_design_tl}%
\@input{\jobname.len}%
\@starttoc{len}%
\let\accentfont\normalfont%

\file_if_exist:nT {\g__ptxcd_config_prefix_tl beamerthemeTUDa-\g_ptxcd_department_str.sty}
	{\usepackage{\g__ptxcd_config_prefix_tl beamerthemeTUDa-\g_ptxcd_department_str}}

\ExplSyntaxOff

\endinput
