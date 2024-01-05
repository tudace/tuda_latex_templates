%% This is file `tudaleaflet.cls' version 3.36 (2024-01-05),
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

\ProvidesExplPackage{tudaleaflet}{\filedate}{\fileversion}{Leaflets using the Corporate Design of TU Darmstadt}

\str_const:Nn \c__ptxcd_base_str {leaflet}

\tl_new:N \g_ptxcd_sponsor_pos_tl
\keys_define:nn {ptxcd/leaflet} {
	logofile .tl_gset:N = \g_ptxcd_logofile_tl,
	logofile .initial:n = tuda_logo,
	color .meta:n = {accentcolor=#1},
	accentcolor .code:n = {\PassOptionsToPackage{accentcolor=#1}{tudacolors}},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccentcolor=#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{identbarcolor=#1}{tudacolors}},
	colorback .bool_gset:N = \g_ptxcd_colorback_bool,
	colorback .initial:n = true,
	colorback .default:n = true,
	colorbacktitle .bool_gset:N = \g_ptxcd_colorbacktitle_bool,
	colorbacktitle .initial:n = false,
	colorbacktitle .default:n = true,
	colorbacksubtitle .bool_set:N = \g_ptxcd_colorbacksubtitle_bool,
	colorbacksubtitle .initial:n = false,
	colorbacksubtitle .default:n = true,
	sponsor .choices:nn = {title,lastfoot,manual}{\tl_gset_eq:NN \g_ptxcd_sponsor_pos_tl \l_keys_choice_tl},
	sponsor .initial:n = title,
	department .choice:,
	department / default .code:n = \str_gset:Nn \g_ptxcd_department_str {default},
	department / mecheng .code:n = {
		\str_gset:Nn \g_ptxcd_department_str {mecheng}
		\keys_set:nn {ptxcd/leaflet} {colorback=false, departmentlogofile=tuda_maschinenbau_logo}
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

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{leaflet}}

\ProcessKeyOptions[ptxcd/leaflet]
\ProcessOptions\relax

\bool_if:NT \g_ptxcd_colorbacksubtitle_bool {
	\bool_if:NF \g_ptxcd_colorbacktitle_bool {
		\msg_new:nnnn {ptxcd/leaflet} {incompatible-options} {You~cannot~use~the~setting~#1~at~the~same~time~as~#2.} {See~TUDaLeaflet~documentation~for~further~information.}
		\msg_error:nn {ptxcd/leaflet} {incompatible-options} {colorbacksubtitle=true} {colorbacktitle=false}
	}
}

\LoadClass[notumble]{leaflet}

%to workaround incompatibilities between leaflet and scrextend
\let\sectfont\relax
\RequirePackage{scrextend}
\RequirePackage{scrlayer}
\PassOptionsToPackage{cmyk}{tudacolors}
\usepackage[paper=leaflet]{tudarules}


\setlength{\headheight}{1cm}%to add headline
\setlength{\footheight}{2mm}
\setmargins{10mm}{\dimexpr10mm+\headheight\relax}{10mm}{10mm}%Hardcoded, according to the guideline

\DeclareNewLayer[
	head,
	mode=picture,
	contents=\putUL{\box_use:N \ptxcd_headrule_box}
]{TUDa.flyer.headline}

\DeclareNewLayer[
	foot,
	mode=picture,
	height=\z@,
	voffset=\paperheight-14mm,
	contents=\smash{\box_use:N \ptxcd_footrule_box}
]{TUDa.flyer.footline}

\DeclareNewPageStyleByLayers{TUDa.flyer}{
	TUDa.flyer.headline,
	TUDa.flyer.footline,
}

% Title specific additions to pagestyle

\DeclareNewLayer[textarea,mode=picture,
addheight=\headheight-\box_dp:N \ptxcd_headrule_box+\dp\strutbox,
contents={
	\bool_if:NT \g_ptxcd_colorback_bool {\putLL{\color{identbarcolor}\rule{\layerwidth}{\layerheight}}}
	\tl_if_empty:NTF \g_ptxcd_titleimage_code_tl
	{\bool_if:NT \g_ptxcd_colorback_bool {\putLL{\color{identbarcolor}\rule{\layerwidth}{\layerheight}}}}
	{\putUL{\color{identbarcolor}\raisebox{-\height}{\parbox[t]{\textwidth}{
					\let\width\layerwidth
					\let\height\layerheight
					\g_ptxcd_titleimage_code_tl
	}}}}
	\put(\dim_to_decimal_in_unit:nn {\layerwidth-\__ptxcd_logowidth:
	} {\unitlength},
	\dim_to_decimal_in_unit:nn {\layerheight-\box_ht:N \g_ptxcd_title_info_box - .5\c_ptxcd_logoheight_dim} {\unitlength}){
		\rlap{\box_use:N \g_ptxcd_title_info_box}
	}
}
]{title.TUDa.image}

\DeclareNewLayer[textarea,background,mode=picture,
	contents={
	\bool_if:NT \g_ptxcd_colorbacktitle_bool {
		\color{identbarcolor}\rule{\layerwidth}{\layerheight}
	}
	}
]{title.TUDa.background}

\DeclareNewPageStyleByLayers{title.TUDa}{
	title.TUDa.image,
	title.TUDa.background,
	TUDa.flyer.headline,
	TUDa.flyer.footline,
}

\cs_new:Nn \ptxcd_Setup_Title_box: {
	\hbox_gset:Nn \g_ptxcd_title_info_box
	{
		\parbox{\dim_eval:n {\__ptxcd_logowidth: + \__ptxcd_logosep:}}{
			\seq_use:Nn \g_ptxcd_title_info_seq  {\par\nointerlineskip\vspace{\dim_eval:n {\c_ptxcd_largerule_dim+\c_ptxcd_rulesep_dim}}}
		}
	}
}

\newcommand*\sectionlinesformat[1]{%
	\parbox{\linewidth}{
		\rule[\ptxcd_titlerule_sep:]{\linewidth}{\g_ptxcd_titlerule_dim}\par\nointerlineskip
		#1\strut\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par\nointerlineskip
		\skip_vertical:n {\ptxcd_titlerule_sep: -.5\dp\strutbox}
		\smash{\rule{\linewidth}{\g_ptxcd_titlerule_dim}}
	}
}

% Titlepage
\newcommand*{\raggedtitle}{\raggedright}
\renewcommand*{\maketitle}{
	\def\and{,~ }
	\hbox_gset:Nn \g_ptxcd_sponsor_box {
		\edef\height{\noexpand\dimexpr\dim_eval:n {\__ptxcd_logosep: + .5\c_ptxcd_logoheight_dim}}
		\parbox[b]{\textwidth}{%
			\rule{\linewidth}{\g_ptxcd_titlerule_dim}\par\nointerlineskip
			\vspace{.1\c_ptxcd_logoheight_dim}
			\seq_use:Nn \g_ptxcd_sponsors_seq {\hfill}\par
			\addvspace{.1\c_ptxcd_logoheight_dim}
			\ifx\@sponsors\@empty
			\else
			\@sponsors\par
			\fi
			\par\nointerlineskip\addvspace{\dim_eval:n {.1\c_ptxcd_logoheight_dim-\c_ptxcd_rulesep_dim}}
%			\rule{\linewidth}{\g_ptxcd_titlerule_dim}
		}
	}
	\begin{titlepage}
		\def\thefootnote{\fnsymbol{footnote}}
		\hbox_gset:Nn \g_ptxcd_title_box {
			\parbox[t]{\linewidth}{
				\begin{minipage}[b]{\linewidth}
					\bool_if:NT \g_ptxcd_colorbacktitle_bool {\color{textonaccentcolor}}
					\begin{addmargin}{3mm}
						\raggedtitle
						\Huge
						\usekomafont{disposition}
						\usekomafont{title}
						\leavevmode%
						\@title\strut\par
						\vskip0pt
					\end{addmargin}
				\end{minipage}%
				\par\nointerlineskip
				\bool_if:NTF \g_ptxcd_colorbacksubtitle_bool
				{\textcolor{white}{\rule{\linewidth}{\c_ptxcd_rulesep_dim}}}
				{\rule{\linewidth}{\g_ptxcd_titlerule_dim}}
				\par
				\vspace{\c_ptxcd_rulesep_dim}
				\begin{addmargin}{3mm}
					\bool_if:NT \g_ptxcd_colorbacksubtitle_bool {\color{textonaccentcolor}}
					\raggedtitle
					\usekomafont{disposition}
					{\ifx\@subtitle\@empty\else\usekomafont{subtitle}{\@subtitle\par}\fi}%
					{%
						\usekomafont{author}
						\lineskip 0.75em
						\@author
						\par
					}%
					{\usekomafont{date}{\@date\par}}%
				\end{addmargin}\nointerlineskip
				\vspace{\c_ptxcd_rulesep_dim}
				\bool_if:NT \g_ptxcd_colorbacktitle_bool
				{
					\textcolor{white}{\rule{\linewidth}{\c_ptxcd_rulesep_dim}}\par\nointerlineskip
				}
				\rule{\linewidth}{\g_ptxcd_titlerule_dim}\par
			}
		}
		\ptxcd_adjust_titlepage_style:
		\par
		\vspace*{\dimexpr.5\c_ptxcd_logoheight_dim-\topskip}
		\box_use:N \g_ptxcd_title_box
		\par
		\vfill\null
		\if@twoside
		\@tempswatrue
		\expandafter\ifnum \@nameuse{scr@v@3.12}>\scr@compatibility\relax
		\else
		\ifx\@uppertitleback\@empty\ifx\@lowertitleback\@empty
		\@tempswafalse
		\fi\fi
		\fi
		\fi
	\end{titlepage}
	\setcounter{footnote}{0}%
	\global\let\and\relax
}


\cs_set:Nn 	\ptxcd_adjust_titlepage_style: {
	\dim_set:Nn \l_tmpa_dim {1\c_ptxcd_logoheight_dim}%\fp_to_dim:n {2.8\baselineskip}}
	\dim_compare:nT  {\box_ht:N \g_ptxcd_title_box < \l_tmpa_dim} {
		\skip_set:Nn \g_ptxcd_title_fill_skip {\dim_eval:n {\l_tmpa_dim -  \box_ht:N \g_ptxcd_title_box}}
	}
	
	\dim_set:Nn \l_tmpa_dim {
		+\box_ht:N \g_ptxcd_title_box
		+.5\c_ptxcd_logoheight_dim
		+\box_dp:N \g_ptxcd_title_box
		+\g_ptxcd_title_fill_skip
	}
	\ModifyLayer[
	addvoffset=\l_tmpa_dim,
	addheight= -\l_tmpa_dim
	]{title.TUDa.image}
	\DeclareNewLayer[clone=TUDa.flyer.footline,
	mode=picture,
	align=bl,
	height=\box_ht:N  \g_ptxcd_sponsor_box + \box_dp:N  \g_ptxcd_sponsor_box,
	addvoffset=-\dp\strutbox,
	contents=\raisebox{\depth}{\box_use:N \g_ptxcd_sponsor_box}
	]
	{title.TUDa.sponsor}
	\exp_args:Nx \tl_if_eq:nnT {\g_ptxcd_sponsor_pos_tl} {title} {
		\AddLayersToPageStyle{title.TUDa}{title.TUDa.sponsor}
		\ModifyLayer[
		addheight=-\box_ht:N  \g_ptxcd_sponsor_box -\box_dp:N  \g_ptxcd_sponsor_box-\dp\strutbox
		]{title.TUDa.image}
	}
	\ModifyLayer[
	addvoffset={-\dim_eval:n {\headheight -\box_ht:N \ptxcd_headrule_box-\box_dp:N \ptxcd_headrule_box }},
	height={
		\bool_if:NT \g_ptxcd_colorbacksubtitle_bool {\box_dp:N \g_ptxcd_title_box}
		+\box_ht:N \g_ptxcd_title_box+\g_ptxcd_title_fill_skip+.5\c_ptxcd_logoheight_dim+
		\headheight -\box_ht:N \ptxcd_headrule_box-\box_dp:N \ptxcd_headrule_box
	}
	]{title.TUDa.background}
	
	\AddLayersToPageStyle{title.TUDa}{title.TUDa.background}
	\thispagestyle{title.TUDa}
	\nointerlineskip
	\ptxcd_Setup_Title_box:
	\par
	\vspace*{\skip_use:N \g_ptxcd_title_fill_skip}
	\setlength{\fboxsep}{\z@}
}
%

\pagestyle{TUDa.flyer}

\RequirePackage{tudafonts}
\renewcommand*{\familydefault}{\sfdefault}

%Titlepage font setup
%compatibility after disposition was removed from scrextend
\expandafter\ifx\csname scr@fnt@disposition\endcsname\relax
	\newkomafont{disposition}
\fi
\setkomafont{disposition}{\bfseries}
\setkomafont{title}{\Huge}
\setkomafont{subtitle}{}
\setkomafont{date}{}
\setkomafont{author}{}
\newkomafont{institution}{}

%Adjust section font setup to be komafont compatible
\newkomafont{section}{}
\newkomafont{subsection}{}
\newkomafont{subsubsection}{}

\renewcommand\section{\@startsection{section}{1}{\z@}%
	{-3.5ex \@plus -.75ex}%
	{1ex}%
	{\usekomafont{disposition}\usekomafont{section}\sectfont}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
	{-2.5ex plus -.5ex}%
	{1\p@}%
	{\usekomafont{disposition}\usekomafont{subsection}\sectfont}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
	{-2.5ex plus -.5ex}%
	{-1em}%
	{\usekomafont{disposition}\usekomafont{subsubsection}\sectfont}}

\clist_map_inline:nn {section, subsection, subsubsection} {
	\cs_set_eq:cc {ptxcd_save_#1} {#1}
	\exp_args:Nc \RenewDocumentCommand{#1}{sO{##3}m}{
		\IfBooleanTF{##1}{
			\use:c {ptxcd_save_#1}*{\sectionlinesformat{##3}}
		}{
			\use:c {ptxcd_save_#1}[##2]{\sectionlinesformat{##3}}
		}
	}
}

\cs_new:Nn \ptxcd_titlerule_sep: {\the\dp\strutbox}

\def\subtitle#1{\def\@subtitle{#1}}
\subtitle{}

\seq_new:N \g_ptxcd_sponsors_seq
\def\AddSponsor{\seq_gput_right:Nn \g_ptxcd_sponsors_seq}

\def\sponsors#1{\def\@sponsors{#1}}
\sponsors{}

\box_new:N \g_ptxcd_sponsor_box

\newcommand*{\footergraphics}[1]{
	\begingroup
	\let\height\g_ptxcd_footheight_dim
	\hbox_gset:Nn \g_ptxcd_footergraphics_box {#1}
	\endgroup
}

\tl_new:N  \g_ptxcd_titleimage_code_tl
\tl_gset_eq:NN  \g_ptxcd_titleimage_code_tl \c_empty_tl
\newcommand{\titleimage}[1]{\tl_gset:Nn \g_ptxcd_titleimage_code_tl {#1}}

\author{}%to remove warning if no author given

\box_new:N  \g_ptxcd_title_box
\skip_new:N \g_ptxcd_title_fill_skip

\seq_new:N \g_ptxcd_title_info_seq
\box_new:N \g_ptxcd_title_info_box

\cs_new:Nn \ptxcd_make_title_info_box:n {
	\setlength{\fboxsep}{1.5mm}%
	\colorbox{InfoBox}{
		\makebox[\dim_eval:n {\__ptxcd_logowidth:-\fboxsep}][r]{
			\parbox{2\c_ptxcd_logoheight_dim}{
				\usekomafont{institution}
				\raggedright%
				#1
	}}}
}

\cs_new:Nn \ptxcd_make_title_logo_box:n {
	\setlength{\fboxsep}{\z@}
	\parbox{\__ptxcd_logowidth:}{
		\colorbox{InfoBox}{
			\rlap{
				\makebox[\dim_eval:n {\__ptxcd_logowidth: + \__ptxcd_logosep:}][r]{
					\colorbox{InfoBox}{#1\hspace{.3\c_ptxcd_logoheight_dim}}
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

\addTitleBoxLogo*{\makebox[\linewidth][l]{\includegraphics[height=\c_ptxcd_logoheight_dim]{\g_ptxcd_logofile_tl}}}
\date{}

\let\insertSponsors\relax

\str_case:Vn \g_ptxcd_sponsor_pos_tl {
	{lastfoot}{
	\AtEndDocument{
		\par\vspace*{\fill}
		\leavevmode\raisebox{\dimexpr\depth-\baselineskip}[0pt][0pt]{
			\box_use:N \g_ptxcd_sponsor_box
		}
	}
	}
	{manual} {
		\renewcommand*{\insertSponsors}{\par\vfill\leavevmode\box_use:N \g_ptxcd_sponsor_box\par\nobreak\nointerlineskip\rule{\linewidth}{\g_ptxcd_titlerule_dim}
	}
}
}

\file_if_exist_input:n {\g__ptxcd_config_prefix_tl\g_ptxcd_department_str.cfg}

\ptxcd_makeheadrule[color=identbarcolor]{ptxcd_headrule}
\ptxcd_makefootrule{ptxcd_footrule}

\endinput
