%% This is file `tudasciposter.cls' version 3.36 (2024-01-05),
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

\ProvidesExplPackage{tudasciposter}{\filedate}{\fileversion}{Scientific Poster Layout for TU Darmstadt}

\prop_new:N \g_ptxcd_clsopts_prop
\tl_new:N \g_ptxcd_boxstyle_tl
\int_new:N \g_ptxcd_paper_int
\str_new:N \g_ptxcd_department_str
\str_const:Nn \c__ptxcd_base_str {sciposter}

\keys_define:nn {ptxcd/poster} {
	accentcolor .code:n = {\PassOptionsToPackage{accent =#1}{tudacolors}},
	color .meta:n = {accentcolor = #1},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccent =#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{identbar =#1}{tudacolors}},
	titletext .code:n = {\PassOptionsToPackage{text =#1}{tudacolors}},
	footer .bool_gset:N = \g_ptxcd_poster_foot_bool,
	footer .default:n = true,
	footer .initial:n = true,
	thanks .tl_gset:N = \g_ptxcd_footnote_label_tl,
	thanks .initial:n = arabic*,
	pdfa .bool_gset:N = \g_ptxcd_pdfa_bool,
	pdfa .initial:n = false,
	boxstyle .choice:,
	boxstyle / official .code:n = \tl_gset:Nn \g_ptxcd_boxstyle_tl {TUDa},
	boxstyle / colored .code:n= \tl_gset:Nn \g_ptxcd_boxstyle_tl {TUDa-colored},
	boxstyle / boxed .code:n= \tl_gset:Nn \g_ptxcd_boxstyle_tl {TUDa-boxed},
	boxstyle /default .meta:n = {boxstyle=official},
	boxstyle .initial:n = default,
	unknown .code:n = {\prop_gput:NVn \g_ptxcd_clsopts_prop \l_keys_key_tl {#1}},
	paper .choices:nn = {a0,a1,a2,a3}{
		\int_gset_eq:NN \g_ptxcd_paper_int  \l_keys_choice_int
		\exp_args:Nx \PassOptionsToPackage{paper=\l_keys_choice_tl}{tudarules}
		\exp_args:Nx \PassOptionsToPackage{\l_keys_choice_tl paper}{geometry}
	},
	paper / landscape .code:n = \PassOptionsToPackage{landscape}{geometry},
	paper / portrait .code:n = \PassOptionsToPackage{portrait}{geometry},
	paper .initial:n = a0,
	fontsize .tl_gset:N = \g_ptxcd_fontsize_tl,
	logofile .tl_gset:N = \g_ptxcd_logofile_tl,
	logofile .initial:n = tuda_logo,
	title .choice:,
	title / default .meta:n = {title=large},
	title / large .code:n = \bool_gset_false:N \g_ptxcd_smalltitle_bool,
	title / small  .code:n = \bool_gset_true:N \g_ptxcd_smalltitle_bool,
	title .initial:n = default,
	colorback .bool_gset:N = \g_ptxcd_colorback_bool,
	colorback .initial:n = true,
	department .choice:,
	department / default .code:n = \str_gset:Nn \g_ptxcd_department_str {default},
	department / mecheng .code:n = {
		\str_gset:Nn \g_ptxcd_department_str {mecheng}
		\keys_set:nn {ptxcd/poster} {colorback=false, departmentlogofile=tuda_maschinenbau_logo,titlesepline=false}
	},
	department .initial:n = default,
  department / unknown .code:n = {
		\str_gset:Nx \g_ptxcd_department_str {\l_keys_value_tl}
	},,
	departmentconfigprefix .tl_gset:N = \g__ptxcd_config_prefix_tl,
	departmentconfigprefix .initial:n = tuda,
	mecheng .meta:n = {department=mecheng},
	departmentlogofile .tl_gset:N = \g_ptxcd_departmentlogo_tl,
	departmentlogofile .initial:n =,
	titlesepline .bool_gset:N = \g_ptxcd_titlesepline_bool,
	titlesepline .initial:n = true,
}

\ProcessKeyOptions[ptxcd/poster]

\dim_new:N \g_ptxcd_margin_dim
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

\prop_gput:NnV \g_ptxcd_clsopts_prop {fontsize} \g_ptxcd_fontsize_tl

\prop_map_inline:Nn \g_ptxcd_clsopts_prop {
	\tl_if_empty:nTF {#2}
	{\PassOptionsToClass{#1}{scrartcl}}
	{\clist_map_inline:nn {#2} {\PassOptionsToClass{#1=##1}{scrartcl}}}
}

\bool_if:NT  \g_ptxcd_pdfa_bool {\PassOptionsToPackage{RGB}{xcolor}}

\ExplSyntaxOff
\PassOptionsToPackage{DIV=10}{typearea}
\LoadClass[parskip=full-]{scrartcl}
\RequirePackage{tudafonts}
\RequirePackage{tikz}
\usetikzlibrary{calc}

\RequirePackage{tcolorbox}
\tcbuselibrary{poster}

\RequirePackage[margin=0pt]{geometry}
\ExplSyntaxOn



%Font adjusments
\renewcommand*{\familydefault}{\sfdefault}

\setkomafont{title}{
	\color{titlefgcolor}
	\expandafter\fontsize\ptxcd_title_fontsize:\selectfont
	\bfseries
}

\setkomafont{author}{\bfseries}
\setkomafont{captionlabel}{\bfseries}

\setkomafont{disposition}{\sffamily\bfseries}

% end of font adjustments

\RequirePackage[mode=tikz]{tudarules}
\RequirePackage{tudacolors}
\RequirePackage{qrcode}

\dim_const:Nn \c_ptxcd_headrule_ht_dim {\c_ptxcd_rulesep_dim +\c_ptxcd_largerule_dim + \c_ptxcd_smallrule_dim}
%Setup title
\box_new:N \l_ptxcd_tmpa_box
\box_new:N \g_ptxcd_titlegraphic_box
\box_new:N \g_ptxcd_title_box
\box_new:N \g_ptxcd_author_box
\box_new:N \g_ptxcd_credit_box

\tl_new:N \g_ptxcd_thanks_tl
\newcommand*{\ptxcd_title@footnote}[2][1]{
	\begingroup
	\ptxcd_def_footnotelabel:
	\footnotemark[#1]\,#2\quad
	\endgroup
}

\tl_greplace_all:Nnn \g_ptxcd_footnote_label_tl {*} {{footnote}}
\clist_map_inline:nn {alph, arabic, fnsymbol, Alph, roman, Roman} {
	\tl_greplace_all:Nnn \g_ptxcd_footnote_label_tl {#1} {\use:c {#1}}
}

\cs_set:Nn \ptxcd_def_footnotelabel: {
	\renewcommand*{\thefootnote}{\g_ptxcd_footnote_label_tl}
}

\pagestyle{empty}
\renewcommand*{\title}[1]{\gdef \@title {#1}}


\dim_new:N \g_ptxcd_footheight_dim
\dim_gset:Nn \g_ptxcd_footheight_dim {0.06\paperwidth}%

\box_new:N \g_ptxcd_footergraphics_box
\newcommand*{\footergraphics}[1]{
	\begingroup
	\let\height\g_ptxcd_footheight_dim
	\hbox_gset:Nn \g_ptxcd_footergraphics_box {#1}
	\endgroup
}

\tl_new:N \g_ptxcd_poster_foot_tl
\newcommand{\footer}[1]{
	\tl_gset:Nn \g_ptxcd_poster_foot_tl {#1}
}

\tl_new:N \g_ptxcd_poster_qrcode_tl

\msg_new:nnnn {tudapub} {biblatex-required}{
	You~tried~to~use~#1.\\
	This~feature~requires~the~biblatex~package.
} {
	Try~to~remove~the~star~or~load~biblatex.
}

\NewDocumentCommand{\footerqrcode}{sm}{
	\IfBooleanTF {#1} {
		\cs_if_exist:NTF \blx@blxinit {
			\begingroup
			\blx@blxinit
			\entrydata{#2}{
				\tl_gset:Nx \g_ptxcd_poster_qrcode_tl{\thefield{url}}
			}
			\endgroup
		}{
			\msg_error:nnx {tudapub} {biblatex-required} {\use:c{footerqrcode*}}
		}
	}{
		\tl_gset:Nn \g_ptxcd_poster_qrcode_tl {#2}
	}
}


%%%%%%%%%%%%%%%%%%%
% Begin of PDF/A mode
%%%%%%%%%%%%%%%%%%%
%PDFA
\if_bool:N \g_ptxcd_pdfa_bool
\PassOptionsToPackage{a-2b}{pdfx}
\RequirePackage{pdfx}
%%hyperref
\hypersetup{hidelinks, unicode, hyperfootnotes=false}
\iow_new:N \ptxcd_xmpdata_stream
\iow_open:Nn \ptxcd_xmpdata_stream {\jobname.xmpdata}
\tl_new:N \g_ptxcd_xmp_title
\tl_new:N \g_ptxcd_xmp_author

\cs_new:Nn \ptxcd_pass_TitleData: {
	\begingroup
	\def\newline{}
	\def\\{}
	\cs_set_eq:NN \thanks \use_none:n
	\cs_set_eq:NN \inst \use_none:n
	\cs_set:Npn \and {\sep}
	\bool_if:NTF \g_ptxcd_pass_TitleData_bool {
		\tl_gset:Nx \g_ptxcd_xmp_title {\@title}
		\seq_clear:N \l_tmpa_seq
		\seq_map_inline:Nn \g_ptxcd_author_seq {
			\seq_put_right:Nx \l_tmpa_seq {##1}
		}
		\tl_gset:Nx \g_ptxcd_xmp_author {\seq_use:Nn \l_tmpa_seq {\sep}}
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
%%hyperref
\RequirePackage[hidelinks, unicode,hyperfootnotes=false]{hyperref}
\fi:

%%%%%%%%%%%%%%%%%%%
% End of PDF/A mode
%%%%%%%%%%%%%%%%%%%

%redefine \author to manage \and and \thanks

\seq_new:N \g_ptxcd_author_seq

\renewcommand*\author[1]{
	\seq_gset_split:Nnn \g_ptxcd_author_seq {\and} {#1}
}

\msg_new:nnn{tudasciposter} {unknown-language} {
	You~selected~an~unknown~language~#1.\\
	The~Variable~#2~does~not~have~a~predefined~value.\\
	Ensure~to~redefine~#2~to~match~your~language.\\
	Otherwise~the~ngerman~vaue~#3~will~be~used.
}

\providecommand*\authorandname{
	\msg_warning:nnxxx{tudasciposter} {unknown-language}
	{\languagename} {\exp_not:N \authorandname} {und}
	und
}

\defcaptionname{ngerman, german}{\authorandname}{und}
\defcaptionname{english, USenglish, american, UKenglish, british}{\authorandname}{and}


\renewcommand*{\@author}{
	\seq_use:Nnnn \g_ptxcd_author_seq {~\authorandname{}~} {,~} {~\&~}
}

\newcommand\titlegraphic[1]{\def\@titlegraphic{#1}}
\titlegraphic{}

\newcommand{\institute}[1]{\def\@institute{#1}}
\institute{}



%Language dependent configuration
\AtBeginDocument{
	\@ifpackageloaded{babel}{
		\addto\extrasngerman{\def\authorandname{und}}
		\addto\extrasgerman{\def\authorandname{und}}
		\addto\extrasenglish{\def\authorandname{and}}
		\addto\extrasbritish{\def\authorandname{and}}
		\addto\captionsngerman{\renewcommand{\figurename}{Abb.}}
		\addto\captionsgerman{\renewcommand{\figurename}{Abb.}}
		\addto\captionsenglish{\renewcommand{\figurename}{Fig.}}
		\addto\captionsbritish{\renewcommand{\figurename}{Fig.}}
	}{}
}

\newlength{\contentwidth}
\setlength{\contentwidth}{\dimexpr\paperwidth-2\g_ptxcd_margin_dim\relax}
\newlength{\contentheight}

\cs_new:Nn \__ptxcd_logo_code:n {
		\node[anchor=north~east,inner~sep=0pt,minimum~width=\dim_eval:n {\__ptxcd_logowidth: + \__ptxcd_logosep:}](#1) at ([xshift=\__ptxcd_logosep:,yshift=-.5\c_ptxcd_logoheight_dim]identbar.south~east){
					\includegraphics[height=\c_ptxcd_logoheight_dim]{\g_ptxcd_logofile_tl}
		};
}


\tcbposterset{
	coverage =
	{
		spread,
		parbox=false,
		bottom=\dim_eval:n {\g_ptxcd_margin_dim
			\bool_if:NT \g_ptxcd_poster_foot_bool {+\g_ptxcd_footheight_dim + 3\c_ptxcd_rulesep_dim}
		},
		left=\g_ptxcd_margin_dim,
		right=\g_ptxcd_margin_dim,
		before= {\ptxcd_poster_setup_title_box:},
		top= \dim_eval:n {
			\bool_if:NF \g_ptxcd_colorback_bool {1.5}
				\g_ptxcd_margin_dim
			+\box_ht:N \ptxcd_headrule_box
			+\box_dp:N \ptxcd_headrule_box
			+\g_ptxcd_titleblock_dim
			+4\c_ptxcd_rulesep_dim
			+\box_ht:N \g_ptxcd_author_box
			+\box_dp:N \g_ptxcd_author_box
		},
		overlay={%
			\coordinate(topleft) at ([xshift=\g_ptxcd_margin_dim, yshift=-\g_ptxcd_margin_dim]current~page.north~ west);
			\coordinate(topright) at ([xshift=-\g_ptxcd_margin_dim, yshift=-\g_ptxcd_margin_dim]current~page.north~ east);
			\coordinate(bottomleft) at ([xshift=\g_ptxcd_margin_dim, yshift=\g_ptxcd_margin_dim]current~page.south~ west);
			\coordinate(bottomright) at ([xshift=-\g_ptxcd_margin_dim, yshift=\g_ptxcd_margin_dim]current~page.south~ east);

			\dim_gset:Nn \g_ptxcd_titleindent_dim {\bool_if:NTF \g_ptxcd_colorback_bool {3\c_ptxcd_rulesep_dim} {\c_zero_dim}}

			\node[inner~sep=0pt, anchor=north~west](identbar) at (topleft){\ptxcd_headrule};
			\bool_if:NTF \g_ptxcd_colorback_bool
			\fill \path [identbarcolor]
			(identbar.south~east)rectangle([yshift=-\g_ptxcd_titleblock_dim]identbar.south~west) coordinate(bottomlefttitleblock);

			\__ptxcd_logo_code:n {TUDalogo}

			\node[inner~sep=0pt,text~width=\__ptxcd_logowidth:,align=right,anchor=north~west,](titlegraphic) at ([yshift=-\c_ptxcd_rulesep_dim]TUDalogo.south~west){\box_use:N \g_ptxcd_titlegraphic_box};

			\node[anchor=north~west,inner~sep=0pt,]  (title) at ([
			xshift=\g_ptxcd_titleindent_dim,yshift=-.5\c_ptxcd_logoheight_dim]identbar.south~west) {\box_use:N \g_ptxcd_title_box};

			\bool_if:NT \g_ptxcd_titlesepline_bool
				{\draw[line~ width=.5\c_ptxcd_smallrule_dim](bottomlefttitleblock)--++(\contentwidth,0);}

			\node[anchor=north~west, inner~xsep=0pt, inner~ ysep=\c_ptxcd_rulesep_dim] (author) at ([xshift=\g_ptxcd_titleindent_dim]bottomlefttitleblock) {\box_use:N \g_ptxcd_author_box};

			\draw[line~ width=.5\c_ptxcd_smallrule_dim](author.south-|identbar.west)--++(\contentwidth,0);


		\bool_if:NT \g_ptxcd_poster_foot_bool {\__ptxcd_typeset_footer:}
	}}
}

\cs_new:Nn \__ptxcd_typeset_footer: {
			\coordinate(lastpos) at (bottomright);
	\tl_if_empty:NF \g_ptxcd_poster_qrcode_tl
	{
		\node[anchor=south~east, inner~sep=\z@] (qrcode)at (lastpos)
		{
			\exp_args:NnV \use:n {\qrcode[height=\dim_use:N \g_ptxcd_footheight_dim]}\g_ptxcd_poster_qrcode_tl
		};
		\coordinate (lastpos) at (qrcode.south~west);
	}
	\box_if_empty:NF \g_ptxcd_footergraphics_box {
		\node[anchor=south~east, inner~sep=\z@] at (lastpos) {
			\accentfont
			\box_use:N \g_ptxcd_footergraphics_box
		};
	}
	\node[anchor=north~ west, inner~ sep=\z@] (infofooter) at ([yshift=\g_ptxcd_footheight_dim]bottomleft) {
		\parbox{\dim_eval:n {\contentwidth
				-\box_wd:N \g_ptxcd_footergraphics_box
				\tl_if_empty:NF \g_ptxcd_poster_qrcode_tl {-\g_ptxcd_footheight_dim-\c_ptxcd_rulesep_dim}
		}}{
			\rule{\linewidth}{.5\c_ptxcd_smallrule_dim}\\
			\accentfont\small\g_ptxcd_poster_foot_tl
			\par\medskip
			\let\footnotetext\ptxcd_title@footnote
			\g_ptxcd_thanks_tl}
	};
}

\hook_gput_code:nnn {ptxcd/init-colors} {tudasciposter} {
	\bool_if:NTF \g_ptxcd_colorback_bool
		{\colorlet{titlefgcolor}{textonaccentcolor}}
		{\colorlet{titlefgcolor}{black}}
	\colorlet{titlebgcolor}{accentcolor}
	% Block Colors
	\colorlet{blocktitlebgcolor}{accentcolor}
	\colorlet{blocktitlefgcolor}{textonaccentcolor}
	% Innerblock Colors
	\colorlet{innerblockbodybgcolor}{textonaccentcolor}
}
% Background Colors
\colorlet{backgroundcolor}{white}
\colorlet{framecolor}{white}
% Block Colors
\colorlet{blockbodybgcolor}{white}
\colorlet{blockbodyfgcolor}{black}
% Innerblock Colors
\colorlet{innerblocktitlebgcolor}{black!15}
\colorlet{innerblocktitlefgcolor}{black}
\colorlet{innerblockbodyfgcolor}{black}

\dim_new:N \g_ptxcd_titleblock_dim
\dim_new:N \g_ptxcd_titleindent_dim

\cs_new:Nn \__ptxcd_inst:n {\textsuperscript{#1}}

\cs_new:Nn \ptxcd_poster_setup_title_box: {
	\hbox_gset:Nn \g_ptxcd_title_box {
	\parbox{.65\paperwidth}{
		\raggedright
		\usekomafont{disposition}\usekomafont{title}\leavevmode\@title \par
	}
	}
	\hbox_gset:Nn \g_ptxcd_author_box {
		\parbox{\dimexpr\contentwidth-6\c_ptxcd_rulesep_dim\relax}{
		\ptxcd_def_footnotelabel:
		\cs_set_eq:NN \inst\__ptxcd_inst:n
		{\usekomafont{author}\@author\\}
		\tl_gset:No \g_ptxcd_thanks_tl {\@thanks}
		\@institute
		}
	}
	\tl_if_empty:NF \@titlegraphic {
		\hbox_gset:Nn \g_ptxcd_titlegraphic_box {
			\parbox{\__ptxcd_logowidth:}{
			\raggedleft
			\@titlegraphic
			}
		}
	}
	\dim_gset:Nn \g_ptxcd_titleblock_dim {
		\dim_max:nn
		{
			+\box_ht:N \g_ptxcd_titlegraphic_box +\box_dp:N \g_ptxcd_titlegraphic_box+ 2\c_ptxcd_logoheight_dim
		}
		{\box_ht:N \g_ptxcd_title_box+ \box_dp:N \g_ptxcd_title_box+\c_ptxcd_logoheight_dim}
	}
}

%%%%%%%%%%%%%%%%%%%%%%
%Declare TCBstyles for tudaposter
\tcbset {
	TUDa/.style =
	{
		enhanced,
		coltitle=black,
		colbacktitle=white,
		coltext=black,
		colback=white,
		size=minimal,
		boxrule=.5\c_ptxcd_smallrule_dim,
		leftrule=\z@,
		rightrule=\z@,
		fonttitle=\usekomafont{disposition}\usekomafont{section},
		before~title={\strut},
		toptitle=.5\c_ptxcd_rulesep_dim,
		bottomtitle=.5\c_ptxcd_rulesep_dim,
		top=\c_ptxcd_rulesep_dim,
		bottom=\c_ptxcd_rulesep_dim,
		frame~code={
			\iftcb@hasTitle
			\fill[tcbcolframe](frame.north~west)rectangle(title.north~east);
			\fill[tcbcolframe](title.south~west)rectangle(interior.north~east);
			\else
			\fill[tcbcolframe](frame.north~west)rectangle(interior.north~east);
			\fi
			\fill[tcbcolframe](interior.south~west)rectangle(frame.south~east);
		},
		parbox=false,
	},
	TUDa-inner/.style =
	{
		TUDa,
		fonttitle=\usekomafont{disposition}\usekomafont{subsubsection}
	},
	TUDa-colored/.style =
	{
		TUDa,
		left=.5\c_ptxcd_rulesep_dim,
		right=.5\c_ptxcd_rulesep_dim,
		colbacktitle=blocktitlebgcolor,
		coltitle=blocktitlefgcolor,
		colback=blockbodybgcolor,
		coltext=blockbodyfgcolor,
		fonttitle=\usekomafont{disposition}\usekomafont{section},
		titlerule=\z@,
	},
	TUDa-colored-inner/.style =
	{
		TUDa-colored,
		colbacktitle=innerblocktitlebgcolor,
		coltitle=innerblocktitlefgcolor,
		colback=innerblockbodybgcolor,
		coltext=innerblockbodyfgcolor,
		fonttitle=\usekomafont{disposition}\usekomafont{subsubsection}
	},
	TUDa-boxed/.style =
	{
		enhanced,
		size=minimal,
		colbacktitle=blocktitlebgcolor,
		coltitle=blocktitlefgcolor,
		colback=blockbodybgcolor,
		coltext=blockbodyfgcolor,
		boxsep=\c_ptxcd_rulesep_dim,
		boxrule=.5\c_ptxcd_smallrule_dim,
		titlerule=\z@,
		arc=1ex,
		auto~outer~arc,
		fonttitle=\usekomafont{disposition}\usekomafont{section},
		before~title={\strut},
		parbox=false,
	},
	TUDa-boxed-inner/.style =
	{
		TUDa-boxed,
		colbacktitle=innerblocktitlebgcolor,
		coltitle=innerblocktitlefgcolor,
		colback=innerblockbodybgcolor,
		coltext=innerblockbodyfgcolor,
		sharp~corners,
		fonttitle=\usekomafont{disposition}\usekomafont{subsubsection}
	},
}

%Select default box styles according to style option
\tcbposterset{boxes ={\g_ptxcd_boxstyle_tl}, poster={spacing=5cm}}
\tcbset{
	every~ box~ on~ layer~ 3/.style={reset,\g_ptxcd_boxstyle_tl -inner},
	every~ box~ on~ layer~ 4/.style={reset,\g_ptxcd_boxstyle_tl -inner},
}

%Adjust caption indent
\setcapindent{1em}

\file_if_exist_input:n {\g__ptxcd_config_prefix_tl\g_ptxcd_department_str.cfg}

\hook_use:n {ptxcd/init-colors}

\ptxcd_makeheadrule[
	width=\paperwidth-2\g_ptxcd_margin_dim,
	color=identbarcolor
]{ptxcd_headrule}

\endinput
%end of tudasciposter.cls
