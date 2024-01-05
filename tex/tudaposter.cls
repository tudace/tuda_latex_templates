%% This is file `tudaposter.cls' version 3.36 (2024-01-05),
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

\ProvidesExplPackage{tudaposter}{\filedate}{\fileversion}{Poster Layouts for the Corporate Design of TU Darmstadt}

\bool_new:N \g_ptxcd_logo_inhead_bool
\dim_new:N \g_ptxcd_margin_dim
\int_new:N \g_ptxcd_paper_int
\int_new:N \g_ptxcd_postertype_int
\str_new:N \g_ptxcd_department_str

\str_const:Nn \c__ptxcd_base_str {poster}

\keys_define:nn {ptxcd/poster} {
	accentcolor .code:n = {\PassOptionsToPackage{accent=#1}{tudacolors}},
	color .code:n = {\PassOptionsToPackage{color=#1}{tudacolors}},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccent=#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{identbar=#1}{tudacolors}},
	logo .choice:,
	logo / head .code:n = {\bool_gset_true:N \g_ptxcd_logo_inhead_bool},
	logo / body .code:n = {\bool_gset_false:N \g_ptxcd_logo_inhead_bool},
	logo / top .code:n = {\bool_gset_true:N \g_ptxcd_logo_inhead_bool},
	logo / bottom .code:n = {\bool_gset_false:N \g_ptxcd_logo_inhead_bool},
	logo .initial:n = {head},
	footer .bool_gset:N = \g_ptxcd_poster_foot_bool,
	footer .default:n = true,
	footer .initial:n = false,
	footheight .dim_gset:N = \g_ptxcd_footheight_dim,
	paper .choices:nn = {a0,a1,a2,a3,a4}{
		\int_gset_eq:NN \g_ptxcd_paper_int  \l_keys_choice_int
		\tl_gset_eq:NN \g_ptxcd_paper_tl \l_keys_choice_tl
	},
	fontsize .choice:,
	fontsize / auto .code:n = \tl_gclear:N \g_ptxcd_fontsize_tl,
	fontsize / unknown .code:n = {\@defaultunits\@tempdima#1pt\relax\@nnil \tl_gset:Nx \g_ptxcd_fontsize_tl {\the\@tempdima}},
	fontsize .initial:n = auto,
	logofile .tl_gset:N = \g_ptxcd_logofile_tl,
	logofile .initial:n = tuda_logo,
	type .choice:,
	type / default .code:n = {
		\int_gset:Nn \g_ptxcd_postertype_int {1}
	},
	type / announcement .code:n = {
		\int_gset:Nn \g_ptxcd_postertype_int {2}
		\keys_set:nn {ptxcd/poster}{
			marginpar=true,
			indenttext=false,%allow overwrite - check default
			logo=head,
			title=small,
			colorsubtitle=true
		}
	},
	type .initial:n = default,
	indenttext .bool_gset:N = \g_ptxcd_indenttext_bool,
	indenttext .initial:n = false,
	indenttext .default:n = true,
	marginpar .bool_gset:N = \g_ptxcd_marginpar_bool,
	marginpar / auto .meta:n = {marginpar = true} ,
	marginpar .default:n = true,
	marginpar .initial:n = false,
	title .choice:,
	title / default .meta:n = {title=large},
	title / large .code:n = \bool_gset_false:N \g_ptxcd_smalltitle_bool,
	title / small  .code:n = \bool_gset_true:N \g_ptxcd_smalltitle_bool,
	title .initial:n = default,
	colorback .bool_gset:N = \g_ptxcd_colorback_bool,
	colorback .initial:n = true,
	colorsubtitle .bool_gset:N = \g_ptxcd_colorsubtitle_bool,
	colorsubtitle .default:n = true,
	colorsubtitle .initial:n = false,
	department .choice:,
	department / default .code:n = \str_gset:Nn \g_ptxcd_department_str {default},
	department / mecheng .code:n = {
		\str_gset:Nn \g_ptxcd_department_str {mecheng}
		\keys_set:nn {ptxcd/poster} {colorback=false, departmentlogofile=tuda_maschinenbau_logo}
	},
	department .initial:n = default,
	department / unknown .code:n = {
		\str_gset:Nx \g_ptxcd_department_str {\l_keys_value_tl}
	},
	departmentconfigprefix .tl_gset:N = \g__ptxcd_config_prefix_tl,
	departmentconfigprefix .initial:n = tuda,
	mecheng .meta:n = {department=mecheng},
	departmentlogofile .tl_gset:N = \g_ptxcd_departmentlogo_tl,
	departmentlogofile .initial:n =,
}

\ProcessKeyOptions[ptxcd/poster]

\ExplSyntaxOff
\LoadClass[parskip=half-]{scrartcl}
\RequirePackage{scrlayer}
\RequirePackage{scrlayer-notecolumn}
\ExplSyntaxOn

\tl_if_empty:NT \g_ptxcd_paper_tl {\keys_set:nn {ptxcd/poster} {paper=a0}}

\bool_if:NTF \g_ptxcd_smalltitle_bool {
	\file_input:n {tuda-a\int_use:N \g_ptxcd_paper_int paper.clo}
	\ptxcd_setup_title_sizes:
	\file_input:n {tuda-a\int_use:N \g_ptxcd_paper_int paper.clo}
	\ptxcd_setup_base_sizes:
}{
	\int_gdecr:N \g_ptxcd_paper_int
	\file_input:n {tuda-a\int_use:N \g_ptxcd_paper_int paper.clo}
	\ptxcd_setup_title_sizes:
	\ptxcd_setup_base_sizes:
}


\setkomafont{title}{
	\bool_if:NT \g_ptxcd_colorback_bool
	{\color{textonaccentcolor}}\expandafter\fontsize\ptxcd_title_fontsize:\selectfont}
\setkomafont{subtitle}{\expandafter\fontsize\ptxcd_titleinfo_fontsize:\selectfont}
\newkomafont{titleinfo}{\usekomafont{subtitle}}

\clist_map_inline:nn {author, date, publishers}
{\setkomafont{#1}{\usekomafont{subtitle}}}

\ExplSyntaxOff
\KOMAoptions{fontsize=\csname g_ptxcd_fontsize_tl\endcsname}
\ExplSyntaxOn

\RequirePackage{tudafonts}
\renewcommand*{\familydefault}{\sfdefault}

\exp_args:Nx \PassOptionsToPackage{paper=\g_ptxcd_paper_tl , mode=tikz}{tudarules}
\RequirePackage{tudarules}

\RequirePackage{tudacolors}
\RequirePackage{qrcode}
\RequirePackage{tikz}




\newlength{\contentwidth}
\setlength{\contentwidth}{\dimexpr\paperwidth-2\g_ptxcd_margin_dim}

\ptxcd_makeheadrule[width=\contentwidth, color=identbarcolor]{ptxcd_headrule}

%%%%%%%%%%%%%%%%%%%%%%
\int_case:nn {\g_ptxcd_postertype_int}
{
	{1} {}
	{2} {
		\addtokomafont{subtitle}{\bfseries}
	}
}

%%%%%%%%%%%%%%%%%%%%%%
%marginpar option
\dim_new:N \g_ptxcd_marginpar_dim
%%%%%%%%%%%%%%%%%%%%%%
\dim_new:N \g_ptxcd_titleindent_dim
\begingroup
\expandafter\fontsize\ptxcd_title_fontsize:\selectfont
\dim_gset:Nn \g_ptxcd_titleindent_dim {.5ex}
\endgroup

\dim_new:N \g_ptxcd_columnSep_dim
\dim_gset:Nn \g_ptxcd_columnSep_dim {1em}

\RequirePackage{geometry}

\geometry{
	margin= \g_ptxcd_margin_dim,
	hmargin = \dim_eval:n {
		\g_ptxcd_margin_dim +
		\bool_if:NTF \g_ptxcd_indenttext_bool
		{\g_ptxcd_titleindent_dim} {0pt}
	},
	top=\dim_eval:n {
		\box_ht:N \ptxcd_headrule_box + \box_dp:N \ptxcd_headrule_box
		+ .5\c_ptxcd_logoheight_dim
		+\g_ptxcd_margin_dim}
}

\bool_if:NTF \g_ptxcd_marginpar_bool {
	\dim_gset:Nn \g_ptxcd_marginpar_dim {\__ptxcd_logowidth:}
	\geometry{
		includemp, marginpar=\g_ptxcd_marginpar_dim, marginparsep=\g_ptxcd_columnSep_dim,
		right = \dim_eval:n {
			\g_ptxcd_margin_dim +
			\bool_if:nTF {\g_ptxcd_indenttext_bool && !\g_ptxcd_marginpar_bool}
			{\g_ptxcd_titleindent_dim} {0pt}
		},
	}
	\KOMAoptions{mpinclude}
}{
	\dim_gzero:N \g_ptxcd_marginpar_dim
	\geometry{
		nomarginpar,
		right = \dim_eval:n {
			\bool_if:NT \g_ptxcd_indenttext_bool
			{\g_ptxcd_titleindent_dim}
			+ \g_ptxcd_margin_dim
		},
	}
	\KOMAoptions{mpinclude=false}
}


\bool_if:NT \g_ptxcd_poster_foot_bool {
	\dim_compare:nT {\g_ptxcd_footheight_dim = 0pt} {
		\dim_set:Nn \g_ptxcd_footheight_dim
		{1.5\baselineskip}
	}
	\geometry{bottom=\dim_eval:n {\g_ptxcd_footheight_dim+\footskip+\g_ptxcd_margin_dim}}
}
%%%%%%%%%%%%%%%%%%%%%%

\dim_new:N \g_ptxcd_qrcode_dim
\dim_gset:Nn \g_ptxcd_qrcode_dim {.7\c_ptxcd_logoheight_dim}

\DeclareNewLayer[
	background,
	align=br,
	width=\g_ptxcd_qrcode_dim,
	height=\g_ptxcd_qrcode_dim,
	hoffset=\paperwidth-\g_ptxcd_margin_dim,
	voffset=\paperheight-\g_ptxcd_margin_dim,
	mode=picture,
	contents={%
			\tl_if_empty:NF \g_ptxcd_poster_qrcode_tl {
				\let\width\g_ptxcd_qrcode_dim
				\let\height\g_ptxcd_qrcode_dim
				\g_ptxcd_poster_qrcode_tl
			}
		}
]{TUDa.poster.qrcode}



\DeclareNewLayer[
	clone=TUDa.poster.qrcode,
	align=bl,
	hoffset=\g_ptxcd_margin_dim,
	width=\paperwidth-2\g_ptxcd_margin_dim,
	height=\g_ptxcd_footheight_dim,
	contents={
			\bool_if:NTF \g_ptxcd_poster_foot_bool {
				\putUL{\rule{\layerwidth}{\g_ptxcd_titlerule_dim}}
				\put(0,0) {\parbox[b][\g_ptxcd_footheight_dim][c]{\layerwidth}{\strut\g_ptxcd_poster_foot_tl\strut}}
				\putLL{\rule{\layerwidth}{\g_ptxcd_titlerule_dim}}
			}{
				\smash{\rule{\layerwidth}{\g_ptxcd_titlerule_dim}}
			}
		}
]{TUDa.poster.footer}

\DeclareNewLayer[
	background,mode=picture,
	width=\paperwidth-2\g_ptxcd_margin_dim,
	hoffset=\g_ptxcd_margin_dim,
	voffset=\g_ptxcd_margin_dim+\box_ht:N \ptxcd_headrule_box + \box_dp:N \ptxcd_headrule_box,
	contents=\bool_if:NT \g_ptxcd_colorback_bool {\color{accentcolor}\rule{\layerwidth}{\layerheight}},
]{TUDa.poster.background}

\DeclareNewLayer[
	textarea,
	foreground,
	align=tr,
	hoffset=\paperwidth-\g_ptxcd_margin_dim,
	width=\__ptxcd_logowidth:,
	height=.5\textheight,
	contents={\box_use:N \g_ptxcd_title_info_box}
]{TUDa.poster.logo}

\DeclareNewLayer[
	clone=TUDa.poster.background,
	align=tl,
	voffset=\g_ptxcd_margin_dim,
	height=\box_ht:N \ptxcd_headrule_box + \box_dp:N \ptxcd_headrule_box,
	mode=picture,
	contents={\box_use:N \ptxcd_headrule_box}
]{TUDa.poster.rule}

\DeclareNewLayer[
	clone=notecolumn.marginpar,
]{TUDa.poster.marginpar}

\DeclareNewPageStyleByLayers{TUDa.poster.title}{TUDa.poster.rule,TUDa.poster.background,TUDa.poster.qrcode,TUDa.poster.footer}
\DeclareNewPageStyleByLayers{TUDa.poster}{TUDa.poster.rule,TUDa.poster.qrcode,TUDa.poster.footer, TUDa.poster.marginpar}
\pagestyle{TUDa.poster}


\dim_new:N \g_ptxcd_titlegraphic_max_height_dim
\dim_new:N  \g_ptxcd_titleback_dim

\newcommand*{\titleinfo}[1]{\def\@titleinfo{#1}}
\titleinfo{}

\renewcommand*{\maketitle}{
	\begingroup
	\setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
	\bool_if:NT \g_ptxcd_marginpar_bool
		{\setlength{\linewidth}{\dim_eval:n  {\textwidth+\g_ptxcd_marginpar_dim + \marginparsep}}}
	\vbox_gset:Nn \g_ptxcd_title_box
	{
		\usesizeofkomafont{title}
		\parbox[t]{\linewidth}{
			\bool_if:NT \g_ptxcd_smalltitle_bool {\raisebox{
					\dim_max:nn {0pt} {1.5\c_ptxcd_logoheight_dim - \height}
				}}
			{
				\begin{minipage}[b]{\bool_if:NT \g_ptxcd_logo_inhead_bool {.75}\linewidth}
					\leavevmode\par\nointerlineskip
					\bool_if:NF \g_ptxcd_indenttext_bool {\begin{addmargin}{\g_ptxcd_titleindent_dim }}
							\usekomafont{title}
							\raggedright
							\tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
							\leavevmode\usekomafont{disposition}\usekomafont{title}%
							\@title\strut\par
							\bool_if:NTF \g_ptxcd_indenttext_bool {\nointerlineskip\leavevmode}{\end{addmargin}}
				\end{minipage}
			}
			\par\nointerlineskip
			\exp_args:Nf \tl_if_empty:nF {\@subtitle\@titleinfo\@subject\@author\@date\@publishers} {
				\bool_if:NT \g_ptxcd_indenttext_bool {\hspace*{-\g_ptxcd_titleindent_dim}}
				\rule{\linewidth}{\g_ptxcd_titlerule_dim}
				\par
				\nointerlineskip
				\vspace{\c_ptxcd_rulesep_dim}
				\bool_if:NTF \g_ptxcd_indenttext_bool {\begingroup}{\begin{addmargin}{\g_ptxcd_titleindent_dim }}
						\bool_if:NT \g_ptxcd_colorsubtitle_bool {\color{textonaccentcolor}}
						\clist_map_inline:nn {subtitle, titleinfo, subject, author, date, publishers}
						{\tl_if_empty:cF {@##1} {{\usekomafont{##1}\use:c {@##1}\par}}}
						\nointerlineskip
						\bool_if:NTF \g_ptxcd_indenttext_bool {\endgroup} {\end{addmargin}}
				\vspace{\c_ptxcd_rulesep_dim}
				\par\nointerlineskip
				\bool_if:NT \g_ptxcd_indenttext_bool {\hspace*{-\g_ptxcd_titleindent_dim}}
				\tl_if_empty:NF \@thanks {
					\bool_if:NT \g_ptxcd_indenttext_bool {\hspace*{-\g_ptxcd_titleindent_dim}}\rule{\linewidth}{\g_ptxcd_titlerule_dim}
					\vspace{\c_ptxcd_rulesep_dim}
					\par\nointerlineskip
					\expandafter\fontsize\ptxcd_titlethanks_fontsize:\selectfont
					\bool_if:NTF \g_ptxcd_indenttext_bool {\begingroup}{\begin{addmargin}{\g_ptxcd_titleindent_dim }}
							\let\footnotetext\ptxcd_title@footnote
							\@thanks
							\vspace{\c_ptxcd_rulesep_dim}
							\bool_if:NTF \g_ptxcd_indenttext_bool {\endgroup} {\end{addmargin}}
					\global\let\@thanks\@empty
					\par
				}
			}
			\nointerlineskip
			\rule{\linewidth}{\g_ptxcd_titlerule_dim}
		}
	}
	\endgroup

	\ptxcd_Setup_Title_box:
	\dim_gset:Nn \g_ptxcd_titleback_dim {
		\bool_if:NT \g_ptxcd_colorsubtitle_bool {\box_dp:N \g_ptxcd_title_box}+
		\box_ht:N \g_ptxcd_title_box+.5\c_ptxcd_logoheight_dim
	}

	\ModifyLayer[
		height=\g_ptxcd_titleback_dim
	]{TUDa.poster.background}

	\bool_if:NF \g_ptxcd_logo_inhead_bool {
		\ModifyLayer[
			addvoffset=
					\bool_if:NF \g_ptxcd_colorsubtitle_bool {\box_dp:N \g_ptxcd_title_box}+\g_ptxcd_titleback_dim+\c_ptxcd_smallrule_dim
		]{TUDa.poster.logo}
	}
	\leavevmode\box_use:N \g_ptxcd_title_box\par
	\dim_set:Nn \g_ptxcd_titlegraphic_max_height_dim {\textheight-\pagetotal}
	\bool_if:NTF \g_ptxcd_logo_inhead_bool {
		\dim_compare:nT {\box_ht:N \g_ptxcd_title_info_box+ \box_dp:N \g_ptxcd_title_info_box  > \box_ht:N \g_ptxcd_title_box}
		{\msg_warning:nn{tudaposter} {infobox-too-high}}
	} {
		\dim_compare:nT {\box_ht:N \g_ptxcd_title_info_box+ \box_dp:N \g_ptxcd_title_info_box  > \box_ht:N \g_ptxcd_titlegraphic_box + \box_dp:N \g_ptxcd_titlegraphic_box}
		{\msg_warning:nn{tudaposter} {infobox-too-high}}
	}
	\global\def\contentheight{\g_ptxcd_titlegraphic_max_height_dim}
	\tl_if_empty:NF \@titlegraphic{
		\vbox_gset:Nn \g_ptxcd_titlegraphic_box {\parbox[t]{\dim_eval:n {\paperwidth-2\g_ptxcd_margin_dim}}{\@titlegraphic}}
		\par\nointerlineskip
		\box_use:N \g_ptxcd_titlegraphic_box
	}

	\DeclareLayer[
		clone=TUDa.poster.marginpar,
		height=\bool_if:NF \l_ptxcd_marginpar_overlap_bool {-\box_ht:N \g_ptxcd_titlegraphic_box-\box_dp:N \g_ptxcd_titlegraphic_box}
		+\textheight-\box_ht:N \g_ptxcd_title_box-\box_dp:N \g_ptxcd_title_box-.5\c_ptxcd_logoheight_dim,
		addvoffset=\bool_if:NF \l_ptxcd_marginpar_overlap_bool {+\box_ht:N\g_ptxcd_titlegraphic_box+\box_dp:N \g_ptxcd_titlegraphic_box}
		+\box_ht:N \g_ptxcd_title_box+\box_dp:N \g_ptxcd_title_box+.5\c_ptxcd_logoheight_dim,
	]{TUDa.poster.marginpar.title}

	\tl_if_empty:NF \g_ptxcd_poster_qrcode_tl {
		\ModifyLayer[addwidth=-\g_ptxcd_qrcode_dim-\c_ptxcd_rulesep_dim]{TUDa.poster.footer}
	}

	\AddLayersToPageStyle{TUDa.poster.title}{TUDa.poster.marginpar.title}
	\AddLayersToPageStyle{TUDa.poster.title}{TUDa.poster.logo}
	\thispagestyle{TUDa.poster.title}
	\global\def\contentwidth{\linewidth}
	\par
	\let\@title\@empty
	\let\@subtitle\@empty
	\let\@titleinfo\@empty
}


\def\@titlegraphic{}
\newcommand{\titlegraphic}[1]{
	\def\@titlegraphic{#1}
}
\box_new:N \g_ptxcd_titlegraphic_box

\seq_new:N \g_ptxcd_title_info_seq

\seq_gput_right:Nn \g_ptxcd_title_info_seq {
	\rlap{\includegraphics[height=\c_ptxcd_logoheight_dim]{\g_ptxcd_logofile_tl}}
}

\box_new:N \g_ptxcd_title_info_box
\box_new:N \g_ptxcd_title_box

\cs_new:Nn \ptxcd_make_title_info_box:n {
	\usekomafont{titleinfo}
	\setlength{\fboxsep}{.2\baselineskip}
	\colorbox{InfoBox}{\hspace*{\dimexpr.2\c_ptxcd_logoheight_dim-\fboxsep}%
		\parbox{2\c_ptxcd_logoheight_dim}{
			\raggedright
			#1
		}}
}

\cs_new:Nn \ptxcd_make_title_logo_box:n {
	\setlength{\fboxsep}{\z@}%
	\parbox{\__ptxcd_logowidth:}{
		\colorbox{InfoBox}{
			\rlap{
				\makebox[\dim_eval:n {\_ptxcd_logowidth: + \_ptxcd_logowsep:}][r]{
					\colorbox{InfoBox}{#1\hspace{\__ptxcd_logosep:}}
				}
			}
		}
	}
}


\newcommand{\addTitleBox}[1]{\seq_gput_right:Nn \g_ptxcd_title_info_seq {\ptxcd_make_title_info_box:n {#1}}}

\NewDocumentCommand{\addTitleBoxLogo}{sm}{
	\IfBooleanTF{#1}{
		\seq_gput_right:Nn \g_ptxcd_title_info_seq {
			\ptxcd_make_title_logo_box:n {#2}
		}
	}{
		\seq_gput_right:Nn \g_ptxcd_title_info_seq {
			\ptxcd_make_title_logo_box:n {
				\hbox_set:Nn \l_tmpa_box {
					\includegraphics[width=1.5\c_ptxcd_logoheight_dim]{#2}
				}
				\dim_set:Nn \l_tmpa_dim {2\c_ptxcd_logoheight_dim/3}
				\dim_compare:nTF {\box_ht:N \l_tmpa_box > \l_tmpa_dim}
				{\includegraphics[width=\l_tmpa_dim]{#2}}
				{\box_use:N \l_tmpa_box}
			}
		}
	}
}

\cs_new:Nn \ptxcd_Setup_Title_box: {
	\hbox_gset:Nn \g_ptxcd_title_info_box
	{\parbox{\__ptxcd_logowidth:}{
			\seq_use:Nn \g_ptxcd_title_info_seq  {\par\nointerlineskip\skip_vertical:n
				{
					\box_ht:N \ptxcd_headrule_box + \box_dp:N \ptxcd_headrule_box
				}
			}
		}}
}


\tl_new:N \g_ptxcd_poster_foot_tl
\newcommand{\footer}[1]{
	\tl_gset:Nn \g_ptxcd_poster_foot_tl {#1}
}

\tl_new:N \g_ptxcd_poster_qrcode_tl
\newcommand*{\footerqrcode}[1]{
	\tl_gset:Nn \g_ptxcd_poster_qrcode_tl
	{\raisebox{\depth}{\qrcode[height={\g_ptxcd_qrcode_dim}]{#1}}}
}

\newcommand*{\footerqrcodeimg}[1]{\tl_gset:Nn \g_ptxcd_poster_qrcode_tl {#1}}


\RedeclareSectionCommand[afterskip=1ex plus .2ex]{section}
\RedeclareSectionCommand[afterskip=.2ex plus .2ex]{subsection}

\msg_new:nnn{tudaposter} {infobox-too-high} {
	The~height~of~your~Infobox~exeeds~the~space~reserved~in~the~title~block.\\
	You~should~probably~switch~to~logo=bottom~or~reduce~the~number/size~of~InfoBoxes.
}

\keys_define:nn {ptxcd/poster/marginparopts}{
	valign .tl_set:N = \l_ptxcd_marginpar_valign_tl,
	valign .initial:n = t,
	overlap .bool_set:N = \l_ptxcd_marginpar_overlap_bool,
	overlap .initial:n = false,
	overlap .default:n = true
}




\newcommand*{\infofont}{\accentfont\normalcolor\footnotesize}
\DeclareTextFontCommand{\infotext}{\infofont}

\int_new:N \g_ptxcd_marginpar_int

\NewDocumentCommand{\SetMarginpar}{o+m}{
	\bool_if:NF \g_ptxcd_marginpar_bool {\msg_warning:nn {ptxcd/Poster} {marginpar-disabled}}
	\IfNoValueF{#1}{\keys_set:nn {ptxcd/poster/marginparopts} {#1}}
	\ModifyLayer[addvoffset={-\ht\strutbox},contents={\parbox[t][\layerheight][\l_ptxcd_marginpar_valign_tl]{\layerwidth}{#2\strut}}]{TUDa.poster.marginpar}
	\bool_set_true:N \l_tmpa_bool
}

\msg_new:nnnn {ptxcd/Poster} {marginpar-disabled} {
	You~are~adding~data~to~the~marginpar~box,~though~marginpar option is set to false.\\
	I~will~add~it,~but~cannot~ensure~the~position.
} {
	I'd~suggest~to~switch~the~marginpar~option~to~true.
	See~the~TUDa-CI~documentation~for~further~information.
}

\global\def\contentwidth{\linewidth}
\global\def\contentheight{\g_ptxcd_titlegraphic_max_height_dim}

%author setup

\seq_new:N \g_ptxcd_author_seq

\renewcommand*\author[1]{
	\seq_gset_split:Nnn \g_ptxcd_author_seq {\and} {#1}
}

\msg_new:nnn{tudapub} {unknown-language} {
	You~selected~an~unknown~language~#1.\\
	The~Variable~#2~does~not~have~a~predefined~value.\\
	Ensure~to~redefine~#2~to~match~your~language.\\
	Otherwise~the~ngerman~vaue~#3~will~be~used.
}

\cs_new:Nn \ptxcd_define_captionFallback:Nn {
	\providecommand*#1{
		\msg_warning:nnxxx{tudapub} {unknown-language}
		{\languagename} {\exp_not:N #1} {#2}
		\def#1{#2}
	}
}

\cs_new:Nn \ptxcd_declare_caption:Nnnn {
	\ptxcd_define_captionFallback:Nn #1 {#2}
	\defcaptionname{ngerman, german}{#1}{#2}
	\defcaptionname{english, USenglish, american}{#1}{#3}
	\defcaptionname{UKenglish, british}{#1}{#4}
}

\cs_new:Nn \ptxcd_declare_caption:Nnn {
	\ptxcd_declare_caption:Nnnn #1 {#2} {#3} {#3}
}

\renewcommand*{\@author}{
	\begingroup
	\hyphenpenalty=100000
	\seq_use:Nnnn \g_ptxcd_author_seq {~\authorandname{}~} {,~} {~\&~}
	\endgroup
}

\ptxcd_declare_caption:Nnn \authorandname {und} {and}

\newcommand*{\ptxcd_title@footnote}[2][1]{
	\textsuperscript{#1}#2
}

\file_if_exist_input:n {\g__ptxcd_config_prefix_tl\g_ptxcd_department_str.cfg}


\endinput
