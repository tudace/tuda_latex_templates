\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudabeamer}
 [\filedate\space\fileversion\space]

\RequirePackage{l3keys2e}
\RequirePackage{URspecialopts}

\Define@specialopt@Module[TUDa/beamer]
\PassOptionsToClass{10pt}{beamer}

\Module@DefineSpecialPassKey[TUDa/beamer]{color}<tudacolors>

\ExplSyntaxOn
\keys_define:nn {TUDa/beamer} {
	accentcolor .code:n = \PassOptionsToPackage{accentcolor=#1}{tudacolors},
	colorframetitle .code:n = \PassOptionsToPackage{\l_keys_key_tl=#1}{beamercolorthemeTUDa}
	\PassOptionsToPackage{\l_keys_key_tl=#1}{beamerouterthemeTUDa},
	colorframetitle .default:n = true,
	logo .code:n = \PassOptionsToPackage{logo=#1}{beamerouterthemeTUDa},
	pdfa .bool_gset:N = \g_TUDa@pdfa_bool,
	pdfa .initial:n = false,
	logofile .code:n = \PassOptionsToPackage{logofile=#1}{beamerouterthemeTUDa},
	serif .code:n = \PassOptionsToPackage{serif=#1}{beamerfontthemeTUDa},
	serif .default:n = true,
	sans-serif .code:n = \PassOptionsToPackage{sans-serif=#1}{beamerfontthemeTUDa},
	sans-serif .default:n = true,
}


\clist_map_inline:nn {colortitle, colorbacktitle, colorback} {
	\Module@DeclarePassOption[TUDa/beamer]{#1}{beamercolorthemeTUDa}
}
\Module@DeclarePassOption[TUDa/beamer]{centerframetitle}{beamerouterthemeTUDa}
\Module@DeclarePassOption[TUDa/beamer]{authorontitle}{beamerinnerthemeTUDa}

\ExplSyntaxOff

\Module@DeclarePassOption[TUDa/beamer]{logo}{beamerouterthemeTUDa}

\PassOptionsToPackage{pdfpagelabels=false,plainpages=false}{hyperref}
\PassOptionsToClass{t}{beamer}

\Module@Process@SpecialOptions[TUDa/beamer]

\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{beamer}
}

\ProcessKeysOptions{TUDa/beamer}
\ProcessOptions*

\ExplSyntaxOn
\bool_if:NT  \g_TUDa@pdfa_bool {\PassOptionsToPackage{RGB}{xcolor}}

\bool_if:NT  \g_TUDa@pdfa_bool {
\RequirePackage{scrlfile}
\PreventPackageFromLoading{hyperref}
\def\hypersetup#1{}
}
\ExplSyntaxOff

% Load the latex-beamer class
\LoadClass{beamer}

\ExplSyntaxOn
\bool_if:NT \g_TUDa@pdfa_bool {
	\UnPreventPackageFromLoading{hyperref}
	\PassOptionsToPackage{a-2b}{pdfx}
	\RequirePackage{pdfx}
}
\ExplSyntaxOff

\hypersetup{hidelinks, unicode}

% Load the TUD theme
\AtEndOfClass{%
  \usetheme{TUDa}%
  \@input{\jobname.len}%
  \@starttoc{len}%
  \let\accentfont\normalfont%
}


%\department command
\def\department{\@dblarg\TUDa@beamer@department}

\long\def\TUDa@beamer@department[#1]#2{%
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
%

\ExplSyntaxOn
\if_bool:N \g_TUDa@pdfa_bool
\iow_new:N \TUDa@xmpdata_stream
\iow_open:Nn \TUDa@xmpdata_stream {\jobname.xmpdata}
\tl_new:N \g_TUDa@xmp_title
\tl_new:N \g_TUDa@xmp_author

\cs_new:Nn \TUDa_pass_TitleData: {
	\begingroup
	\def\newline{}
	\def\\{}
	\let\thanks\use_none:n
	\cs_set:Npn \and {\exp_not:n {\exp_not:N \sep}}
	\bool_if:NTF \g_TUDa_pass_TitleData_bool {
		\tl_gset:Nx \g_TUDa@xmp_title {\insertshorttitle}
		\tl_gset:Nx \g_TUDa@xmp_author {\insertshortauthor}
		\iow_now:Nx \TUDa@xmpdata_stream
		{
			\exp_not:N \Title{\tl_to_str:V \g_TUDa@xmp_title}
			^^J
			\exp_not:N \Author{\tl_to_str:V \g_TUDa@xmp_author}
			^^J
			\exp_not:N \Creator{LaTeX~ using~ the~ TUDa-CI~ Bundle}
		}
	}{
		\begingroup
		\use:c {pdfx@localcommands}
		\prop_if_in:NnF \g_TUDa_MetaData_prop {Creator} {\prop_gput:Nnn \g_TUDa_MetaData_prop {Creator} {LaTeX~ using~ the~ TUDa-CI~ Bundle}}
		\prop_map_function:NN \g_TUDa_MetaData_prop  \TUDa_write_xmp_line:nn
		\endgroup
	}
	\endgroup
}
\cs_new:Nn \TUDa_write_xmp_line:nn {
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
		\iow_now:Nx \TUDa@xmpdata_stream {
			\c_backslash_str \l_tmpa_tl {\exp_not:n {#2}}
		}
	}{
		\msg_error:nnn {TUDapub} {unknown-metadata} {#1}
	}
}

\bool_new:N \g_TUDa_pass_TitleData_bool
\bool_gset_true:N  \g_TUDa_pass_TitleData_bool
\prop_new:N \g_TUDa_MetaData_prop

\newcommand*{\Metadata}[1]{
	\bool_gset_false:N \g_TUDa_pass_TitleData_bool
	\prop_gset_from_keyval:Nn \g_TUDa_MetaData_prop {#1}
}

\msg_new:nnnn {TUDapub} {unknown-metadata} {
	You~ used~ the~ #1~ metadata~ entry.\\
	I~ don't~ know~ how~ to~ handle~ that.\\
	It~ will~ be~ ignored.
} {See~ TUDa-CI~ or~ pdfx~ documentation~ for~ details.}
\else:
\msg_new:nnn {tudapub} {no-pdfa}{The~ tudapub~ class~ won't~ create~ PDF/A-mode.}
\msg_info:nn {tudapub} {no-pdfa}
\fi:
\ExplSyntaxOff

\endinput