\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass{tudaexercise}
	{\filedate}{\fileversion}{Exercise sheets and exams using TU Darmstadt's Corporate Desing (TUDa-CI)}

\RequirePackage{l3keys2e}

\tl_new:N \g_TUDa_thesis_options_tl

\prop_new:N \g_TUDa_clsopts_prop
\prop_new:N \g_TUDa_unknown_clsopts_prop
\prop_gput:Nnn \g_TUDa_clsopts_prop {captions} {nooneline}
\prop_gput:Nnn \g_TUDa_clsopts_prop {parskip} {half-}

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
\bool_new:N \l_TUDa_ex_solution_bool

\RequirePackage{environ}

\def\solution{\TUDa_ex_solutionheader:}
\def\endsolution{}

\cs_new:Nn \TUDa_setup_solution: {
	\bool_if:NTF \l_TUDa_ex_solution_bool {
		\def\solution{\TUDa_ex_solutionheader:}
		\def\endsolution{}
	}{
		\RenewEnviron{solution}{
			\if_false:
			\BODY
			\fi:
		}
	}
}


\bool_new:N \l_TUDa_ex_subtask_fallback_bool
\keys_define:nn {TUDa/subtask} {
  credit .tl_set:N = \l_TUDa_ex_credit_tl,
  credit .initial:n =,
  points .int_set:N = \l_TUDa_ex_points_int,
  points .initial:n = 0,
  title .tl_set:N = \l_TUDa_ex_title_tl,
  title .initial:n =,
  unknown .code:n = \bool_set_true:N \l_TUDa_ex_subtask_fallback_bool \tl_clear:N \l_TUDa_ex_credit_tl \int_zero:N \l_TUDa_ex_points_int,
}

\keys_define:nn {TUDa/exercise} {
	solution .code:n = {
		\bool_set_eq:Nc \l_TUDa_ex_solution_bool {c_#1_bool}
		\TUDa_setup_solution:
	},
	solution .initial:n = false,
	solution .default:n = true,
	compat .bool_gset:N = \g_TUDa_ex_compatibility_bool,
	compatilibity .meta:n = {compat=#1},
	compatibility .default:n = true,
	compat .initial:n = false,
	credit .tl_set:N = \l_TUDa_ex_credit_tl,
	credit .initial:n =,
	points .int_set:N = \l_TUDa_ex_points_int,
	points .initial:n = 0,
}

\keys_define:nn {TUDa/exercise/headline} {
  headline .code:n = {
    \if@twoside
    \keys_set:nn  {TUDa/exercise/headline} {odd=#1,even=#1}
    \else
    \keys_set:nn {TUDa/exercise/headline} {oneside=#1}
    \fi
  },
}

\clist_map_inline:nn {odd, even, oneside} {
  \tl_new:c {g_TUDa_ex_headline_#1_tl}
  \keys_define:nn {TUDa/exercise/headline} {
    #1 .choice:,
    #1 / title-name-id .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {
      \g_TUDa_shorttitle_tl\par
      \StudentName\StudentID},
    #1 / title-name .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {
      \g_TUDa_shorttitle_tl\par
      \smallskip
      \StudentName},
    #1 / title .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {\g_TUDa_shorttitle_tl},
    #1 / name-id .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {\StudentName\StudentID},
    #1 / name .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {\StudentName},
    #1 / unknown .code:n = \tl_gset:cn {g_TUDa_ex_headline_#1_tl} {##1}
  }
}

\bool_new:N \g_TUDa_smalltitle_bool

\keys_define:nn {TUDa/pub} {
	color .code:n = {\PassOptionsToPackage{color=#1}{tudacolors}},
	accentcolor .code:n = {\PassOptionsToPackage{accentcolor=#1}{tudacolors}},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccentcolor=#1}{tudacolors}},
	textonaccentcolor .code:n = {\PassOptionsToPackage{textaccentcolor=#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{identbarcolor=#1}{tudacolors}},
	color .initial:n = 0b,
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
	solution .meta:nn = {TUDa/exercise}{solution=#1},
	compat .meta:nn = {TUDa/exercise}{compat=#1},
	compatibility .meta:nn = {TUDa/exercise}{compat=#1},
	compatibility .default:n = true,
	headontitle .bool_gset:N = \g_TUDa_headontitle_bool,
	headontitle .initial:n = false,
	headontitle .default:n =true,
	colorback .bool_gset:N  = \g_TUDa_colorback_bool,
	colorback .default:n = true,
	colorback .initial:n  = true,
	title .choice:,
	title / default .meta:n = {title=large},
	title / large .code:n = \bool_gset_false:N \g_TUDa_smalltitle_bool,
	title / small  .code:n = \bool_gset_true:N \g_TUDa_smalltitle_bool,
	title .initial:n = default,
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

\RequirePackage{tudarules}

%Has to be loaded here due to headwidth options
\RequirePackage[draft=false]{scrlayer-scrpage}
\KOMAoptions {twoside = false}

\prop_map_inline:Nn \g_TUDa_unknown_clsopts_prop {
	\cs_if_exist:cT {KV@KOMA.scrartcl.cls@#1} {
	\tl_if_empty:nTF {#2}
		{\KOMAoptions{#1}}
		{\KOMAoption{#1}{#2}
	}
}
}

\renewcommand*\sectionlinesformat[4]{%
\parbox{\linewidth}{
	\rule[5\g_TUDa_titlerule_dim]{\linewidth}{\g_TUDa_titlerule_dim}\par\nointerlineskip
	\@hangfrom{%
		\hskip #2#3}{
		\tl_if_eq:nnT {#1} {task} {
			\exp_args:No \tl_if_empty:nF {#4}
				{:~}
		}
		#4
		\tl_if_in:nnT {#1} {task} {
			\tl_if_empty:NTF \l_TUDa_ex_credit_tl
				{\pointformat{\l_TUDa_ex_points_int}}
				{\creditformat{\l_TUDa_ex_credit_tl}}
		}
		\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
		\skip_vertical:n {\TUDa_titlerule_sep: -\dp\strutbox}
	\smash{\rule{\linewidth}{\g_TUDa_titlerule_dim}}
}}


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

\dim_new:N \g_TUDa_columnSep_dim
\dim_gset:Nn \g_TUDa_columnSep_dim {10pt}

\dim_new:N \g_TUDa_headheight_dim
\dim_new:N \g_TUDa_headwidth_dim

\dim_gset:Nn \g_TUDa_headheight_dim {\c_TUDa_largerule_dim +\c_TUDa_rulesep_dim +\c_TUDa_smallrule_dim}
%%%%%Anfang Randeinstellungen Geometry


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

\RequirePackage{tudacolors}
\RequirePackage{environ}

%TODO: mode -> light head.

\setkomafont{pageheadfoot}{\sffamily\small}
\setkomafont{pagenumber}{}
\addtokomafont{captionlabel}{\sffamily}
\addtokomafont{caption}{\sffamily}

\box_new:N \g_TUDa_ex_headline_odd_box
\box_new:N \g_TUDa_ex_headline_even_box
\box_new:N \g_TUDa_ex_headline_oneside_box

\cs_new:Nn \TUDa_preamble_ConfigureHeadline:n {
  \tl_if_empty:nF {#1} {\keys_set:nn {TUDa/exercise/headline} {#1}}
}

\cs_new:Nn \TUDa_ConfigureHeadline:n {
  \TUDa_preamble_ConfigureHeadline:n {#1}
  \TUDa_update_headline_boxes:
  \TUDa_ex_adjust_headheight:
}

\let\ConfigureHeadline\TUDa_preamble_ConfigureHeadline:n



\bool_if:NT \g_TUDa_ex_compatibility_bool {

\cs_new:Npn \TUDa_ex_env_to_tl_aux:w #1 \q_stop { \tl_gset:Nn     \g_TUDa_ex_headline_oneside_tl {#1} }

\NewEnviron{examheader}{
  \tl_gset:No \g_TUDa_ex_headline_oneside_tl {\BODY}
  \tl_gset:No \g_TUDa_ex_headline_odd_tl {\BODY}
  \tl_gset:No \g_TUDa_ex_headline_even_tl {\BODY}
  \TUDa_ConfigureHeadline:n {}
}

  \newcommand*{\examheaderdefault}{\par\StudentName\StudentID}
}


\cs_new:Nn \TUDa_update_headline_boxes: {
  \clist_map_inline:nn {even, odd, oneside}
  {
    \tl_if_empty:cF {g_TUDa_ex_headline_##1_tl} {
      \vbox_gset:cn {g_TUDa_ex_headline_##1_box} {
          \begin{minipage}[b]{\textwidth}
          \usekomafont{pagehead}
         \raggedright
          \leavevmode\rule{\z@}{\dimexpr\ht\strutbox+\c_TUDa_rulesep_dim}
          \ignorespaces
          \use:c {g_TUDa_ex_headline_##1_tl}\ignorespaces\strut
          \par\vspace{\z@}
        \end{minipage}
      }
    }
  }
}


\cs_new:Nn \TUDa_ex_adjust_headheight: {
	\if@twoside
	\dim_set:Nn \l_tmpa_dim {
		\dim_max:nn
			{\box_ht:N \g_TUDa_ex_headline_odd_box+\box_dp:N \g_TUDa_ex_headline_odd_box}
			{\box_ht:N \g_TUDa_ex_headline_even_box+\box_dp:N \g_TUDa_ex_headline_even_box}
	}
	\else
	\dim_set:Nn \l_tmpa_dim {
		\box_ht:N \g_TUDa_ex_headline_oneside_box
		+ \box_dp:N \g_TUDa_ex_headline_oneside_box
	}
	\fi
	\dim_compare:nT {\l_tmpa_dim > \z@}
	{
		\dim_add:Nn \l_tmpa_dim {\box_dp:N \TUDa@headline_box +\c_TUDa_rulesep_dim}
		\KOMAoptions{headinclude, headheight=\l_tmpa_dim,headsepline = .5\c_TUDa_smallrule_dim}
		\if@twoside
		\cehead{\box_use:c {g_TUDa_ex_headline_even_box}}
		\cohead{\box_use:c {g_TUDa_ex_headline_odd_box}}
		\else
		\chead{\box_use:c {g_TUDa_ex_headline_oneside_box}}
		\fi
		\global\setlength{\headheight}{\l_tmpa_dim}
	}
}

\newpairofpagestyles{TUDa.ex}{
	\KOMAoptions{plainfootsepline}
		\KOMAoptions {
			headwidth=text,
			footwidth=text
			}
	\setkomafont{pagehead}{}
\box_if_exist:NF \TUDa@headline_box {
	\TUDa@makeheadrule[color=identbarcolor, width=\sls@headwidth]{TUDa@headline}
}
\ModifyLayer[
	background,
	height=\box_dp:N \TUDa@headline_box,
	align=tl,
	voffset=\g_TUDa_topMargin_dim,
	contents=\raisebox{\depth}{\box_use:N \TUDa@headline_box},
	]{plain.TUDa.ex.head.above.line}
	\ModifyLayer[
	background,
	height=\box_dp:N \TUDa@headline_box,
	align=tl,
	voffset=\g_TUDa_topMargin_dim,
	contents=\raisebox{\depth}{\box_use:N \TUDa@headline_box},
	]{TUDa.ex.head.above.line}
	\ofoot[\pagemark]{\pagemark}
}

\pagestyle{TUDa.ex}

%Titelseite
\tl_new:N  \g_TUDa_titleimage_code_tl
\tl_gset_eq:NN  \g_TUDa_titleimage_code_tl \c_empty_tl
\newcommand{\titleimage}[1]{\tl_gset:Nn \g_TUDa_titleimage_code_tl {#1}}

\box_new:N  \g_TUDa_title_box
\skip_new:N \g_TUDa_title_fill_skip

\renewcommand{\titlepagestyle}{plain.TUDa.ex}


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

\tl_new:N \g_TUDa_shorttitle_tl

\RenewDocumentCommand{\title}{om}{
  \IfNoValueTF{#1}{
    \tl_gset:Nn  \g_TUDa_shorttitle_tl {#2}
  }{
    \tl_gset:Nn \g_TUDa_shorttitle_tl {#1}
  }
  \def\@title{#2}
}

% Define \subsubtitle for compatibility
  \newcommand*{\subsubtitle}[1]{
    \def\@subsubtitle{#1}
  }
  \subsubtitle{}


\newcommand*{\TUDa@title@footnote}[2][1]{
\textsuperscript{\@fnsymbol{#1}}#2
}

\renewcommand*{\titlepagestyle}{plain.TUDa.ex}

\renewcommand*{\@maketitle}{%
  \global\@topnum=\z@
  \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
  \vspace*{-\dim_eval:n {
      \headheight
	-\c_TUDa_largerule_dim -\c_TUDa_rulesep_dim
      +\headsep
      +\ht\strutbox
      +\p@
    }}
  \par
  \nointerlineskip
  \raisebox{\dim_eval:n {
      -.5\c_TUDa_logoheight_dim
    }}[0pt][\dim_eval:n {\bool_if:NTF \g_TUDa_smalltitle_bool {.25} {.5}\c_TUDa_logoheight_dim}]{
    \bool_if:NT \g_TUDa_colorback_bool {\color{accentcolor}\rule{\linewidth}{.5\c_TUDa_logoheight_dim}}
 }
  \par\nointerlineskip
  \begingroup
  \setlength{\fboxsep}{\z@}
  \bool_if:NT \g_TUDa_colorback_bool {\colorbox{accentcolor}}{\parbox[t]{\linewidth}{
      \raisebox{-\height}{%
        \begin{minipage}[t]{\dimexpr\linewidth-2.2\c_TUDa_logoheight_dim-1ex}
          \bool_if:NT \g_TUDa_colorback_bool  {\begin{addmargin}{3mm}}
            \raggedright
            \bool_if:NT \g_TUDa_colorback_bool {\color{textonaccentcolor}}
            \tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
            \leavevmode\usekomafont{title}%
            {\usekomafont{title}\bool_if:NTF \g_TUDa_smalltitle_bool {\LARGE} {\huge} {\@title\par}}%
            \vskip 1em
            \bool_if:NF \g_TUDa_ex_compatibility_bool
            {
              {\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
              \gdef\@subtitle{}
              \vskip .5em
            }
            {\ifx\@author\@empty\else\usekomafont{author}\@author\par\fi}%
            \vskip .5em
          \bool_if:NTF \g_TUDa_colorback_bool {\end{addmargin}} {\par}
        \end{minipage}}
		\tl_if_empty:NF \g_TUDa_logofile_tl {
		\hfill\raisebox{\dim_eval:n {
				\bool_if:NTF \g_TUDa_colorback_bool
				{-\height}
				{-.9\c_TUDa_logoheight_dim}
			}}
			[0pt]
			[\dim_eval:n {
			\bool_if:NTF \g_TUDa_smalltitle_bool
				{\bool_if:NTF \g_TUDa_colorback_bool {1.15}{1}}
				{\bool_if:NTF \g_TUDa_colorback_bool {1.5}{1.3}
			}\c_TUDa_logoheight_dim}]
		{\makebox[2.2\c_TUDa_logoheight_dim][l]{\includegraphics[height=\c_TUDa_logoheight_dim]{\g_TUDa_logofile_tl}}}
		}
      \par\medskip
    }}
  \par
  \nointerlineskip
  \rule{\linewidth}{\g_TUDa_titlerule_dim}
    % subtitle fields if not compat
  \exp_args:Nf \tl_if_empty:nF {\g_TUDa_ex_sheetnum_tl\@date\g_TUDa_ex_term_tl\use:c {@subsubtitle}\@subtitle}{
    \par\nointerlineskip
    \bool_if:NT \g_TUDa_colorback_bool {\colorbox{accentcolor}}{
      \parbox{\linewidth}{
        \begin{minipage}{\linewidth}
			\bool_if:NT \g_TUDa_colorback_bool {
				\color{textonaccentcolor}
				\begin{addmargin}{3mm}
			}
            \null\par
            \def\TUDa@nextsep{}
            \clist_map_inline:nn {@subtitle, @subsubtitle, g_TUDa_ex_term_tl, @date} {
              \tl_if_empty:cF {##1} {\TUDa@nextsep\use:c {##1}\def\TUDa@nextsep{\\}}
            }
            % \tl_if_empty:NF \@subtitle {}
            % \tl_if_empty:NF \g_TUDa_ex_term_tl {\TUDa@nextsep\g_TUDa_ex_term_tl\def\TUDa@nextsep{\\}}
            % \tl_if_empty:NF \@date {\TUDa@nextsep\@date\def\TUDa@nextsep{\\}}
            \tl_if_empty:NF \g_TUDa_ex_sheetnum_tl {\TUDa@nextsep\sheetname\sheetsep\g_TUDa_ex_sheetnum_tl}
          \bool_if:NT \g_TUDa_colorback_bool {\end{addmargin}}
        \end{minipage}
        \vspace*{\dp\strutbox}
      }}\par\nointerlineskip
    \rule{\linewidth}{\g_TUDa_titlerule_dim}
  }
  \par
  \bool_if:NT  \g_TUDa_headontitle_bool {
    \if@twoside
    \box_use:N \g_TUDa_ex_headline_odd_box
    \else
    \box_use:N \g_TUDa_ex_headline_oneside_box
    \fi
    \par
    \rule{\linewidth}{\g_TUDa_titlerule_dim}
    \par
  }
  \endgroup
  \vskip 2em
  \ConfigureHeadline{}
}%

\setkomafont{subtitle}{\bfseries}
\setkomafont{author}{}
\setkomafont{date}{}
\newkomafont{sheetnumber}{\usekomafont{date}}

\newkomafont{term}{\usekomafont{date}}

\date{}
\tl_new:N \g_TUDa_ex_sheetnum_tl
\newcommand*{\sheetnumber}[1]{\tl_gset:Nn \g_TUDa_ex_sheetnum_tl {#1}}
\sheetnumber{}
\tl_new:N \g_TUDa_ex_term_tl
\newcommand*{\term}[1]{\tl_gset:Nn \g_TUDa_ex_term_tl {#1}}
\term{}

\TUDa@makeheadrule[color=identbarcolor, width=\textwidth]{TUDa@title_headline}

%Logos
\RequirePackage{graphicx}

%%hyperref
\usepackage{hyperref}
\hypersetup{hidelinks, unicode}

\providecaptionname{ngerman, german}{\sheetname}{Übungsblatt}
\providecaptionname{english, american, british}{\sheetname}{Sheet}
\newcommand*{\sheetsep}{~}

\providecaptionname{ngerman, german}{\taskname}{Aufgabe}
\providecaptionname{english, american, british}{\taskname}{Task}
\newcommand*{\tasksep}{~}%TODO

\providecaptionname{ngerman, german}{\solutionname}{Lösungsvorschlag}
\providecaptionname{english, american, british}{\solutionname}{Solution}
\newcommand*{\solutionsep}{:~}

\providecaptionname{ngerman, german}{\StudentNamename}{Nachname,~Vorname}
\providecaptionname{english, american, british}{\StudentNamename}{Last Name,~ First Name}
\newcommand*{\StudentNamesep}{:~}

\providecommand{\StudentIDname}{Matrikelnummer}
\providecaptionname{ngerman, german}{\StudentIDname}{Matrikelnummer}
\providecaptionname{english, american, british}{\StudentIDname}{Enrollment ID}
\newcommand*{\StudentIDsep}{:~}

\providecommand{\creditformat}[1]{\space(#1)}
\newcommand*{\pointformat}[1]{
	\int_case:nnF {#1}
		{
		{0} {}
		{1} {\creditformat{\int_to_arabic:n {#1}\space\PointName}}
		}
		{\creditformat{\int_to_arabic:n {#1}\space\PointsName}}
	}
\providecaptionname{ngerman, german}{\PointName}{Punkt}
\providecaptionname{english, american, british}{\PointName}{Point}
\providecommand{\PointsName}{Punkte}
\providecaptionname{ngerman, german}{\PointsName}{Punkte}
\providecaptionname{english, american, british}{\PointsName}{Points}


%Has to be initialized after captionnames have been defined
 \AtBeginDocument{
  \TUDa_update_headline_boxes:
  \TUDa_ex_adjust_headheight:
  \global\let\ConfigureHeadline\TUDa_ConfigureHeadline:n
}



%task environment
%TODO: discussion: allow sectioning
\DeclareSectionCommand[%
style=section,%
level=1,%
indent=\z@,%
beforeskip=\cs_if_exist_use:NF \scr@subsection@beforeskip {-3.25ex\@plus -1ex \@minus -.2ex},%
afterskip=\cs_if_exist_use:NF \scr@subsection@afterskip {1.5ex \@plus .2ex},%
tocstyle=section,%
tocindent=\cs_if_exist_use:NF \scr@tso@subsection@indent {1.5em},%
tocnumwidth=\cs_if_exist_use:NF \scr@tso@subsection@numwidth {2.3em},%
]{task}

\renewcommand*{\thetask}{\g_TUDa_ex_sheetnum_tl\tl_if_empty:NF \g_TUDa_ex_sheetnum_tl{.}\arabic{task}}
\renewcommand*{\taskformat}{\taskname\tasksep\thetask{}}

\let\@task\task
\cs_undefine:N \task

\NewDocumentEnvironment{task}{om}{
	\begingroup
	\IfNoValueF{#1}{\keys_set:nn {TUDa/exercise}{#1}}
	\@task{#2}
	\endgroup
}{}


% subtasks
\DeclareSectionCommand[%
style=section,%
level=2,%
indent=\z@,%
beforeskip=\cs_if_exist_use:NF \scr@subsubsection@beforeskip {-3.25ex\@plus -1ex \@minus -.2ex},%
afterskip=\cs_if_exist_use:NF \scr@subsubsection@afterskip {1.5ex \@plus .2ex},%
tocstyle=subsection,%
tocindent=\cs_if_exist_use:NF \scr@tso@subsubsection@indent {1.5em},%
tocnumwidth=\cs_if_exist_use:NF \scr@tso@subsubsection@numwidth {2.3em},%
counterwithin=task,%
]{subtask}

\renewcommand*{\thesubtask}{\alph{subtask})}
\renewcommand*{\subtaskformat}{\thetask{}\thesubtask\enskip}
\setkomafont{subtask}{\mdseries\normalsize}

\let\@subtask\subtask
\cs_undefine:N \subtask

\NewDocumentEnvironment{subtask}{o}{
	\tl_if_in:nnT {#1} {=} {
		\keys_set:nn {TUDa/subtask} {#1}
	}
	\bool_if:NTF \l_TUDa_ex_subtask_fallback_bool {
		\@subtask{\IfNoValueF{#1}{#1}}
	}{
		\@subtask{\l_TUDa_ex_title_tl}
	}
	}{}

%Solution mechanism

\DeclareSectionCommand[%
style=section,%
level=2,%
indent=\z@,%
beforeskip=\cs_if_exist_use:NF \scr@subsubsection@beforeskip {-3.25ex\@plus -1ex \@minus -.2ex},%
afterskip=\cs_if_exist_use:NF \scr@subsubsection@afterskip {1.5ex \@plus .2ex},%
tocstyle=subsection,%
tocindent=\cs_if_exist_use:NF \scr@tso@subsubsection@indent {1.5em},%
tocnumwidth=\cs_if_exist_use:NF \scr@tso@subsubsection@numwidth {2.3em},%
]{@solution}


\setkomafont{@solution}{\normalfont}

\cs_new:Nn \TUDa_ex_solutionheader: {
  \@solution*{\solutionname\solutionsep}
}

\box_new:N \g_TUDa_NumberForm_box
\hbox_gset:Nn \g_TUDa_NumberForm_box {
  \rule{\fboxrule}{1ex}
  \rule{1em}{\fboxrule}
  \rule{\fboxrule}{1ex}
  \,
}

\newcommand*\TUDa@StudentID[1][7]{
  \StudentIDname\StudentIDsep\prg_replicate:nn {#1} {\box_use:N \g_TUDa_NumberForm_box}
}
\let\StudentID\TUDa@StudentID

\newcommand*\TUDa@StudentName{
  \StudentNamename\StudentNamesep\hrulefill\qquad
}
\let\StudentName\TUDa@StudentName

\let\ShortTitle\g_TUDa_shorttitle_tl

% Compatibility Features

\bool_if:NT \g_TUDa_ex_compatibility_bool {
  \cs_set_eq:NN \c@subsection \c@task
  \cs_set_eq:NN \subsection \task
  \cs_set_eq:NN \c@subsubsection \c@subtask
  \cs_set_eq:NN \subsubsection \subtask
  \cs_set_eq:NN \thetask \thesubsection
  \cs_set_eq:NN \thesubtask \thesubsection
}

\endinput
%End of class tudaexercise.cls
