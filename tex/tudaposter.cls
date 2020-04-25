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
	color .code:n = {\PassOptionsToPackage{color=#1}{tudacolors}},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccent=#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{identbar=#1}{tudacolors}},
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
	type .choice:,
	type / default .code:n = {
		\int_gset:Nn \g_TUDa_postertype_int {1}
	},
	type / announcement .code:n = {
		\int_gset:Nn \g_TUDa_postertype_int {2}
		\keys_set:nn {TUDa/poster}{
			marginpar=true,
			indenttext=false,%allow overwrite - check default
			logo=head,
			title=small,
			colorsubtitle=true
		}
	},
	type .initial:n = default,
	indenttext .bool_gset:N = \g_TUDa_indenttext_bool,
	indenttext .initial:n = false,
	indenttext .default:n = true,
	marginpar .bool_gset:N = \g_TUDa_marginpar_bool,
	marginpar / auto .meta:n = {marginpar = true} ,
	marginpar .default:n = true,
	marginpar .initial:n = false,
	title .choice:,
	title / default .meta:n = {title=large},
	title / large .code:n = \bool_gset_false:N \g_TUDa_smalltitle_bool,
	title / small  .code:n = \bool_gset_true:N \g_TUDa_smalltitle_bool,
	title .initial:n = default,
	colorsubtitle .bool_gset:N = \g_TUDa_colorsubtitle_bool,
	colorsubtitle .default:n = true,
	colorsubtitle .initial:n = false,
}


\ProcessKeysOptions{TUDa/poster}

\ExplSyntaxOff
\LoadClass[parskip=half-]{scrartcl}
\RequirePackage{scrlayer}
\RequirePackage{scrlayer-notecolumn}
\ExplSyntaxOn

\tl_if_empty:NT \g_TUDa_paper_tl {\keys_set:nn {TUDa/poster} {paper=a0}}

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


\setkomafont{title}{\color{textonaccentcolor}\expandafter\fontsize\TUDa_title_fontsize:\selectfont}
\setkomafont{subtitle}{\expandafter\fontsize\TUDa_titleinfo_fontsize:\selectfont}
\newkomafont{titleinfo}{\expandafter\fontsize\TUDa_titleinfo_fontsize:\selectfont}

\ExplSyntaxOff
\KOMAoptions{fontsize=\csname g_TUDa_fontsize_tl\endcsname}
\ExplSyntaxOn

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
	}
}

%%%%%%%%%%%%%%%%%%%%%%
%marginpar option
\dim_new:N \g_TUDa_marginpar_dim
%%%%%%%%%%%%%%%%%%%%%%
\dim_new:N \g_TUDa_titleindent_dim
\begingroup
\expandafter\fontsize\TUDa_title_fontsize:\selectfont
	\dim_gset:Nn \g_TUDa_titleindent_dim {.5ex}
\endgroup

\dim_new:N \g_TUDa_columnSep_dim
\dim_gset:Nn \g_TUDa_columnSep_dim {1em}

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

\bool_if:NTF \g_TUDa_marginpar_bool {
	\dim_gset:Nn \g_TUDa_marginpar_dim {2.2\c_TUDa_logoheight_dim}
	\geometry{
		includemp, marginpar=\g_TUDa_marginpar_dim, marginparsep=\g_TUDa_columnSep_dim,
		right = \dim_eval:n {
			\g_TUDa_margin_dim +
			\bool_if:nTF {\g_TUDa_indenttext_bool && !\g_TUDa_marginpar_bool}
			{\g_TUDa_titleindent_dim} {0pt}
		},
	}
	\KOMAoptions{mpinclude}
}{
	\dim_gzero:N \g_TUDa_marginpar_dim
	\geometry{
		nomarginpar,
		right = \dim_eval:n {
			\bool_if:NT \g_TUDa_indenttext_bool
			{\g_TUDa_titleindent_dim}
			+ \g_TUDa_margin_dim
		},
	}
	\KOMAoptions{mpinclude=false}
}


\bool_if:NT \g_TUDa_poster_foot_bool {
	\dim_compare:nT {\g_TUDa_footheight_dim = 0pt} {
		\dim_set:Nn \g_TUDa_footheight_dim
		{1.5\baselineskip}
	}
	\geometry{bottom=\dim_eval:n {\g_TUDa_footheight_dim+\footskip+\g_TUDa_margin_dim}}
}
%%%%%%%%%%%%%%%%%%%%%%

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
		\let\width\g_TUDa_qrcode_dim
		\let\height\g_TUDa_qrcode_dim
		\g_TUDa_poster_qrcode_tl
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
		width=\paperwidth-2\g_TUDa_margin_dim,
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
	textarea,
	foreground,
	align=tr,
	hoffset=\paperwidth-\g_TUDa_margin_dim,
	width=2.2\c_TUDa_logoheight_dim,
	height=.5\textheight,
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

