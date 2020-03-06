\def\filedate{2020/02/02}
\def\fileversion{}
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplPackage{tudaleaflet}{\filedate}{\fileversion}{Leaflets using the Corporate Design of TU Darmstadt}

\RequirePackage{l3keys2e}
\keys_define:nn {TUDa/leaflet} {
	logofile .tl_gset:N = \g_TUDa_logofile_tl,
	logofile .initial:n = tuda_logo,
	color .meta:n = {accentcolor=#1},
	accentcolor .code:n = {\PassOptionsToPackage{accentcolor=#1}{tudacolors}},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccentcolor=#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{identbarcolor=#1}{tudacolors}},
	colorback .bool_gset:N = \g_TUDa_colorback_bool,
	colorback .initial:n = true,
	colorback .default:n = true,
	colorbacktitle .bool_gset:N = \g_TUDa_colorbacktitle_bool,
	colorbacktitle .initial:n = false,
	colorbacktitle .default:n = true,
	colorbacksubtitle .bool_set:N = \g_TUDa_colorbacksubtitle_bool,
	colorbacksubtitle .initial:n = false,
	colorbacksubtitle .default:n = true,
}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{leaflet}}

\ProcessKeysOptions{TUDa/leaflet}
\ProcessOptions\relax

\bool_if:NT \g_TUDa_colorbacksubtitle_bool {
	\bool_if:NF \g_TUDa_colorbacktitle_bool {
		\msg_new:nnnn {TUDa/leaflet} {incompatible-options} {You~cannot~use~the~setting~#1~at~the~same~time~as~#2.} {See~TUDaLeaflet~documentation~for~further~information.}
		\msg_error:nn {TUDa/leaflet} {incompatible-options} {colorbacksubtitle=true} {colorbacktitle=false}
	}
}

\LoadClass[notumble,9pt]{leaflet}

%to workaround incompatibilities between leaflet and scrextend
\let\sectfont\relax
\RequirePackage{scrextend}
\RequirePackage{scrlayer}
\PassOptionsToPackage{cmyk}{tudacolors}
\usepackage[paper=leaflet]{tudarules}


\setlength{\headheight}{1cm}%to add headline
\setlength{\footheight}{2mm}
\setmargins{10mm}{\dimexpr10mm+\headheight\relax}{10mm}{10mm}%Hardcoded, according to the guideline

\TUDa@makeheadrule[color=identbarcolor]{TUDa_headrule}
\box_new:N \TUDa_footrule_box
\hbox_gset:Nn \TUDa_footrule_box {\rule{\textwidth}{.5\c_TUDa_smallrule_dim}}

\dim_new:N \g_TUDa_titlerule_dim
\dim_gset:Nn \g_TUDa_titlerule_dim {.5\c_TUDa_smallrule_dim}

\DeclareNewLayer[
	head,
	mode=picture,
	contents=\putUL{\box_use:N \TUDa_headrule_box}
]{TUDa.flyer.headline}

\DeclareNewLayer[
	foot,
	mode=picture,
	height=\z@,
	voffset=\paperheight-14mm,
	contents=\smash{\box_use:N \TUDa_footrule_box}
]{TUDa.flyer.footline}

\DeclareNewPageStyleByLayers{TUDa.flyer}{
	TUDa.flyer.headline,
	TUDa.flyer.footline,
}

% Title specific additions to pagestyle

\DeclareNewLayer[textarea,background,mode=picture,
addheight=\headheight-\box_dp:N \TUDa_headrule_box+\c_TUDa_rulesep_dim,
contents={
	\bool_if:NT \g_TUDa_colorback_bool {\putLL{\color{identbarcolor}\rule{\layerwidth}{\layerheight}}}
	\tl_if_empty:NTF \g_TUDa_titleimage_code_tl
	{\bool_if:NT \g_TUDa_colorback_bool {\putLL{\color{identbarcolor}\rule{\layerwidth}{\layerheight}}}\show\test}
	{\putUL{\color{identbarcolor}\raisebox{-\height}{\parbox[t]{\textwidth}{
					\let\width\layerwidth
					\let\height\layerheight
					\g_TUDa_titleimage_code_tl
	}}}}
	\put(\dim_to_decimal_in_unit:nn {\layerwidth-2.2\c_TUDa_logoheight_dim
	} {\unitlength},
	\dim_to_decimal_in_unit:nn {\layerheight-\box_ht:N \g_TUDa_title_info_box - .5\c_TUDa_logoheight_dim} {\unitlength}){
		\rlap{\box_use:N \g_TUDa_title_info_box}
	}
	\put(0,0){\rule{\linewidth}{\g_TUDa_titlerule_dim}}
}
]{title.TUDa.image}

\DeclareNewLayer[textarea,background,mode=picture,
	contents={
	\bool_if:NT \g_TUDa_colorbacktitle_bool {
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

\cs_new:Nn \TUDa_Setup_Title_box: {
	\hbox_gset:Nn \g_TUDa_title_info_box
	{
		\parbox{\dimexpr2.5\c_TUDa_logoheight_dim}{
			\seq_use:Nn \g_TUDa_title_info_seq  {\par\nointerlineskip\vspace{\dim_eval:n {\c_TUDa_largerule_dim+\c_TUDa_rulesep_dim}}}
		}
	}
}

\newcommand*\sectionlinesformat[1]{%
	\parbox{\linewidth}{
		\rule[\TUDa_titlerule_sep:]{\linewidth}{\g_TUDa_titlerule_dim}\par\nointerlineskip
		#1\strut\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par\nointerlineskip
		\skip_vertical:n {\TUDa_titlerule_sep: -.5\dp\strutbox}
		\smash{\rule{\linewidth}{\g_TUDa_titlerule_dim}}
	}
}

% Titlepage
\newcommand*{\raggedtitle}{\raggedright}
\renewcommand*{\maketitle}{
	\def\and{,~ }
	\begin{titlepage}
		\def\thefootnote{\fnsymbol{footnote}}
		\hbox_gset:Nn \g_TUDa_title_box {
			\parbox[t]{\linewidth}{
				\begin{minipage}[b]{\linewidth}
					\bool_if:NT \g_TUDa_colorbacktitle_bool {\color{textonaccentcolor}}
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
				\bool_if:NTF \g_TUDa_colorbacksubtitle_bool
				{\textcolor{white}{\rule{\linewidth}{\c_TUDa_rulesep_dim}}}
				{\rule{\linewidth}{\g_TUDa_titlerule_dim}}
				\par
				\vspace{\c_TUDa_rulesep_dim}
				\begin{addmargin}{3mm}
					\bool_if:NT \g_TUDa_colorbacksubtitle_bool {\color{textonaccentcolor}}
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
				\vspace{\c_TUDa_rulesep_dim}
				\bool_if:NT \g_TUDa_colorbacktitle_bool
				{
					\textcolor{white}{\rule{\linewidth}{\c_TUDa_rulesep_dim}}\par\nointerlineskip
				}
				\rule{\linewidth}{\g_TUDa_titlerule_dim}\par
			}
		}
		\TUDa_adjust_titlepage_style:
		\par
		\vspace*{\dimexpr.5\c_TUDa_logoheight_dim-\topskip}
		\box_use:N \g_TUDa_title_box
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


\cs_set:Nn 	\TUDa_adjust_titlepage_style: {
	\dim_set:Nn \l_tmpa_dim {1\c_TUDa_logoheight_dim}%\fp_to_dim:n {2.8\baselineskip}}
	\dim_compare:nT  {\box_ht:N \g_TUDa_title_box < \l_tmpa_dim} {
		\skip_set:Nn \g_TUDa_title_fill_skip {\dim_eval:n {\l_tmpa_dim -  \box_ht:N \g_TUDa_title_box}}
	}
	
	\dim_set:Nn \l_tmpa_dim {
		+\box_ht:N \g_TUDa_title_box
		+.5\c_TUDa_logoheight_dim
		+\box_dp:N \g_TUDa_title_box
		+\g_TUDa_title_fill_skip
	}
	
	\ModifyLayer[
	addvoffset=\l_tmpa_dim,
	addheight=-\l_tmpa_dim
	]{title.TUDa.image}
	\ModifyLayer[
	addvoffset={-\dim_eval:n {\headheight -\box_ht:N \TUDa_headrule_box-\box_dp:N \TUDa_headrule_box }},
	height={
		\bool_if:NT \g_TUDa_colorbacksubtitle_bool {\box_dp:N \g_TUDa_title_box}
		+\box_ht:N \g_TUDa_title_box+\g_TUDa_title_fill_skip+.5\c_TUDa_logoheight_dim+
		\headheight -\box_ht:N \TUDa_headrule_box-\box_dp:N \TUDa_headrule_box
	}
	]{title.TUDa.background}
	
	\AddLayersToPageStyle{title.TUDa}{title.TUDa.background}
	\thispagestyle{title.TUDa}
	\nointerlineskip
	\TUDa_Setup_Title_box:
	\par
	\vspace*{\skip_use:N \g_TUDa_title_fill_skip}
	\setlength{\fboxsep}{\z@}
}
%

\pagestyle{TUDa.flyer}

\RequirePackage{tudafonts}
\renewcommand*{\familydefault}{\sfdefault}

%Titlepage font setup
\setkomafont{disposition}{\accentfont\bfseries}
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

\show\test

\clist_map_inline:nn {section, subsection, subsubsection} {
	\cs_set_eq:cc {TUDa_save_#1} {#1}
	\exp_args:Nc \RenewDocumentCommand{#1}{sO{##3}m}{
		\IfBooleanTF{##1}{
			\use:c {TUDa_save_#1}*{\sectionlinesformat{##3}}
		}{
			\use:c {TUDa_save_#1}[##2]{\sectionlinesformat{##3}}
		}
	}
}

\cs_new:Nn \TUDa_titlerule_sep: {\the\dp\strutbox}

\def\subtitle#1{\def\@subtitle{#1}}
\subtitle{}

\tl_new:N  \g_TUDa_titleimage_code_tl
\tl_gset_eq:NN  \g_TUDa_titleimage_code_tl \c_empty_tl
\newcommand{\titleimage}[1]{\tl_gset:Nn \g_TUDa_titleimage_code_tl {#1}}

\box_new:N  \g_TUDa_title_box
\skip_new:N \g_TUDa_title_fill_skip

\seq_new:N \g_TUDa_title_info_seq
\box_new:N \g_TUDa_title_info_box

\colorlet{TUDa@InfoBoxColor}{white}

\cs_new:Nn \TUDa_make_title_info_box:n {
	\setlength{\fboxsep}{1.5mm}%
	\colorbox{TUDa@InfoBoxColor}{
		\makebox[\dim_eval:n {2.2\c_TUDa_logoheight_dim-\fboxsep}][r]{
			\parbox{2\c_TUDa_logoheight_dim}{
				\usekomafont{institution}
				\raggedright%
				#1
	}}}
}

\cs_new:Nn \TUDa_make_title_logo_box:n {
	\setlength{\fboxsep}{\z@}
	\parbox{2.2\c_TUDa_logoheight_dim}{
		\colorbox{TUDa@InfoBoxColor}{
			\rlap{
				\makebox[2.5\c_TUDa_logoheight_dim][r]{
					\colorbox{TUDa@InfoBoxColor}{#1\hspace{.3\c_TUDa_logoheight_dim}}
				}
			}
		}
	}
}

\newcommand{\addTitleBox}[1]{\seq_gput_right:Nn \g_TUDa_title_info_seq {\TUDa_make_title_info_box:n {#1}}}

\NewDocumentCommand{\addTitleBoxLogo}{sm}{
	\IfBooleanTF{#1}{
		\seq_gput_right:Nn \g_TUDa_title_info_seq {
			\TUDa_make_title_logo_box:n {#2}
		}
	}{
		\seq_gput_right:Nn \g_TUDa_title_info_seq {
			\TUDa_make_title_logo_box:n {
				\hbox_set:Nn \l_tmpa_box {
					\includegraphics[width=1.5\c_TUDa_logoheight_dim]{#2}
				}
				\dim_set:Nn \l_tmpa_dim {2\c_TUDa_logoheight_dim/3}
				\dim_compare:nTF {\box_ht:N \l_tmpa_box > \l_tmpa_dim}
				{\includegraphics[width=\l_tmpa_dim]{#2}}
				{\box_use:N \l_tmpa_box}
			}
		}
	}
}

\addTitleBoxLogo*{\makebox[\linewidth][l]{\includegraphics[height=\c_TUDa_logoheight_dim]{\g_TUDa_logofile_tl}}}
\date{}

\endinput