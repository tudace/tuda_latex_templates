\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplPackage{tudaposter}{\filedate}{\fileversion}{Poster Layouts for the Corporate Design of TU Darmstadt}

\RequirePackage{l3keys2e}

\bool_new:N \g_TUDa_logo@inhead_bool
\dim_new:N \g_TUDa_margin_dim
\int_new:N \g_TUDa_paper_int
\int_new:N \g_TUDa_postertype_int

\keys_define:nn {TUDa/poster} {
	accentcolor .code:n = {\PassOptionsToPackage{accent=#1}{tudacolors}},
	color .meta:n = {accent=#1},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccent=#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{indentbar=#1}{tudacolors}},
	logo .choice:,
	logo / head .code:n = {\bool_gset_true:N \g_TUDa_logo@inhead_bool},
	logo / body .code:n = {\bool_gset_false:N \g_TUDa_logo@inhead_bool},
	logo / top .code:n = {\bool_gset_true:N \g_TUDa_logo@inhead_bool},
	logo / bottom .code:n = {\bool_gset_false:N \g_TUDa_logo@inhead_bool},
	logo .initial:n = {head},
	footer .bool_gset:N = \g_TUDa_poster_foot_bool,
	footer .default:n = true,
	footer .initial:n = false,
	footheight .dim_gset:N = \g_TUDa_footheight_dim,
	paper .choices:nn = {a0,a1,a2,a3,a4}{
		\int_gset_eq:NN \g_TUDa_paper_int  \l_keys_choice_int
		\PassOptionsToPackage{paper=\l_keys_choice_tl}{tudarules}
		\tl_gset_eq:NN \g_TUDa_paper_tl \l_keys_choice_tl
	},
	fontsize .choice:,
	fontsize / auto .code:n = \tl_gclear:N \g_TUDa_fontsize_tl,
	fontsize / unknown .code:n = {\@defaultunits\@tempdima#1pt\relax\@nnil \tl_gset:Nx \g_TUDa_fontsize_tl {\the\@tempdima}},
	fontsize .initial:n = auto,
	logofile .tl_gset:N = \g_TUDa_logofile_tl,
	logofile .initial:n = tuda_logo,
	type .choices:nn = {default, announcement}{\int_gset_eq:NN \g_TUDa_postertype_int \l_keys_choice_int},
	type .initial:n = default,
	indenttext .bool_gset:N = \g_TUDa_indenttext_bool,
	indenttext .initial:n = false,
	indenttext .default:n = true,
}


\ProcessKeysOptions{TUDa/poster}

\LoadClass[parskip=half-]{scrartcl}

\tl_if_empty:NT \l_keys_choice_tl {\keys_set:nn {TUDa/poster} {paper=a0}}



\int_case:nn {\g_TUDa_paper_int}
{
	%paper=a0
	{1} {
		\cs_set:Nn \TUDa_title_fontsize: {{132pt}{148pt}}
		\cs_set:Nn \TUDa_subtitle_fontsize: {{50pt}{62pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{45pt}{56pt}}
		\tl_if_empty:NT \g_TUDa_fontsize_tl {\tl_gset:Nn \g_TUDa_fontsize_tl {30pt}}
		\dim_gset:Nn \g_TUDa_margin_dim {30mm}
	}
	%paper=a1
	{2} {
		\cs_set:Nn \TUDa_title_fontsize: {{100pt}{124pt}}
		\cs_set:Nn \TUDa_subtitle_fontsize: {{35pt}{42pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{30pt}{37pt}}
		\tl_if_empty:NT \g_TUDa_fontsize_tl {\tl_gset:Nn \g_TUDa_fontsize_tl {25pt}}
		\dim_gset:Nn \g_TUDa_margin_dim {30mm}
	}
	%paper=a2
	{3} {
		\cs_set:Nn \TUDa_title_fontsize: {{72pt}{84pt}}
		\cs_set:Nn \TUDa_subtitle_fontsize: {{28pt}{34pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{25pt}{30pt}}
		\tl_if_empty:NT \g_TUDa_fontsize_tl {\tl_gset:Nn \g_TUDa_fontsize_tl {25pt}}
		\dim_gset:Nn \g_TUDa_margin_dim {30mm}
	}
	%paper=a3
	{4} {
		\cs_set:Nn \TUDa_title_fontsize: {{56pt}{68pt}}
		\cs_set:Nn \TUDa_subtitle_fontsize: {{22pt}{28pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{19pt}{24pt}}
		\tl_if_empty:NT \g_TUDa_fontsize_tl {\tl_gset:Nn \g_TUDa_fontsize_tl {17pt}}
		\dim_gset:Nn \g_TUDa_margin_dim {15mm}
	}
	%paper=a4
	{5} {
		\cs_set:Nn \TUDa_title_fontsize: {{42pt}{52pt}}
		\cs_set:Nn \TUDa_subtitle_fontsize: {{20pt}{25pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{17pt}{20pt}}
		\tl_if_empty:NT \g_TUDa_fontsize_tl {\tl_gset:Nn \g_TUDa_fontsize_tl {14pt}}
		\dim_gset:Nn \g_TUDa_margin_dim {15mm}
	}
}


\setkomafont{title}{\color{textonaccentcolor}\expandafter\fontsize\TUDa_title_fontsize:\selectfont}
\setkomafont{subtitle}{\expandafter\fontsize\TUDa_subtitle_fontsize:\selectfont}
\newkomafont{titleinfo}{\normalfont}


\KOMAoptions{fontsize=\g_TUDa_fontsize_tl}





\RequirePackage{tudafonts}
\renewcommand*{\familydefault}{\sfdefault}
\RequirePackage[paper=\g_TUDa_paper_tl,mode=tikz]{tudarules}

\RequirePackage{tudacolors}
\RequirePackage{qrcode}
\RequirePackage{tikz}




\newlength{\contentwidth}
\setlength{\contentwidth}{\dimexpr\paperwidth-2\g_TUDa_margin_dim}

\TUDa@makeheadrule[width=\contentwidth, color=identbarcolor]{TUDa@posterrule}

\TUDa@makefootrule[width=\contentwidth, color=identbarcolor]{TUDa@smallrule}

%%%%%%%%%%%%%%%%%%%%%%
\int_case:nn {\g_TUDa_postertype_int}
{
	{1} {}
	{2} {
		\addtokomafont{subtitle}{\bfseries}
		\keys_set:nn {TUDa/poster}{indenttext}
	}
}
%%%%%%%%%%%%%%%%%%%%%%
\dim_new:N \g_TUDa_titleindent_dim
\begingroup
\expandafter\fontsize\TUDa_title_fontsize:\selectfont
	\dim_gset:Nn \g_TUDa_titleindent_dim {.5ex}
\endgroup


\RequirePackage{geometry}
\geometry{
	margin= \g_TUDa_margin_dim,
	hmargin = \dim_eval:n {
		\g_TUDa_margin_dim +
		\bool_if:NTF \g_TUDa_indenttext_bool
		{\g_TUDa_titleindent_dim} {0pt}
	},
	top=\dim_eval:n {
		\box_ht:N \TUDa@posterrule_box + \box_dp:N \TUDa@posterrule_box
		+ .5\c_TUDa_logoheight_dim
		+\g_TUDa_margin_dim}
}

\setlength\columnsep{\g_TUDa_margin_dim}


\bool_if:NT \g_TUDa_poster_foot_bool {
	\dim_compare:nT {\g_TUDa_footheight_dim = 0pt} {
		\dim_set:Nn \g_TUDa_footheight_dim 
		{1.5\baselineskip}
	}
	\geometry{bottom=\dim_eval:n {\g_TUDa_footheight_dim+\footskip+\g_TUDa_margin_dim}}
} 
%%%%%%%%%%%%%%%%%%%%%%



\RequirePackage{scrlayer}

	
\dim_new:N \g_TUDa_qrcode_dim
\dim_gset:Nn \g_TUDa_qrcode_dim {.7\c_TUDa_logoheight_dim}	
	
\DeclareNewLayer[
	background,
	align=br,
	width=\g_TUDa_qrcode_dim,
	height=\g_TUDa_qrcode_dim,
	hoffset=\paperwidth-\g_TUDa_margin_dim,
	voffset=\paperheight-\g_TUDa_margin_dim,
	mode=picture,
	contents={%
		\tl_if_empty:NF \g_TUDa_poster_qrcode_tl {
 		\raisebox{\depth}{\qrcode[height=\dim_eval:n {\g_TUDa_qrcode_dim-2\fboxsep}]{\g_TUDa_poster_qrcode_tl}}
 		}
	}
 	]{TUDa.poster.qrcode}


\bool_if:NTF \g_TUDa_poster_foot_bool {
	\DeclareNewLayer[
	clone=TUDa.poster.qrcode,
	align=bl,
	hoffset=\g_TUDa_margin_dim,
	width=\paperwidth-2\g_TUDa_margin_dim,
	height=\g_TUDa_footheight_dim,
	contents={
		\putUL{\rule{\layerwidth}{.5\c_TUDa_smallrule_dim}}
		\put(0,0) {
			\parbox[b][\g_TUDa_footheight_dim][c]{\layerwidth}{\strut\g_TUDa_poster_foot_tl\strut}}
		\putLL{\rule{\layerwidth}{.5\c_TUDa_smallrule_dim}}
	}
	]{TUDa.poster.footer}
}{
	\DeclareNewLayer[
		clone=TUDa.poster.qrcode,
		align=bl,
		hoffset=\g_TUDa_margin_dim,
		width=\textwidth,
		height=0pt,
		contents={\smash{\rule{\layerwidth}{.5\c_TUDa_smallrule_dim}}}
	]{TUDa.poster.footer}
}

\DeclareNewLayer[
	background,mode=picture,
	width=\paperwidth-2\g_TUDa_margin_dim,
	hoffset=\g_TUDa_margin_dim,
	voffset=\g_TUDa_margin_dim+\box_ht:N \TUDa@posterrule_box + \box_dp:N \TUDa@posterrule_box,
	contents={\color{accentcolor}\rule{\layerwidth}{\layerheight}}
]{TUDa.poster.background}

\DeclareNewLayer[
%	clone=TUDa.poster.background,
	textarea,
	foreground,
	align=tr,
	addhoffset=\textwidth+\bool_if:NTF \g_TUDa_indenttext_bool {\g_TUDa_titleindent_dim}{0pt},
	width=2.2\c_TUDa_logoheight_dim,
	height=15cm,
	contents={\box_use:N \g_TUDa_title_info_box}
]{TUDa.poster.logo}

\DeclareNewLayer[
	clone=TUDa.poster.background,
%	textarea,
	align=tl,
	voffset=\g_TUDa_margin_dim,
	height=\box_ht:N \TUDa@posterrule_box + \box_dp:N \TUDa@posterrule_box,
	mode=picture,
	contents={
		\box_use:N \TUDa@posterrule_box
	}
]{TUDa.poster.rule}

\DeclareNewPageStyleByLayers{TUDa.poster.title}{TUDa.poster.rule,TUDa.poster.background,TUDa.poster.qrcode,TUDa.poster.footer}
\DeclareNewPageStyleByLayers{TUDa.poster}{TUDa.poster.rule,TUDa.poster.qrcode,TUDa.poster.footer}
\pagestyle{TUDa.poster}


\dim_new:N \g_TUDa_titlegraphic_max_height_dim
\skip_new:N \g_TUDa_title_fill_skip 

\renewcommand*{\maketitle}{
	\begingroup
	\setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
	\vbox_gset:Nn \g_TUDa_title_box {
		\usesizeofkomafont{title}
		\parbox[t]{\linewidth}{
			\begin{minipage}[b]{\bool_if:NT \g_TUDa_logo@inhead_bool {.75}\linewidth}
				\bool_if:NF \g_TUDa_indenttext_bool {\begin{addmargin}{\g_TUDa_titleindent_dim }}
					\usekomafont{title}
					\raggedright
					\tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
					\leavevmode\usekomafont{disposition}\usekomafont{title}%
					\@title\strut\par
				\bool_if:NTF \g_TUDa_indenttext_bool {\nointerlineskip\leavevmode}{\end{addmargin}}
			\end{minipage}%
			\par\nointerlineskip
			\bool_if:NT \g_TUDa_indenttext_bool {\hspace*{-\g_TUDa_titleindent_dim}}\TUDa@smallrule\usekomafont{subtitle}\par
			\bool_if:NF \g_TUDa_indenttext_bool {\begin{addmargin}{\g_TUDa_titleindent_dim }}
				\@subtitle\strut
			\bool_if:NF \g_TUDa_indenttext_bool {\end{addmargin}}
		 \par\nointerlineskip
		 \bool_if:NT \g_TUDa_indenttext_bool {\hspace*{-\g_TUDa_titleindent_dim}}\TUDa@smallrule
		}
	}
	\endgroup

	\TUDa_Setup_Title_box:
	\dim_compare:nT {\box_ht:N \g_TUDa_title_box < 2\c_TUDa_logoheight_dim} {
		\skip_set:Nn \g_TUDa_title_fill_skip {2\c_TUDa_logoheight_dim - \box_ht:N \g_TUDa_title_box}
	}
	\dim_set:Nn \l_tmpa_dim {\box_ht:N \g_TUDa_title_box+.5\c_TUDa_logoheight_dim+\g_TUDa_title_fill_skip}

	\ModifyLayer[
		height=\l_tmpa_dim
	]{TUDa.poster.background}
	
	\tl_if_empty:NF \g_TUDa_poster_qrcode_tl {
		\ModifyLayer[addwidth=-\g_TUDa_qrcode_dim-\c_TUDa_rulesep_dim]{TUDa.poster.footer}
	}
	
	\bool_if:NF \g_TUDa_logo@inhead_bool {
		\ModifyLayer[
		addvoffset=\l_tmpa_dim +\box_dp:N \g_TUDa_title_box+\c_TUDa_smallrule_dim
		]{TUDa.poster.logo}
	}

	\AddLayersToPageStyle{TUDa.poster.title}{TUDa.poster.logo}
	\begingroup

	\bool_if:NT \g_TUDa_logo@inhead_bool {
		\dim_compare:nT {\box_ht:N \g_TUDa_title_info_box+ \box_dp:N \g_TUDa_title_info_box  > \box_ht:N \g_TUDa_title_box} 
		{\msg_warning:nn {TUDaPoster} {infobox-too-high}}
	}

	\vspace*{\dim_eval:n {\g_TUDa_title_fill_skip-\topskip}}\nointerlineskip

	\box_use:N \g_TUDa_title_box
 
	\dim_set:Nn \g_TUDa_titlegraphic_max_height_dim {\textheight-\pagetotal}
	\global\def\contentheight{\g_TUDa_titlegraphic_max_height_dim}
	\global\def\contentwidth{\linewidth}
	\tl_if_empty:NF \@titlegraphic{
		\par\nointerlineskip
		\vbox{\parbox[t]{\linewidth}{\@titlegraphic}}
	}
	\thispagestyle{TUDa.poster.title}
	\endgroup\par
}

\global\def\contentwidth{\linewidth}
\global\def\contentheight{\g_TUDa_titlegraphic_max_height_dim}


\def\@titlegraphic{}
\newcommand{\titlegraphic}[1]{
	\def\@titlegraphic{#1}
}

\seq_new:N \g_TUDa_title_info_seq 

\seq_gput_right:Nn \g_TUDa_title_info_seq {
	\rlap{\includegraphics[height=\c_TUDa_logoheight_dim]{\g_TUDa_logofile_tl}}
}

\box_new:N \g_TUDa_title_info_box
\box_new:N \g_TUDa_title_box

\cs_new:Nn \TUDa_make_title_info_box:n {
	\usekomafont{titleinfo}
	\setlength{\fboxsep}{.2\baselineskip}
	\colorbox{white}{\hspace*{\dimexpr.2\c_TUDa_logoheight_dim-\fboxsep}%
		\parbox{2\c_TUDa_logoheight_dim}{
			\raggedright
			#1
	}}
}

\newcommand{\addTitleBox}[1]{\seq_gput_right:Nn \g_TUDa_title_info_seq {\TUDa_make_title_info_box:n {#1}}}

\cs_new:Nn \TUDa_Setup_Title_box: {
	\hbox_gset:Nn \g_TUDa_title_info_box
	{\parbox{2.2\c_TUDa_logoheight_dim}{
			\seq_use:Nn \g_TUDa_title_info_seq  {\par\nointerlineskip\skip_vertical:n
			{
			\box_ht:N \TUDa@posterrule_box + \box_dp:N \TUDa@posterrule_box
			}
		}
	}}
}


\tl_new:N \g_TUDa_poster_foot_tl
\newcommand{\footer}[1]{
	\tl_gset:Nn \g_TUDa_poster_foot_tl {#1}
}

\tl_new:N \g_TUDa_poster_qrcode_tl
\newcommand*{\footerqrcode}[1]{
	\tl_gset:Nn \g_TUDa_poster_qrcode_tl {#1}
}


\RedeclareSectionCommand[afterskip=1ex plus .2ex]{section}
\RedeclareSectionCommand[afterskip=.2ex plus .2ex]{subsection}

\msg_new:nnn {TUDaPoster} {infobox-too-high} {
	The~height~of~your~Infobox~exeeds~the~space~reserved~in~the~title~block.\\
	You~should~probably~switch~to~logo=bottom~or~reduce~the~number/size~of~InfoBoxes.
}

\endinput
