%%
\def\fileversion{1.01}
\def\filedate{2019/09/09}
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass{tudaexercise}
	{\filedate}{\fileversion}{Exercise sheets and exams using TU Darmstadt's Coporate Desing (TUDa-CI)}

\RequirePackage{l3keys2e}

\tl_new:N \g_TUDa_thesis_options_tl

\prop_new:N \g_TUDa_clsopts_prop
\prop_new:N \g_TUDa_unknown_clsopts_prop 
\prop_gput:Nnn \g_TUDa_clsopts_prop {captions} {nooneline}

\int_new:N \g_TUDa_ruledheaders_int
\int_new:N \g_TUDa_paper_int

%Message Declaration for option processing
\msg_new:nnn {TUDaExercise} {titlepage-option-disabled} {
	You~set~the~titlepage~option~to~#1.\\
	This option is not supported by tudaexercise.cls.\\
	The~KOMA-Script~option~titlepage~is~forced~to~"false".
}

\bool_new:N \g_TUDa_geometry_bool
\bool_new:N \g_TUDa_custommargins_bool

\keys_define:nn {TUDa/pub} {
	color .meta:n = {accentcolor=#1},
	accentcolor .code:n = {\PassOptionsToPackage{accentcolor=#1}{tudacolors}},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccentcolor=#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{identbarcolor=#1}{tudacolors}},
	color .initial:n = black!50,
	custommargins .choice:,
	custommargins / true .code:n ={
		\bool_gset_true:N \g_TUDa_custommargins_bool
		\bool_gset_false:N \g_TUDa_geometry_bool
	},
	custommargins / false .code:n ={
		\bool_gset_false:N \g_TUDa_custommargins_bool
		\bool_gset_true:N \g_TUDa_geometry_bool
	},
	custommargins / geometry .code:n = {
		\bool_gset_true:N \g_TUDa_custommargins_bool
		\bool_gset_true:N \g_TUDa_geometry_bool
	},
	custommargins .initial:n = false,
	custommargins .default:n = true,
	fontsize .code:n = \prop_gput:Nnn \g_TUDa_clsopts_prop {fontsize} {#1},
	fontsize .initial:n = {10pt},
	unknown .code:n = {\prop_gput:NVn \g_TUDa_unknown_clsopts_prop \l_keys_key_tl {#1}},
	BCOR .code:n = \PassOptionsToPackage{bindingoffset=#1}{geometry},
	bindingoffset .meta:n = {BCOR=#1},
	captions .code:n = {\prop_gput:Nnx \g_TUDa_clsopts_prop {captions} {	
		\use:n {\prop_item:Nn \g_TUDa_clsopts_prop {captions}}, #1}
	},
	titlepage .code:n = {\msg_warning:nnn {TUDaPub} {titlepage-option-disabled} {#1}},
	paper .choices:nn = {a0,a1,a2,a3,a4,a5,a6}{
		\int_gset_eq:NN \g_TUDa_paper_int  \l_keys_choice_int
		\PassOptionsToPackage{paper=\l_keys_choice_tl}{tudarules}
		\PassOptionsToPackage{paper=\l_keys_choice_tl}{typearea}
		\PassOptionsToPackage{\l_keys_choice_tl paper}{geometry}
	},
	paper .initial:n = a4,
	logofile .tl_gset:N = \g_TUDa_logofile_tl,
	logofile .initial:n = tuda_logo,
}

\ProcessKeysOptions{TUDa/pub}

\prop_map_inline:Nn \g_TUDa_clsopts_prop {
	\tl_if_empty:nTF {#2} 
		{\PassOptionsToClass  {#1} {scrartcl}}
		{
		\clist_map_inline:nn {#2} {\PassOptionsToClass  {#1=##1} {scrartcl}}
		}
}


%Load tudasize clo file if available
\file_if_exist:nT {tudasize\prop_item:Nn \g_TUDa_clsopts_prop {fontsize}.clo}
	{\providecommand*{\@fontsizefilebase}{tudasize}}

\LoadClass{scrartcl}

\prop_map_inline:Nn \g_TUDa_unknown_clsopts_prop {
	\cs_if_exist:cT {KV@KOMA.scrartcl.cls@#1} {
	\tl_if_empty:nTF {#2} 
		{\KOMAoptions{#1} }
		{\clist_map_inline:nn {#2} {\KOMAoptions{#1=##1}}}
	}
}
\renewcommand*\sectionlinesformat[4]{%
\parbox{\linewidth}{
	\rule[5\g_TUDa_titlerule_dim]{\linewidth}{\g_TUDa_titlerule_dim}\par\nointerlineskip
	\@hangfrom{%
		\hskip #2#3}{#4\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
		\skip_vertical:n {\TUDa_titlerule_sep: -\dp\strutbox}
	\smash{\rule{\linewidth}{\g_TUDa_titlerule_dim}}
}}
	

\usepackage{tudarules}
\usepackage{tudafonts}

\dim_new:N \g_TUDa_innerMargin_dim
\dim_new:N \g_TUDa_outerMargin_dim
\dim_new:N \g_TUDa_bottomMargin_dim
\dim_new:N \g_TUDa_topMargin_dim


	%a3,a4
	\int_compare:nTF {4<=\g_TUDa_paper_int<=5}
	{
		\dim_gset:Nn \g_TUDa_bottomMargin_dim {20mm}
		\dim_gset:Nn \g_TUDa_outerMargin_dim {15mm}
		\dim_gset_eq:NN \g_TUDa_innerMargin_dim \g_TUDa_outerMargin_dim
		\dim_gset_eq:NN \g_TUDa_topMargin_dim \g_TUDa_outerMargin_dim
	}{
	%a0, a1, a2
		\int_compare:nT {1<=\g_TUDa_paper_int<=3}
		{
			\dim_gset:Nn \g_TUDa_bottomMargin_dim {35mm}
			\dim_gset:Nn \g_TUDa_outerMargin_dim {30mm}
			\dim_gset_eq:NN \g_TUDa_innerMargin_dim \g_TUDa_outerMargin_dim
			\dim_gset_eq:NN \g_TUDa_topMargin_dim \g_TUDa_outerMargin_dim
		}
		%a5
		\int_compare:nT {\g_TUDa_paper_int<=6}
		{
			\dim_gset:Nn \g_TUDa_bottomMargin_dim {16mm}
			\dim_gset:Nn \g_TUDa_outerMargin_dim {12mm}
			\dim_gset_eq:NN \g_TUDa_innerMargin_dim \g_TUDa_outerMargin_dim
			\dim_gset_eq:NN \g_TUDa_topMargin_dim \g_TUDa_outerMargin_dim
		}
		%a6
		\int_compare:nT {\g_TUDa_paper_int<=7}
		{
			\dim_gset:Nn \g_TUDa_bottomMargin_dim {15mm}
			\dim_gset:Nn \g_TUDa_outerMargin_dim {10mm}
			\dim_gset_eq:NN	 \g_TUDa_innerMargin_dim \g_TUDa_outerMargin_dim
			\dim_gset_eq:NN \g_TUDa_topMargin_dim \g_TUDa_outerMargin_dim
		}
	}

%TODO pubched
%%punched
%\dim_gset:Nn \g_TUDa_outerMargin_dim {15mm}
%\dim_gset:Nn \g_TUDa_innerMargin_dim {20mm}
%\if@twoside
%\else
%\dim_gset_eq:NN \g_TUDa_innerMargin_dim \g_TUDa_outerMargin_dim
%\fi

\dim_new:N \g_TUDa_columnSep_dim
\dim_gset:Nn \g_TUDa_columnSep_dim {10pt}

%coverpage
\edef\coverpageleftmargin{\dim_eval:n {\g_TUDa_outerMargin_dim}}
\renewcommand*{\coverpagetopmargin}{\g_TUDa_outerMargin_dim}
\edef\coverpagerightmargin{\dim_eval:n {\g_TUDa_outerMargin_dim}}
\renewcommand*{\coverpagebottommargin}{\g_TUDa_outerMargin_dim}



\dim_new:N \g_TUDa_headheight_dim
\dim_new:N \g_TUDa_headwidth_dim


\dim_gset:Nn \g_TUDa_headheight_dim {1.25\baselineskip +\c_TUDa_largerule_dim +\c_TUDa_rulesep_dim +\c_TUDa_smallrule_dim}

%%%%%Anfang Randeinstellungen Geometry

%Has to be loaded here due to headwidth options
\usepackage[draft=false]{scrlayer-scrpage}

\bool_if:NTF  \g_TUDa_geometry_bool {
	\RequirePackage[top=\g_TUDa_topMargin_dim, inner=\g_TUDa_innerMargin_dim, outer=\dim_eval:n {\g_TUDa_outerMargin_dim}, bottom=\g_TUDa_bottomMargin_dim, columnsep= \g_TUDa_columnSep_dim, includehead, includefoot, headheight=\g_TUDa_headheight_dim
	]{geometry}
}{
	\KOMAoptions{headinclude, footinclude, headwidth=text,footwidth=text}
}


%%%%%%%%
%Ende Randeinstellungen klassisch




\newcommand*{\institution}[1]{
	\def\TUDa@institution{#1}
}

\gdef\TUDa@datename{Datum}
\gdef\TUDa@dateseparator{:~}




\setkomafont{disposition}{\sffamily\bfseries}



\dim_new:N \g_TUDa_titlerule_dim
\dim_gset:Nn \g_TUDa_titlerule_dim {.5\c_TUDa_smallrule_dim}

\cs_new:Nn \TUDa_titlerule_sep: {\the\dp\strutbox}

\usepackage{tudacolors}

%TODO: mode -> light head. 

\setkomafont{pageheadfoot}{\sffamily\small}
\setkomafont{pagenumber}{}


\KOMAoptions{footsepline=.5\c_TUDa_smallrule_dim}
\KOMAoptions{headsepline=.5\c_TUDa_smallrule_dim}


\newpairofpagestyles[scrheadings]{TUDa.headings}{
	\KOMAoptions{headsepline, headlines=1.25, footlines=1.25}
	\setkomafont{pagehead}{}
	\chead{}
	\ohead{\headmark}
}

\newpairofpagestyles{TUDa}{
	\KOMAoptions{plainfootsepline}
	
		\KOMAoptions {
			headwidth=text,
			footwidth=text
			}
\setkomafont{pagehead}{\Large\bfseries}
\box_if_exist:NF \TUDa@headline_box {
	\TUDa@makeheadrule[color=identbarcolor, width=\sls@headwidth]{TUDa@headline}
}
	\if@twocolumn
	\edef\sls@evenheadshift{\dim_eval:n {-\marginparwidth-\marginparsep\relax}}
	\let\sls@oddheadshift\sls@evenheadshift
	\let\sls@evenfootshift\sls@evenheadshift
	\let\sls@oddfootshift\sls@evenheadshift
	\fi
	\ModifyLayer[
		background,
		mode=picture,
		contents={
			\dim_compare:nF {\box_wd:N \TUDa@headline_box=\layerwidth} {
				\TUDa@makeheadrule*[color=identbarcolor, width=\layerwidth]{TUDa@headline}
			}
			\TUDa@headline
		}
	]{TUDa.head.above.line}	
	\ModifyLayer[
		background,
		mode=picture,
		contents={\smash{\TUDa@headline}}
	]{plain.TUDa.head.above.line}
%	\bool_if:NT \g_TUDa_headline_bool {
		\clist_map_variable:nNn {oneside, even, odd} \l_tmpa_tl {
			\ModifyLayer[pretocontents={\rule[-6pt]{0pt}{\layerheight}}]{TUDa.head.\l_tmpa_tl}
		}
		\lehead{\headmark}
		\lohead{\headmark}
%	}
	\ofoot[\pagemark]{\pagemark}
}

\cs_new:Nn \TUDa_sls@leftmargin: {%
	\dimexpr
	\if@twoside
	\ifodd\value{page}
	\oddsidemargin
	\else
	\evensidemargin
	\fi
	\else
	\oddsidemargin
	\fi
	\bool_if:NT \g_TUDa_twocolumn_bool {
	-\marginparwidth-\marginparsep
	}
	+1in\relax
}

\pagestyle{TUDa}

%Titelseite
\tl_new:N  \g_TUDa_titleimage_code_tl
\tl_gset_eq:NN  \g_TUDa_titleimage_code_tl \c_empty_tl
\newcommand{\titleimage}[1]{\tl_gset:Nn \g_TUDa_titleimage_code_tl {#1}}

\box_new:N  \g_TUDa_title_box 
\skip_new:N \g_TUDa_title_fill_skip

\renewcommand{\titlepagestyle}{title.TUDa}


\seq_new:N \g_TUDa_author_seq

\renewcommand*\author[1]{
	\seq_gset_split:Nnn \g_TUDa_author_seq {\and} {#1}
}

\msg_new:nnn {TUDaPub} {unknown-language} {
	You~selected~an~unknown~language~#1.\\
	The~Variable~#2~does~not~have~a~predefined~value.\\
	Ensure~to~redefine~#2~to~match~your~language.\\
	Otherwise~the~ngerman~vaue~#3~will~be~used.
}

\cs_new:Nn \TUDa_define_captionFallback:Nn {
	\providecommand*#1{
	\msg_warning:nnxxx {TUDaPub} {unknown-language}
		{\languagename} {\exp_not:N #1} {#2}
	\def#1{#2}
	}
}

\renewcommand*{\@author}{
	\seq_use:Nnnn \g_TUDa_author_seq {~\authorandname{}~} {,~} {~\&~}
}

\msg_new:nnn {TUDaPub} {infobox-too-high} {
	The~height~of~your~Infobox~exeeds~the~space~reserved~in~the~title~block.\\
	You~should~probably~switch~to~logo=bottom~or~reduce~the~number/size~of~InfoBoxes.
}

\newcommand*{\TUDa@title@footnote}[2][1]{
\textsuperscript{\@fnsymbol{#1}}#2
}

\renewcommand*{\@maketitle}{%
	\global\@topnum=\z@
	\setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
	\raisebox{\dim_eval:n {-\height+\c_TUDa_largerule_dim+\headsep+\topskip}}[0pt][0pt]{\textcolor{black!50}{\rule{\linewidth}{.5\c_TUDa_logoheight_dim}}}
	\par
	\nointerlineskip
	\begingroup
	\setlength{\fboxsep}{\z@}
	\raisebox{\dimexpr-\height+\ht\strutbox}[0pt]{\colorbox{black!50}{\parbox[t]{\linewidth}{
	\raisebox{-\height}{%
		\begin{minipage}[t]{.75\linewidth}
		\begin{addmargin}{3mm}
			\raggedright
			\tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
			\leavevmode\usekomafont{title}%
			{\usekomafont{title}{\huge \@title \par}}%
			\vskip .5em
			{\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
			\vskip .5em
			{\ifx\@author\@empty\else\usekomafont{author}\@author\par\fi}%
			\vskip 1em
		\end{addmargin}
		\end{minipage}%
		}\hfill\raisebox{-\height}{\makebox[2.2\c_TUDa_logoheight_dim][l]{\includegraphics[height=\c_TUDa_logoheight_dim]{\g_TUDa_logofile_tl}}}
	\par\vspace*{.5\c_TUDa_logoheight_dim}
	}}%COLOR!
	}
	\par
	\nointerlineskip
	\rule{\linewidth}{\g_TUDa_titlerule_dim}
	\exp_args:Nf \tl_if_empty:nF {\@sheetnumber\@date\@term}{
		\par\nointerlineskip
		\colorbox{black!50}{
		\parbox{\linewidth}{
		\begin{minipage}{\linewidth}
		\begin{addmargin}{3mm}
			\null\par
			\def\TUDa@nextsep{}
			\tl_if_empty:NF \@term {\@term\def\TUDa@nextsep{\\}}
			\tl_if_empty:NF \@date {\TUDa@nextsep\@date\def\TUDa@nextsep{\\}}
			\tl_if_empty:NF \@sheetnumber {\TUDa@nextsep\sheetname\sheetsep\@sheetnumber}
		\end{addmargin}
	\end{minipage}
		\vspace*{\dp\strutbox}
		}}\par\nointerlineskip
		\rule{\linewidth}{\g_TUDa_titlerule_dim}
	}
	\par
	\endgroup
	\vskip 2em
}%

\setkomafont{subtitle}{\bfseries}
\setkomafont{author}{}
\setkomafont{date}{}
\newkomafont{sheetnumber}{\usekomafont{date}}

\newkomafont{term}{\usekomafont{date}}

\date{}
\newcommand*{\sheetnumber}[1]{\gdef\@sheetnumber{#1}}
\sheetnumber{}
\newcommand*{\term}[1]{\gdef\@term{#1}}
\term{}


%TODO finish font setup

\int_case:nn {\g_TUDa_paper_int}
{
	%paper=a0
	{1} {
		\cs_set:Nn \TUDa_title_fontsize: {{125pt}{165pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{42pt}{55pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{28pt}{35pt}}
	}
	%paper=a1
	{2} {
		\cs_set:Nn \TUDa_title_fontsize: {{86pt}{120pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{35pt}{42pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{22pt}{26pt}}
	}
	%paper=a2
	{3} {
		\cs_set:Nn \TUDa_title_fontsize: {{65pt}{82pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{22pt}{28pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{14pt}{20pt}}
	}
	%paper=a3
	{4} {
		\cs_set:Nn \TUDa_title_fontsize: {{47pt}{61pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{16pt}{20pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{12pt}{16pt}}
	}
	%paper=a4
	{5} {
		\cs_set:Nn \TUDa_title_fontsize: {{36pt}{47pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{12pt}{14pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{10pt}{11.5pt}}
	}
	%paper=a5
	{6} {
		\cs_set:Nn \TUDa_title_fontsize: {{22pt}{28pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{10pt}{11.5pt}}
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{10pt}{11.5pt}}
	}
	%paper=a6
	{7} {
		\cs_set:Nn \TUDa_title_fontsize: {{14pt}{16pt}}
		\cs_set:Nn \TUDa_titleinfo_fontsize: {{9pt}{10pt}}	
		\cs_set:Nn \TUDa_titlethanks_fontsize: {{9pt}{10pt}}
	}
}



\seq_new:N \g_TUDa_title_info_seq 
\box_new:N \g_TUDa_title_info_box

\colorlet{TUDa@InfoBoxColor}{white}

\cs_new:Nn \TUDa_make_title_info_box:n {
	\setlength{\fboxsep}{1.5mm}%
	\colorbox{TUDa@InfoBoxColor}{
	\makebox[\dim_eval:n {2.2\c_TUDa_logoheight_dim-\fboxsep}][r]{
		\parbox{2\c_TUDa_logoheight_dim}{
		\expandafter\fontsize\TUDa_titlethanks_fontsize:\selectfont\usekomafont{institution}%
		\raggedright%
	#1
	}}}
}

\cs_new:Nn \TUDa_make_title_logo_box:n {
	\setlength{\fboxsep}{\z@}%
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

%\DeclareNewLayer[textarea,background,mode=picture,
%	contents={
%		\tl_if_empty:NTF \g_TUDa_titleimage_code_tl 
%		{\bool_if:NT \g_TUDa_colorback_bool {\putLL{\color{identbarcolor}\rule{\layerwidth}{\layerheight}}}}
%		{\putUL{\color{identbarcolor}\raisebox{-\height}{\parbox[t]{\textwidth}{
%					\let\width\layerwidth
%					\let\height\layerheight
%					\g_TUDa_titleimage_code_tl
%					}}}}
%		\bool_if:NF \g_TUDa_logo@inhead_bool {
%			\put(\dim_to_decimal_in_unit:nn {\layerwidth-2.2\c_TUDa_logoheight_dim
%			} {\unitlength},
%			\dim_to_decimal_in_unit:nn {\layerheight-\box_ht:N \g_TUDa_title_info_box - .5\c_TUDa_logoheight_dim} {\unitlength}){	
%				\rlap{\box_use:N \g_TUDa_title_info_box}
%			}
%		}
%		\put(0,0){\rule{\linewidth}{\g_TUDa_titlerule_dim}}
%	}              
%]{title.TUDa.image}

\DeclareNewLayer[textarea,background,mode=picture,
contents={\color{identbarcolor}\rule{\layerwidth}{\layerheight}}
]{title.TUDa.background}

\TUDa@makeheadrule[color=identbarcolor, width=\textwidth]{TUDa@title_headline}

\cs_new:Nn \TUDa_Setup_Title_box: {
	\hbox_gset:Nn \g_TUDa_title_info_box
	{
		\parbox{\dimexpr2.5\c_TUDa_logoheight_dim}{
		\seq_use:Nn \g_TUDa_title_info_seq  {\par\nointerlineskip\vspace{5mm}}
		}
	}
}

\DeclareNewPageStyleByLayers{title.TUDa}{TUDa.head.above.line}%,TUDa.title.above.rule}%,title.TUDa.image}

%Logos
\RequirePackage{graphicx}
	
%%hyperref
\usepackage{hyperref}
\hypersetup{hidelinks, unicode}

\providecaptionname{ngerman, german}{\sheetname}{Blatt}
\providecaptionname{english, american, british}{\sheetname}{Sheet}
\newcommand*{\sheetsep}{:~}


\endinput
%End of class tudapub.cls
