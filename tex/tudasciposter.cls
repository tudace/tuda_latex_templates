\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplPackage{tudasciposter}{\filedate}{\fileversion}{Scientific Poster Layout for TU Darmstadt}

\RequirePackage{l3keys2e}

\prop_new:N \g_TUDa_clsopts_prop
\tl_new:N \g_TUDa_boxstyle_tl
\int_new:N \g_TUDa_paper_int

\keys_define:nn {TUDa/poster} {
	accentcolor .code:n = {\PassOptionsToPackage{accent =#1}{tudacolors}},
	color .meta:n = {accentcolor = #1},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccent =#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{indentbar =#1}{tudacolors}},
	titletext .code:n = {\PassOptionsToPackage{text =#1}{tudacolors}},
	footer .bool_gset:N = \g_TUDa_poster_foot_bool,
	footer .default:n = true,
	footer .initial:n = true,
	thanks .tl_gset:N = \g_TUDa_footnote_label_tl,
	thanks .initial:n = arabic*,
	pdfa .bool_gset:N = \g_TUDa@pdfa_bool,
	pdfa .initial:n = false,
	boxstyle .choice:,
	boxstyle / official .code:n = \tl_gset:Nn \g_TUDa_boxstyle_tl {TUDa},
	boxstyle / colored .code:n= \tl_gset:Nn \g_TUDa_boxstyle_tl {TUDa-colored},
	boxstyle / boxed .code:n= \tl_gset:Nn \g_TUDa_boxstyle_tl {TUDa-boxed},
	boxstyle /default .meta:n = {boxstyle=official},
	boxstyle .initial:n = default,
	unknown .code:n = {\prop_gput:NVn \g_TUDa_clsopts_prop \l_keys_key_tl {#1}},
	paper .choices:nn = {a0,a1,a2,a3}{
		\int_gset_eq:NN \g_TUDa_paper_int  \l_keys_choice_int
		\PassOptionsToPackage{paper=\l_keys_choice_tl}{tudarules}
		\PassOptionsToPackage{\l_keys_choice_tl paper}{geometry}
	},
	paper .initial:n = a0,
	fontsize .tl_gset:N = \g_TUDa_fontsize_tl,
	logofile .tl_gset:N = \g_TUDa_logofile_tl,
	logofile .initial:n = tuda_logo,
	title .choice:,
	title / default .meta:n = {title=large},
	title / large .code:n = \bool_gset_false:N \g_TUDa_smalltitle_bool,
	title / small  .code:n = \bool_gset_true:N \g_TUDa_smalltitle_bool,
	title .initial:n = default,
}





\ProcessKeysOptions{TUDa/poster}

\dim_new:N \g_TUDa_margin_dim
\bool_if:NTF \g_TUDa_smalltitle_bool {
	\file_input:n {tuda-a\int_use:N \g_TUDa_paper_int paper.clo}
	\TUDa_setup_title_sizes:
	\file_input:n {tuda-a\int_use:N \g_TUDa_paper_int paper.clo}
	\TUDa_setup_base_sizes:
}{
	\int_gdecr:N \g_TUDa_paper_int
	\file_input:n {tuda-a\int_use:N \g_TUDa_paper_int paper.clo}
	\TUDa_setup_title_sizes:
	\TUDa_setup_base_sizes:
}

\prop_gput:NnV \g_TUDa_clsopts_prop {fontsize} \g_TUDa_fontsize_tl


\prop_map_inline:Nn \g_TUDa_clsopts_prop {
	\tl_if_empty:nTF {#2}
	{\exp_args:NnV\PassOptionsToClass{#1}\l_tmpa_tl}
	{\clist_map_inline:nn {#2} {\PassOptionsToClass{#1=##1}{scrartcl}}}
}

\bool_if:NT  \g_TUDa@pdfa_bool {\PassOptionsToPackage{RGB}{xcolor}}

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
	\expandafter\fontsize\TUDa_title_fontsize:\selectfont
	\bfseries
}

\setkomafont{author}{\bfseries}
\setkomafont{captionlabel}{\bfseries}

\setkomafont{disposition}{\sffamily\bfseries}

% end of font adjustments

\RequirePackage[mode=tikz]{tudarules}
\RequirePackage{tudacolors}
\RequirePackage{qrcode}

\dim_const:Nn \c_TUDa_headrule_ht_dim {\c_TUDa_rulesep_dim +\c_TUDa_largerule_dim + \c_TUDa_smallrule_dim}
%Setup title
\box_new:N \l_TUDa_tmpa_box
\box_new:N \g_TUDa_titlegraphic_box
\box_new:N \g_TUDa_title_box
\box_new:N \g_TUDa_author_box
\box_new:N \g_TUDa_credit_box

\TUDa@makeheadrule[
	width=\paperwidth-2\g_TUDa_margin_dim,
 	color=identbarcolor
 	]{TUDa@posterrule}

\tl_new:N \g_TUDa_thanks_tl
\newcommand*{\TUDa@title@footnote}[2][1]{
	\begingroup
	\TUDa_def_footnotelabel:
	\footnotemark[#1]\,#2\quad
	\endgroup
}

\tl_greplace_all:Nnn \g_TUDa_footnote_label_tl {*} {{footnote}}
\clist_map_inline:nn {alph, arabic, fnsymbol, Alph, roman, Roman} {
	\tl_greplace_all:Nnn \g_TUDa_footnote_label_tl {#1} {\use:c {#1}}
}

\cs_set:Nn \TUDa_def_footnotelabel: {
	\renewcommand*{\thefootnote}{\g_TUDa_footnote_label_tl}
}

\pagestyle{empty}
\renewcommand*{\title}[1]{\gdef \@title {#1}}


\dim_new:N \g_TUDa_footheight_dim
\dim_gset:Nn \g_TUDa_footheight_dim {0.06\paperwidth}%

\box_new:N \g_TUDa_footergraphics_box
\newcommand*{\footergraphics}[1]{
	\begingroup
	\let\height\g_TUDa_footheight_dim
	\hbox_gset:Nn \g_TUDa_footergraphics_box {#1}
	\endgroup
}

\tl_new:N \g_TUDa_poster_foot_tl
\newcommand{\footer}[1]{
	\tl_gset:Nn \g_TUDa_poster_foot_tl {#1}
}

\tl_new:N \g_TUDa_poster_qrcode_tl
\newcommand*{\footerqrcode}[1]{
	\tl_gset:Nn \g_TUDa_poster_qrcode_tl {#1}
}

%%%%%%%%%%%%%%%%%%%
% Begin of PDF/A mode
%%%%%%%%%%%%%%%%%%%
%PDFA
\if_bool:N \g_TUDa@pdfa_bool
\PassOptionsToPackage{a-2b}{pdfx}
\RequirePackage{pdfx}
%%hyperref
\hypersetup{hidelinks, unicode, hyperfootnotes=false}
\iow_new:N \TUDa@xmpdata_stream
\iow_open:Nn \TUDa@xmpdata_stream {\jobname.xmpdata}
\tl_new:N \g_TUDa@xmp_title
\tl_new:N \g_TUDa@xmp_author

\cs_new:Nn \TUDa_pass_TitleData: {
	\begingroup
	\def\newline{}
	\def\\{}
	\let\thanks\use_none:n
	\cs_set:Npn \and {\sep}
	\bool_if:NTF \g_TUDa_pass_TitleData_bool {
		\tl_gset:Nx \g_TUDa@xmp_title {\@title}
		\seq_clear:N \l_tmpa_seq
		\seq_map_inline:Nn \g_TUDa_author_seq {
			\seq_put_right:Nx \l_tmpa_seq {##1}
		}
		\tl_gset:Nx \g_TUDa@xmp_author {\seq_use:Nn \l_tmpa_seq {\sep}}
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
%%hyperref
\RequirePackage[hidelinks, unicode,hyperfootnotes=false]{hyperref}
\fi:

%%%%%%%%%%%%%%%%%%%
% End of PDF/A mode
%%%%%%%%%%%%%%%%%%%

%redefine \author to manage \and and \thanks

\seq_new:N \g_TUDa_author_seq

\renewcommand*\author[1]{
	\seq_gset_split:Nnn \g_TUDa_author_seq {\and} {#1}
}

\msg_new:nnn {TUDaSciPoster} {unknown-language} {
	You~selected~an~unknown~language~#1.\\
	The~Variable~#2~does~not~have~a~predefined~value.\\
	Ensure~to~redefine~#2~to~match~your~language.\\
	Otherwise~the~ngerman~vaue~#3~will~be~used.
}

\providecommand*\authorandname{
	\msg_warning:nnxxx {TUDaSciPoster} {unknown-language}
	{\languagename} {\exp_not:N \authorandname} {und}
	und
}

\defcaptionname{ngerman, german}{\authorandname}{und}
\defcaptionname{english, USenglish, american, UKenglish, british}{\authorandname}{and}


\renewcommand*{\@author}{
	\seq_use:Nnnn \g_TUDa_author_seq {~\authorandname{}~} {,~} {~\&~}
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
\setlength{\contentwidth}{\dimexpr\paperwidth-2\g_TUDa_margin_dim\relax}
\newlength{\contentheight}


\tcbposterset{
	coverage =
	{
		spread,
		parbox=false,
		bottom=\dim_eval:n {\g_TUDa_margin_dim
			\bool_if:NT \g_TUDa_poster_foot_bool {+\g_TUDa_footheight_dim + 3\c_TUDa_rulesep_dim}
		},
		left=\g_TUDa_margin_dim,
		right=\g_TUDa_margin_dim,
		before= {\TUDa@poster_setup_title_box:},
		top= \dim_eval:n {
			\g_TUDa_margin_dim
			+\box_ht:N \TUDa@posterrule_box
			+\box_dp:N \TUDa@posterrule_box
+			\g_TUDa_titleblock_dim
			+4\c_TUDa_rulesep_dim
			+\box_ht:N \g_TUDa_author_box
			+\box_dp:N \g_TUDa_author_box
		},
		overlay={%
			\coordinate(topleft) at ([xshift=\g_TUDa_margin_dim, yshift=-\g_TUDa_margin_dim]current~page.north~ west);
			\coordinate(topright) at ([xshift=-\g_TUDa_margin_dim, yshift=-\g_TUDa_margin_dim]current~page.north~ east);
			\coordinate(bottomleft) at ([xshift=\g_TUDa_margin_dim, yshift=\g_TUDa_margin_dim]current~page.south~ west);
			\coordinate(bottomright) at ([xshift=-\g_TUDa_margin_dim, yshift=\g_TUDa_margin_dim]current~page.south~ east);


			\node[inner~sep=0pt, anchor=north~west](identbar) at (topleft){\TUDa@posterrule};

			\fill[identbarcolor]
			(identbar.south~east)rectangle([yshift=-\g_TUDa_titleblock_dim]identbar.south~west) coordinate(bottomlefttitleblock);

			\node[anchor=north~east,inner~sep=0pt,minimum~width=2.5\c_TUDa_logoheight_dim](TUDalogo) at ([xshift=.3\c_TUDa_logoheight_dim,yshift=-.5\c_TUDa_logoheight_dim]identbar.south~east){
				\includegraphics[height=\c_TUDa_logoheight_dim]{\g_TUDa_logofile_tl}};

			\node[inner~sep=0pt,text~width=2.2\c_TUDa_logoheight_dim,align=right,anchor=north~west,](titlegraphic) at ([yshift=-\c_TUDa_rulesep_dim]TUDalogo.south~west){\box_use:N \g_TUDa_titlegraphic_box};

			\node[anchor=north~west,inner~sep=0pt,]  (title) at ([xshift=3\c_TUDa_rulesep_dim,yshift=-.5\c_TUDa_logoheight_dim]identbar.south~west) {\box_use:N \g_TUDa_title_box};

			\draw[line~ width=.5\c_TUDa_smallrule_dim](bottomlefttitleblock)--++(\contentwidth,0);

			\node[anchor=north~west, inner~xsep=0pt, inner~ ysep=\c_TUDa_rulesep_dim] (author) at ([xshift=3\c_TUDa_rulesep_dim]bottomlefttitleblock) {\box_use:N \g_TUDa_author_box};

			\draw[line~ width=.5\c_TUDa_smallrule_dim](author.south-|identbar.west)--++(\contentwidth,0);



		\bool_if:NT \g_TUDa_poster_foot_bool {
			\coordinate(lastpos) at (bottomright);
			\tl_if_empty:NF \g_TUDa_poster_qrcode_tl
			{
				\node[anchor=south~east, inner~sep=\z@] (qrcode)at (lastpos)
				{
					\exp_args:NnV \use:n {\qrcode[height=\dim_use:N \g_TUDa_footheight_dim]}\g_TUDa_poster_qrcode_tl
				};
				\coordinate (lastpos) at (qrcode.south~west);
			}
			\box_if_empty:NF \g_TUDa_footergraphics_box {
				\node[anchor=south~east, inner~sep=\z@] at (lastpos) {
					\accentfont
					\box_use:N \g_TUDa_footergraphics_box
				};
			}
			\node[anchor=north~ west, inner~ sep=\z@] (infofooter) at ([yshift=\g_TUDa_footheight_dim]bottomleft) {
				\parbox{\dim_eval:n {\contentwidth
						-\box_wd:N \g_TUDa_footergraphics_box
						\tl_if_empty:NF \g_TUDa_poster_qrcode_tl {-\g_TUDa_footheight_dim-\c_TUDa_rulesep_dim}
				}}{
			\rule{\linewidth}{.5\c_TUDa_smallrule_dim}\\
					\accentfont\small\g_TUDa_poster_foot_tl
					\par\medskip
					\let\footnotetext\TUDa@title@footnote
					\g_TUDa_thanks_tl}
			};


}
	}}
}

% Background Colors
\colorlet{backgroundcolor}{white}
\colorlet{framecolor}{white}
% Title Colors
\colorlet{titlefgcolor}{textonaccentcolor}
\colorlet{titlebgcolor}{accentcolor}
% Block Colors
\colorlet{blocktitlebgcolor}{accentcolor}
\colorlet{blocktitlefgcolor}{textonaccentcolor}
\colorlet{blockbodybgcolor}{white}
\colorlet{blockbodyfgcolor}{black}
% Innerblock Colors
\colorlet{innerblocktitlebgcolor}{black!15}
\colorlet{innerblocktitlefgcolor}{black}
\colorlet{innerblockbodybgcolor}{textonaccentcolor}
\colorlet{innerblockbodyfgcolor}{black}

\dim_new:N \g_TUDa_titleblock_dim

\cs_new:Nn \TUDa@poster_setup_title_box: {
	\hbox_gset:Nn \g_TUDa_title_box {
	\parbox{.65\paperwidth}{
		\raggedright
		\usekomafont{disposition}\usekomafont{title}\leavevmode\@title \par
	}
	}
	\hbox_gset:Nn \g_TUDa_author_box {
		\parbox{\dimexpr\contentwidth-6\c_TUDa_rulesep_dim\relax}{
		\TUDa_def_footnotelabel:
		{\usekomafont{author}\@author\\}%\\[.2\titleinnersep]
		\tl_gset:No \g_TUDa_thanks_tl {\@thanks}
		\@institute
		}
	}
	\tl_if_empty:NF \@titlegraphic {
		\hbox_gset:Nn \g_TUDa_titlegraphic_box {
			\parbox{2.2\c_TUDa_logoheight_dim}{
			\raggedleft
			\@titlegraphic
			}
		}
	}
	\dim_gset:Nn \g_TUDa_titleblock_dim {
		\dim_max:nn
		{\dim_max:nn
			{2\c_TUDa_logoheight_dim}
			{\box_ht:N \g_TUDa_titlegraphic_box +\box_dp:N \g_TUDa_titlegraphic_box+1.8\c_TUDa_logoheight_dim}
		}
		{\box_ht:N \g_TUDa_title_box+ \box_dp:N \g_TUDa_title_box+.8\c_TUDa_logoheight_dim}
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
		boxrule=.5\c_TUDa_smallrule_dim,
		leftrule=\z@,
		rightrule=\z@,
		fonttitle=\usekomafont{disposition}\usekomafont{section},
		before~title={\strut},
		toptitle=.5\c_TUDa_rulesep_dim,
		bottomtitle=.5\c_TUDa_rulesep_dim,
		top=\c_TUDa_rulesep_dim,
		bottom=\c_TUDa_rulesep_dim,
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
		left=.5\c_TUDa_rulesep_dim,
		right=.5\c_TUDa_rulesep_dim,
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
		boxsep=\c_TUDa_rulesep_dim,
		boxrule=.5\c_TUDa_smallrule_dim,
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
\tcbposterset{boxes ={\g_TUDa_boxstyle_tl}, poster={spacing=5cm}}
\tcbset{
	every~ box~ on~ layer~ 3/.style={reset,\g_TUDa_boxstyle_tl -inner},
	every~ box~ on~ layer~ 4/.style={reset,\g_TUDa_boxstyle_tl -inner},
}

%ADjust caption indent
\setcapindent{1em}


\endinput
%end of tudasciposter.cls