\DeclareNewLayer[
	clone=notecolumn.marginpar,
]{TUDa.poster.marginpar}

\DeclareNewPageStyleByLayers{TUDa.poster.title}{TUDa.poster.rule,TUDa.poster.background,TUDa.poster.qrcode,TUDa.poster.footer}
\DeclareNewPageStyleByLayers{TUDa.poster}{TUDa.poster.rule,TUDa.poster.qrcode,TUDa.poster.footer, TUDa.poster.marginpar}
\pagestyle{TUDa.poster}


\dim_new:N \g_TUDa_titlegraphic_max_height_dim
\dim_new:N  \g_TUDa_titleback_dim

\newcommand*{\titleinfo}[1]{\def\@titleinfo{#1}}
\titleinfo{}

\renewcommand*{\maketitle}{
	\begingroup
	\setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
	\bool_if:NT \g_TUDa_marginpar_bool
		{\setlength{\linewidth}{\dim_eval:n  {\textwidth+\g_TUDa_marginpar_dim + \marginparsep}}}
	\vbox_gset:Nn \g_TUDa_title_box
	{
		\usesizeofkomafont{title}
		\parbox[t]{\linewidth}{
			\bool_if:NT \g_TUDa_smalltitle_bool {\raisebox{
					\dim_max:nn {0pt} {1.5\c_TUDa_logoheight_dim - \height}
				}}
			{
			\begin{minipage}[b]{\bool_if:NT \g_TUDa_logo@inhead_bool {.75}\linewidth}
				\leavevmode\par\nointerlineskip
				\bool_if:NF \g_TUDa_indenttext_bool {\begin{addmargin}{\g_TUDa_titleindent_dim }}
					\usekomafont{title}
					\raggedright
					\tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
					\leavevmode\usekomafont{disposition}\usekomafont{title}%
					\@title\strut\par
				\bool_if:NTF \g_TUDa_indenttext_bool {\nointerlineskip\leavevmode}{\end{addmargin}}
			\end{minipage}
		}
	\par\nointerlineskip
	\exp_args:Nf \tl_if_empty:nF {\@subtitle\@titleinfo} {
			\bool_if:NT \g_TUDa_indenttext_bool {\hspace*{-\g_TUDa_titleindent_dim}}\TUDa@smallrule\par
			\nointerlineskip
			\vspace{\c_TUDa_rulesep_dim}
			\bool_if:NTF \g_TUDa_indenttext_bool {\begingroup}{\begin{addmargin}{\g_TUDa_titleindent_dim }}
			\bool_if:NT \g_TUDa_colorsubtitle_bool {\color{textonaccentcolor}}
			\tl_if_empty:NF \@subtitle {{\usekomafont{subtitle}\strut\@subtitle\strut\par}}
			\tl_if_empty:NF \@titleinfo {{\usekomafont{titleinfo}\@titleinfo\par}}
		\nointerlineskip
			\bool_if:NTF \g_TUDa_indenttext_bool {\endgroup} {\end{addmargin}}
			\vspace{\c_TUDa_rulesep_dim}
		 \par\nointerlineskip
		 \bool_if:NT \g_TUDa_indenttext_bool {\hspace*{-\g_TUDa_titleindent_dim}
		}
		}
		\nointerlineskip
		 \TUDa@smallrule
		}
	}
	\endgroup

	\TUDa_Setup_Title_box:
	\dim_gset:Nn \g_TUDa_titleback_dim {
		\bool_if:NT \g_TUDa_colorsubtitle_bool {\box_dp:N \g_TUDa_title_box}+
				\box_ht:N \g_TUDa_title_box+.5\c_TUDa_logoheight_dim
			}

		\ModifyLayer[
	height=\g_TUDa_titleback_dim
	]{TUDa.poster.background}

	\bool_if:NF \g_TUDa_logo@inhead_bool {
		\ModifyLayer[
		addvoffset=\g_TUDa_titleback_dim+\c_TUDa_smallrule_dim
		]{TUDa.poster.logo}
	}

	\bool_if:NT \g_TUDa_logo@inhead_bool {
		\dim_compare:nT {\box_ht:N \g_TUDa_title_info_box+ \box_dp:N \g_TUDa_title_info_box  > \box_ht:N \g_TUDa_title_box}
		{\msg_warning:nn {TUDaPoster} {infobox-too-high}}
	}
	\leavevmode\box_use:N \g_TUDa_title_box\par
	\dim_set:Nn \g_TUDa_titlegraphic_max_height_dim {\textheight-\pagetotal}
	\global\def\contentheight{\g_TUDa_titlegraphic_max_height_dim}
	\tl_if_empty:NF \@titlegraphic{
		\vbox_gset:Nn \g_TUDa_titlegraphic_box {\parbox[t]{\dim_eval:n {\paperwidth-2\g_TUDa_margin_dim}}{\@titlegraphic}}
		\par\nointerlineskip
		\box_use:N \g_TUDa_titlegraphic_box
	}

	\DeclareLayer[
	clone=TUDa.poster.marginpar,
	height=\bool_if:NF \l_TUDa_marginpar_overlap_bool {-\box_ht:N \g_TUDa_titlegraphic_box-\box_dp:N \g_TUDa_titlegraphic_box}
	+\textheight-\box_ht:N \g_TUDa_title_box-\box_dp:N \g_TUDa_title_box-.5\c_TUDa_logoheight_dim,
	addvoffset=\bool_if:NF \l_TUDa_marginpar_overlap_bool {+\box_ht:N\g_TUDa_titlegraphic_box+\box_dp:N \g_TUDa_titlegraphic_box}
	+\box_ht:N \g_TUDa_title_box+\box_dp:N \g_TUDa_title_box+.5\c_TUDa_logoheight_dim,
	]{TUDa.poster.marginpar.title}

	\tl_if_empty:NF \g_TUDa_poster_qrcode_tl {
		\ModifyLayer[addwidth=-\g_TUDa_qrcode_dim-\c_TUDa_rulesep_dim]{TUDa.poster.footer}
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

\global\def\contentwidth{\linewidth}
\global\def\contentheight{\g_TUDa_titlegraphic_max_height_dim}


\def\@titlegraphic{}
\newcommand{\titlegraphic}[1]{
	\def\@titlegraphic{#1}
}
\box_new:N \g_TUDa_titlegraphic_box

\seq_new:N \g_TUDa_title_info_seq

\seq_gput_right:Nn \g_TUDa_title_info_seq {
	\rlap{\includegraphics[height=\c_TUDa_logoheight_dim]{\g_TUDa_logofile_tl}}
}

\box_new:N \g_TUDa_title_info_box
\box_new:N \g_TUDa_title_box

\colorlet{TUDa@InfoBoxColor}{white}

\cs_new:Nn \TUDa_make_title_info_box:n {
	\usekomafont{titleinfo}
	\setlength{\fboxsep}{.2\baselineskip}
	\colorbox{TUDa@InfoBoxColor}{\hspace*{\dimexpr.2\c_TUDa_logoheight_dim-\fboxsep}%
		\parbox{2\c_TUDa_logoheight_dim}{
			\raggedright
			#1
	}}
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
	\tl_gset:Nn \g_TUDa_poster_qrcode_tl
	{\raisebox{\depth}{\qrcode[height={\g_TUDa_qrcode_dim}]{#1}}}
}

\newcommand*{\footerqrcodeimg}[1]{\tl_gset:Nn \g_TUDa_poster_qrcode_tl {#1}}


\RedeclareSectionCommand[afterskip=1ex plus .2ex]{section}
\RedeclareSectionCommand[afterskip=.2ex plus .2ex]{subsection}

\msg_new:nnn {TUDaPoster} {infobox-too-high} {
	The~height~of~your~Infobox~exeeds~the~space~reserved~in~the~title~block.\\
	You~should~probably~switch~to~logo=bottom~or~reduce~the~number/size~of~InfoBoxes.
}

\keys_define:nn {TUDa/poster/marginparopts}{
	valign .tl_set:N = \l_TUDa_marginpar_valign_tl,
	valign .initial:n = t,
	overlap .bool_set:N = \l_TUDa_marginpar_overlap_bool,
	overlap .initial:n = false,
	overlap .default:n = true
}




\newcommand*{\infofont}{\accentfont\normalcolor\footnotesize}
\DeclareTextFontCommand{\infotext}{\infofont}

\int_new:N \g_TUDa_marginpar_int

\NewDocumentCommand{\SetMarginpar}{o+m}{
	\bool_if:NF \g_TUDa_marginpar_bool {\msg_warning:nn {TUDa/Poster} {marginpar-disabled}}
	\IfNoValueF{#1}{\keys_set:nn {TUDa/poster/marginparopts} {#1}}
	\ModifyLayer[addvoffset={-\ht\strutbox},contents={\parbox[t][\layerheight][\l_TUDa_marginpar_valign_tl]{\layerwidth}{#2}}]{TUDa.poster.marginpar}
	\bool_set_true:N \l_tmpa_bool
}

\msg_new:nnnn {TUDa/Poster} {marginpar-disabled} {
	You~are~adding~data~to~the~marginpar~box,~though~marginpar option is set to false.\\
	I~will~add~it,~but~cannot~ensure~the~position.
} {
	I'd~suggest~to~switch~the~marginpar~option~to~true.
	See~the~TUDa-CI~documentation~for~further~information.
}

\endinput
