\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass{tudapub}
	{\filedate}{\fileversion}{Publications using TU Darmstadt's Corporate Design (TUDa-CI)}

\RequirePackage{l3keys2e}
\RequirePackage{URspecialopts}

\Define@specialopt@Module[ptxcd/pub]


\str_const:Nn \c__ptxcd_base_str {pub}
\tl_new:N \g_ptxcd_pub_class_tl
\tl_new:N \g_ptxcd_thesis_options_tl

\prop_new:N \g_ptxcd_clsopts_prop
\prop_new:N \g_ptxcd_unknown_clsopts_prop
\prop_gput:Nnn \g_ptxcd_clsopts_prop {titlepage} {firstiscover}
\prop_gput:Nnn \g_ptxcd_clsopts_prop {captions} {nooneline}

\int_new:N \g_ptxcd_ruledheaders_int
\int_new:N \g_ptxcd_paper_int
\msg_new:nnn {tudapub} {compatibility-only} {
	You~used~the~outdated~#1~option.\\
	This~option~has~been~removed~with~tuda-ci~version~3.08.\\
	See~documentation~for~the~updated~implementation.
}

\bool_new:N \g_ptxcd_geometry_bool
\bool_new:N \g_ptxcd_custommargins_bool
\bool_new:N \g_ptxcd_colorbacktitle_bool
\bool_new:N \g_ptxcd_colorbacksubtitle_bool

\keys_define:nn {ptxcd/pub} {
	%twoside -> geometry + class
	class .choice:,
	class/report .meta:n = {class=scrreprt},
	class/scrreprt .code:n  = \tl_gset:Nn \g_ptxcd_pub_class_tl {scrreprt},
	class/article .meta:n = {class=scrartcl},
	class/scrartcl .code:n  = \tl_gset:Nn \g_ptxcd_pub_class_tl {scrartcl},
	class/book .meta:n = {class=scrbook},
	class/scrbook .code:n  = \tl_gset:Nn \g_ptxcd_pub_class_tl {scrbook},
	class .initial:n = scrartcl,%MAYBE add custom values
	color .meta:n = {accentcolor=#1},
	accentcolor .code:n = {\PassOptionsToPackage{accentcolor=#1}{tudacolors}},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccentcolor=#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{identbarcolor=#1}{tudacolors}},
	marginpar .tl_gset:N = \g_ptxcd_marginpar_tl,
	marginpar .default:n = auto,
	marginpar .initial:n = auto,
	custommargins .choice:,
	custommargins / true .code:n ={
		\bool_gset_true:N \g_ptxcd_custommargins_bool
		\bool_gset_false:N \g_ptxcd_geometry_bool
	},
	custommargins / false .code:n ={
		\bool_gset_false:N \g_ptxcd_custommargins_bool
		\bool_gset_true:N \g_ptxcd_geometry_bool
	},
	custommargins / geometry .code:n = {
		\bool_gset_true:N \g_ptxcd_custommargins_bool
		\bool_gset_true:N \g_ptxcd_geometry_bool
	},
	custommargins .initial:n = false,
	custommargins .default:n = true,
	fontsize .code:n = \prop_gput:Nnn \g_ptxcd_clsopts_prop {fontsize} {#1},
	fontsize .initial:n = {9pt},
	ruledheaders .choices:nn = {false, none, chapter, section, true,  all}{
		\int_gset:Nn \g_ptxcd_ruledheaders_int {\l_keys_choice_int}
	},
	ruledheaders .initial:n = all,
	type .choices:nn = {publication, thesis} {\tl_gset_eq:NN \g_ptxcd_pubType_tl \l_keys_choice_tl},
	type / intern .code:n = {\keys_set:nn {ptxcd/pub}  {titlepage=false, pdfa=false, IMRAD=false}},
	type .initial:n = publication,
	unknown .code:n = {\prop_gput:NVn \g_ptxcd_unknown_clsopts_prop \l_keys_key_tl {#1}},
	headline .choice:,
	headline / true .code:n = \bool_gset_true:N \g_ptxcd_headline_bool,
	headline / false .code:n = \bool_gset_false:N \g_ptxcd_headline_bool,
	headline / automark .code:n = {\bool_gset_true:N \g_ptxcd_headline_bool \PassOptionsToPackage{automark}{scrlayer-scrpage}},
	automark .meta:n = {headline=automark},
	headline .initial:n =false,
	colorback .bool_gset:N = \g_ptxcd_colorback_bool,
	colorback .initial:n = true,
	colorback / title .code:n = 
		\bool_gset_true:N \g_ptxcd_colorbacktitle_bool
		\bool_gset_true:N \g_ptxcd_colorback_bool
		\bool_gset_false:N \g_ptxcd_colorbacksubtitle_bool,
	colorback / body .code:n =
		\bool_gset_false:N \g_ptxcd_colorbacktitle_bool
		\bool_gset_false:N \g_ptxcd_colorbacksubtitle_bool
		\bool_gset_true:N \g_ptxcd_colorback_bool,
	colorback / head .code:n = 
		\bool_gset_true:N \g_ptxcd_colorbacktitle_bool
		\bool_gset_true:N \g_ptxcd_colorback_bool
		\bool_gset_true:N \g_ptxcd_colorbacksubtitle_bool,
	colortitleback .code:n =  \msg_error:nnx {tudapub} {compatibility-only} {\l_keys_key_tl},
	pdfa .bool_gset:N = \g_ptxcd_pdfa_bool,
	pdfa .initial:n = true,
	twocolumn .bool_gset:N = \g_ptxcd_twocolumn_bool,
	twocolumn .default:n = true,
	twocolumn .initial:n = false,
	BCOR .code:n = \PassOptionsToPackage{bindingoffset=#1}{geometry},
	bindingoffset .meta:n = {BCOR=#1},
	captions .code:n = {\prop_gput:Nnx \g_ptxcd_clsopts_prop {captions} {
		\use:n {\prop_item:Nn \g_ptxcd_clsopts_prop {captions}}, #1}
	},
	abstract .code:n = \prop_gput:Nnn \g_ptxcd_unknown_clsopts_prop {abstract} {#1},
	abstract .initial:n =true,
	logo .choice:,
	logo / head .code:n = {
		\bool_gset_true:N \g__ptxcd_LogoInHead_bool
		\bool_gset_true:N \g_ptxcd_colorbacktitle_bool
	},
	logo / body .code:n = {
		\bool_gset_false:N \g__ptxcd_LogoInHead_bool
		\bool_gset_false:N \g_ptxcd_colorbacktitle_bool
	},
	logo / top .meta:n = {logo=head},
	logo / bottom .code:n = {\bool_gset_false:N \g__ptxcd_LogoInHead_bool},
	logo .initial:n = {body},
	paper .choices:nn = {a0,a1,a2,a3,a4,a5,a6}{
		\int_gset_eq:NN \g_ptxcd_paper_int  \l_keys_choice_int
		\exp_args:Nx \PassOptionsToPackage{paper=\l_keys_choice_tl}{tudarules}
		\exp_args:Nx \PassOptionsToPackage{paper=\l_keys_choice_tl}{typearea}
		\exp_args:Nx \PassOptionsToPackage{\l_keys_choice_tl paper}{geometry}
	},
	paper .initial:n = a4,
	IMRAD .bool_gset:N = \g_ptxcd_IMRAD_bool,
	IMRAD .initial:n = true,
	IMRAD .default:n = true,
	instbox .code:n = {\tl_gput_right:Nn \g_ptxcd_thesis_options_tl {,instbox=#1}},
	noinstbox .code:n = {\tl_gput_right:Nn \g_ptxcd_thesis_options_tl {,noinstbox=#1}},
	logofile .tl_gset:N = \g_ptxcd_logofile_tl,
	logofile .initial:n = tuda_logo,
	title .choice:,
	title / default .meta:n = {title=large},
	title / large .code:n = \bool_gset_false:N \g_ptxcd_smalltitle_bool,
	title / small  .code:n = \bool_gset_true:N \g_ptxcd_smalltitle_bool,
	title .initial:n = default,
	department .choice:,
	department / default .code:n = \str_gset:Nn \g_ptxcd_department_str {default},
	department / mecheng .code:n = {
		\str_gset:Nn \g_ptxcd_department_str {mecheng}
		\keys_set:nn {ptxcd/pub}{colorback=false,ruledheaders=section,departmentlogofile=tuda_maschinenbau_logo}
	},
	department .initial:n = default,
	department / unknown .code:n = {
		\str_gset:Nx \g_ptxcd_department_str {\l_keys_value_tl}
	},
	mecheng .meta:n = {department=mecheng},
	departmentlogofile .tl_gset:N = \g_ptxcd_departmentlogo_tl,
	departmentlogofile .initial:n =,
	BCORtitlepage .bool_gset:N = \g_ptxcd_BCOR_titlepage_bool,
	BCORtitlepage .initial:n = false,
	BCORtitlepage .default:n = true,
}
%
%%special option handling grouped values
\Module@DefineSpecialKey[ptxcd/pub]{thesis}{
	\keys_set:nn {ptxcd/pub}{type=thesis}
	\tl_gput_right:No \g_ptxcd_thesis_options_tl {#1}
}

\Module@Process@SpecialOptions[ptxcd/pub]

\ProcessKeysOptions{ptxcd/pub}


%Option adjustments required for valid PDF/A
\bool_if:NT  \g_ptxcd_pdfa_bool {
  \PassOptionsToPackage{RGB}{xcolor}
}

\exp_args:Nx \tl_if_eq:nnT {\prop_item:Nn \g_ptxcd_clsopts_prop {fontsize}} {9pt}
	{
	\prop_if_in:NnF \g_ptxcd_unknown_clsopts_prop {DIV}
		{\PassOptionsToPackage{DIV=calc}{typearea}}
	}

\prop_gput:Nnx \g_ptxcd_clsopts_prop {twocolumn} {
	\bool_if:NTF \g_ptxcd_twocolumn_bool {true} {false}
}

\prop_map_inline:Nn \g_ptxcd_clsopts_prop {
	\tl_if_empty:nTF {#2}
		{\PassOptionsToClass  {#1} {\g_ptxcd_pub_class_tl}}
		{
		\clist_map_inline:nn {#2} {\PassOptionsToClass  {#1=##1} {\g_ptxcd_pub_class_tl}}
		}
}


%Load tudasize clo file if available
\file_if_exist:nT {tudasize\prop_item:Nn \g_ptxcd_clsopts_prop {fontsize}.clo}
	{\providecommand*{\@fontsizefilebase}{tudasize}}

\LoadClass{\g_ptxcd_pub_class_tl}


\prop_map_inline:Nn \g_ptxcd_unknown_clsopts_prop {
	\cs_if_exist:cT {KV@KOMA.\g_ptxcd_pub_class_tl.cls@#1} {
	\tl_if_empty:nTF {#2}
		{\KOMAoptions{#1}}
		{\KOMAoption{#1}{#2}}
	}
}

%ruled headers
\int_compare:nT {\g_ptxcd_ruledheaders_int>=3} {
	\cs_if_exist:NT \chapterlinesformat {
		\renewcommand*{\chapterlinesformat}[3]{%
			\@hangfrom{#2}{#3}
			\smash{\raisebox{\depth}{\rule[\dp\strutbox]{\linewidth}{\g_ptxcd_titlerule_dim}}}
		}
	}
}
\int_compare:nT {\g_ptxcd_ruledheaders_int =4 }{
	\renewcommand*\sectionlinesformat[4]{%
		\tl_if_eq:nnTF {#1} {section}
		{
		\parbox{\linewidth}{
		\rule[5\g_ptxcd_titlerule_dim]{\linewidth}{\g_ptxcd_titlerule_dim}\par\nointerlineskip
		\@hangfrom{%
			\hskip #2#3\strut}{#4\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
		\skip_vertical:n {\ptxcd_titlerule_sep: -\dp\strutbox}
		\smash{\rule{\linewidth}{\g_ptxcd_titlerule_dim}}}
		}{
		\@hangfrom{\hskip #2#3}{#4}
		}
	}
}
\int_compare:nT {\g_ptxcd_ruledheaders_int>4} {
	\renewcommand*\sectionlinesformat[4]{%
	\parbox{\linewidth}{
		\rule[5\g_ptxcd_titlerule_dim]{\linewidth}{\g_ptxcd_titlerule_dim}\par\nointerlineskip
		\@hangfrom{%
			\hskip #2#3\strut}{#4\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
			\skip_vertical:n {\ptxcd_titlerule_sep: -\dp\strutbox}
		\smash{\rule{\linewidth}{\g_ptxcd_titlerule_dim}}
	}}
}


\usepackage{tudarules}


%,~ subsection,~
\usepackage{tudafonts}

%Margin & titlefontsize setup setup
\bool_new:N \g_ptxcd_marginpar_bool

\dim_new:N \g_ptxcd_marginpar_dim
\dim_new:N \g_ptxcd_innerMargin_dim
\dim_new:N \g_ptxcd_outerMargin_dim
\dim_new:N \g_ptxcd_bottomMargin_dim
\dim_new:N \g_ptxcd_topMargin_dim


	%a3,a4
	\int_compare:nTF {4<=\g_ptxcd_paper_int<=5}
	{
		\dim_gset:Nn \g_ptxcd_bottomMargin_dim {20mm}
		\dim_gset:Nn \g_ptxcd_outerMargin_dim {15mm}
		\dim_gset_eq:NN \g_ptxcd_innerMargin_dim \g_ptxcd_outerMargin_dim
		\dim_gset_eq:NN \g_ptxcd_topMargin_dim \g_ptxcd_outerMargin_dim
	}{
	%a0, a1, a2
		\int_compare:nT {1<=\g_ptxcd_paper_int<=3}
		{
			\dim_gset:Nn \g_ptxcd_bottomMargin_dim {35mm}
			\dim_gset:Nn \g_ptxcd_outerMargin_dim {30mm}
			\dim_gset_eq:NN \g_ptxcd_innerMargin_dim \g_ptxcd_outerMargin_dim
			\dim_gset_eq:NN \g_ptxcd_topMargin_dim \g_ptxcd_outerMargin_dim
		}
		%a5
		\int_compare:nT {\g_ptxcd_paper_int<=6}
		{
			\dim_gset:Nn \g_ptxcd_bottomMargin_dim {16mm}
			\dim_gset:Nn \g_ptxcd_outerMargin_dim {12mm}
			\dim_gset_eq:NN \g_ptxcd_innerMargin_dim \g_ptxcd_outerMargin_dim
			\dim_gset_eq:NN \g_ptxcd_topMargin_dim \g_ptxcd_outerMargin_dim
		}
		%a6
		\int_compare:nT {\g_ptxcd_paper_int<=7}
		{
			\dim_gset:Nn \g_ptxcd_bottomMargin_dim {15mm}
			\dim_gset:Nn \g_ptxcd_outerMargin_dim {10mm}
			\dim_gset_eq:NN	 \g_ptxcd_innerMargin_dim \g_ptxcd_outerMargin_dim
			\dim_gset_eq:NN \g_ptxcd_topMargin_dim \g_ptxcd_outerMargin_dim
		}
	}

\dim_new:N \g_ptxcd_columnSep_dim
\dim_gset:Nn \g_ptxcd_columnSep_dim {10pt}

%coverpage
\edef\coverpageleftmargin{\dim_eval:n {\g_ptxcd_outerMargin_dim}}
\renewcommand*{\coverpagetopmargin}{\g_ptxcd_outerMargin_dim}
\edef\coverpagerightmargin{\dim_eval:n {\g_ptxcd_outerMargin_dim}}
\renewcommand*{\coverpagebottommargin}{\g_ptxcd_outerMargin_dim}

\str_case:onTF {\g_ptxcd_marginpar_tl} {
	{true} {\bool_gset_true:N \g_ptxcd_marginpar_bool}
	{false} {\bool_gset_false:N \g_ptxcd_marginpar_bool}
	{auto} {\bool_gset_true:N \g_ptxcd_marginpar_bool}
} {
	\bool_if:NT  \g_ptxcd_marginpar_bool {
		\msg_new:nnnn {tudapub} {marginpar-auto} {Setting~up~marginpar~consistent~with~layout~guidelines.}
		{To~turn~this~off~use~marginpar=false~option.}
		\msg_info:nn {tudapub} {marginpar-auto}
		\dim_gset:Nn \g_ptxcd_marginpar_dim {(\paperwidth - \g_ptxcd_innerMargin_dim -\g_ptxcd_outerMargin_dim - 4  \g_ptxcd_columnSep_dim)/5}
	}
} {
	\msg_new:nnn {tudapub} {marginpar-no-key} {I~did~not~find~a~text~key~for~marginpar~setup~will~use~the~value~#1~as~width.}
	\msg_info:nnx {tudapub} {marginpar-no-key} {\g_ptxcd_marginpar_tl}
	\bool_gset_true:N \g_ptxcd_marginpar_bool
	\dim_gset:Nn \g_ptxcd_marginpar_dim {\g_ptxcd_marginpar_tl}
}


\dim_new:N \g_ptxcd_headheight_dim
\dim_new:N \g_ptxcd_headwidth_dim

\bool_if:NTF \g_ptxcd_headline_bool
	{\dim_gset:Nn \g_ptxcd_headheight_dim {20pt +\c_ptxcd_largerule_dim +\c_ptxcd_rulesep_dim +\c_ptxcd_smallrule_dim}}
	{\dim_gset:Nn \g_ptxcd_headheight_dim {1.25\baselineskip +\c_ptxcd_largerule_dim +\c_ptxcd_rulesep_dim +\c_ptxcd_smallrule_dim}}

%%%%%Anfang Randeinstellungen Geometry

%Has to be loaded here due to headwidth options
\usepackage[draft=false]{scrlayer-scrpage}

\bool_if:NTF  \g_ptxcd_geometry_bool {
	\RequirePackage{geometry}
	\geometry{
		top=\g_ptxcd_topMargin_dim,
		inner=\g_ptxcd_innerMargin_dim,
		outer=\dim_eval:n {\g_ptxcd_outerMargin_dim},
		bottom=\g_ptxcd_bottomMargin_dim,
		columnsep= \g_ptxcd_columnSep_dim,
		includehead,
		includefoot,
		includemp,
		nomarginpar,
		headheight=\g_ptxcd_headheight_dim
	}
	\savegeometry{TUDa-nomarginpar}
	\geometry{includemp, marginpar=\g_ptxcd_marginpar_dim, marginparsep=\g_ptxcd_columnSep_dim}
	\KOMAoptions{mpinclude}
	\savegeometry{TUDa-marginpar}

	\bool_if:NTF \g_ptxcd_custommargins_bool {
		\AtBeginDocument{\savegeometry{TUDa-default}}
		\tl_const:Nn \c_ptxcd_default_geometry_tl {TUDa-default}
	}{
		\bool_if:NTF  \g_ptxcd_marginpar_bool {
			\tl_const:Nn \c_ptxcd_default_geometry_tl {TUDa-marginpar}
		}  {
			\tl_const:Nn \c_ptxcd_default_geometry_tl {TUDa-nomarginpar}
		}
		\AtBeginDocument{
			\loadgeometry{\c_ptxcd_default_geometry_tl}
			\bool_if:NT \g_ptxcd_BCOR_titlepage_bool {\xdef\coverpageleftmargin{\the\dimexpr\coverpageleftmargin+\the\ta@bcor}}
		}
	}

	\dim_gset:Nn \g_ptxcd_headwidth_dim 			  {\paperwidth-\g_ptxcd_innerMargin_dim-\g_ptxcd_outerMargin_dim-\Gm@bindingoffset}

	\cs_set:Nn \ptxcd_disable_marginpar: {\loadgeometry{TUDa-nomarginpar}}
	\cs_set:Nn \ptxcd_restore_typearea: {\loadgeometry{\c_ptxcd_default_geometry_tl}}

}{
	\let\ptxcd_disable_marginpar:\relax
	\def\ptxcd_restore_typearea:{
		\KOMAoptions{headinclude, footinclude}
		\bool_if:NTF \g_ptxcd_marginpar_bool {\KOMAoptions{headwidth=textwithmarginpar,footwidth=textwithmarginpar}}
		{\KOMAoptions{headwidth=text,footwidth=text}}
		\bool_if:NT \g_ptxcd_headline_bool {\KOMAoptions{headheight=\g_ptxcd_headheight_dim}}
		\recalctypearea
	}
	\ptxcd_restore_typearea:
}



%%%%%%%%
%Ende Randeinstellungen klassisch




\newcommand*{\institution}[1]{
	\def\ptxcd_institution{#1}
}


\cs_new:Nn \ptxcd_titlerule_sep: {\the\dp\strutbox}

\usepackage{tudacolors}

\setkomafont{disposition}{\sffamily\bfseries}
\setkomafont{pageheadfoot}{\sffamily\small}
\setkomafont{pagenumber}{}
\addtokomafont{captionlabel}{\sffamily}
\addtokomafont{caption}{\sffamily}


\KOMAoptions{footsepline=.5\c_ptxcd_smallrule_dim}
\setlength{\footheight}{\dimexpr\baselineskip+\c_ptxcd_rulesep_dim}
\bool_if:NT \g_ptxcd_headline_bool {\KOMAoptions{headsepline=.5\c_ptxcd_smallrule_dim}}

%Adjust headheight
\AtBeginDocument{
\bool_if:NTF \g_ptxcd_marginpar_bool
	{
		\KOMAoptions {
			headwidth=textwithmarginpar,
			footwidth=textwithmarginpar
		}
	}{
		\KOMAoptions {
			headwidth=text,
			footwidth=text
		}
	}
\box_if_exist:NF \ptxcd_headrule_box {
	\ptxcd_makeheadrule[color=identbarcolor, width=\sls@headwidth]{ptxcd_headrule}
}
}

\newpairofpagestyles[scrheadings]{TUDa.headings}{
	\KOMAoptions{headsepline, headlines=1.25}
	\setkomafont{pagehead}{}
	\chead{}
	\ohead{\headmark}
}

\newpairofpagestyles{TUDa.pub}{
	\KOMAoptions{plainfootsepline}

	\bool_if:NTF \g_ptxcd_marginpar_bool
		{
		\KOMAoptions {
			headwidth=textwithmarginpar,
			footwidth=textwithmarginpar
			}
		}{
		\KOMAoptions {
			headwidth=text,
			footwidth=text
			}
		}
	\bool_if:NT \g_ptxcd_headline_bool {
		\setkomafont{pagehead}{\Large\bfseries}
		\KOMAoptions{headlines=2}
		\clist_map_variable:nNn {oneside, even, odd} \l_tmpa_tl {
			\ModifyLayer[pretocontents={\rule[-6pt]{0pt}{\layerheight}}]{TUDa.pub.head.\l_tmpa_tl}
		}
		\lehead{\headmark}
		\lohead{\headmark}
	}
	\ofoot[\pagemark]{\pagemark}
}

\RedeclareLayer[
	clone=scrheadings.head.above.line,
	background,
	contents={
	\dim_compare:nF {\box_wd:N \ptxcd_headrule_box=\layerwidth} {
		\ptxcd_makeheadrule[color=identbarcolor, width=\layerwidth]{ptxcd_headrule}
	}
	\smash{\ptxcd_headrule}
	}
]{TUDa.pub.head.above.line}

\RedeclareLayer[
	clone=plain.scrheadings.head.above.line,
	background,
	contents={
	\dim_compare:nF {\box_wd:N \ptxcd_headrule_box=\layerwidth} {
		\ptxcd_makeheadrule[color=identbarcolor, width=\layerwidth]{ptxcd_headrule}
	}
	\smash{\ptxcd_headrule}
	}
]{plain.TUDa.pub.head.above.line}

%\dim_set:Nn \l_tmpa_dim {\topmargin+1in+\headheight+\headsep+\textheight
%	+\footskip+\dp\strutbox-\footheight +\c_ptxcd_rulesep_dim}
\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{TUDa.pub.foot.even}
\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{TUDa.pub.foot.odd}
\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{TUDa.pub.foot.oneside}
\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{plain.TUDa.pub.foot.even}
\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{plain.TUDa.pub.foot.odd}
\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{plain.TUDa.pub.foot.oneside}


\DeclarePageStyleAlias{TUDa}{TUDa.pub}
\DeclarePageStyleAlias{plain.TUDa}{plain.TUDa.pub}
\pagestyle{TUDa}

\renewcommand*{\titlepagestyle}{plain.TUDa}
\cs_new:Nn \ptxcd_sls@leftmargin: {%
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
	\bool_if:NT \g_ptxcd_twocolumn_bool {
	-\marginparwidth-\marginparsep
	}
	+1in\relax
}



%Titelseite
\tl_new:N  \g_ptxcd_titleimage_code_tl
\tl_gset_eq:NN  \g_ptxcd_titleimage_code_tl \c_empty_tl
\newcommand{\titleimage}[1]{\tl_gset:Nn \g_ptxcd_titleimage_code_tl {#1}}

\box_new:N  \g_ptxcd_title_box
\skip_new:N \g_ptxcd_title_fill_skip




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

\msg_new:nnn{tudapub} {infobox-too-high} {
	The~height~of~your~Infobox~exeeds~the~space~reserved~in~the~title~block.\\
	You~should~probably~switch~to~logo=bottom~or~reduce~the~number/size~of~InfoBoxes.
}


\cs_set:Nn 	\ptxcd_adjust_titlepage_style: {
	\dim_set:Nn \l_tmpa_dim {\fp_to_dim:n {\expandafter \use_ii:nn\ptxcd_title_fontsize: *2.8}}
	\dim_compare:nT  {\box_ht:N \g_ptxcd_title_box < \l_tmpa_dim} {
		\skip_set:Nn \g_ptxcd_title_fill_skip {\dim_eval:n {\l_tmpa_dim -  \box_ht:N \g_ptxcd_title_box}}
	}

	\dim_set:Nn \l_tmpa_dim {
		\box_ht:N \ptxcd_headrule_box+\box_dp:N \ptxcd_headrule_box-\g_ptxcd_titlerule_dim
		+\box_ht:N \g_ptxcd_title_box+.5\c_ptxcd_logoheight_dim+\g_ptxcd_title_fill_skip+\box_dp:N \g_ptxcd_title_box
	}

	\ModifyLayer[
		addvoffset=\l_tmpa_dim,
		addheight=-\l_tmpa_dim
		-\box_dp:N \g_ptxcd_sponsor_box
		+\c_ptxcd_rulesep_dim
	]{title.TUDa.image}

	\bool_if:NT \g_ptxcd_colorbacktitle_bool {		
		\ModifyLayer[
			textarea,
			addvoffset=\dim_eval:n {\box_ht:N \ptxcd_headrule_box+\box_dp:N \ptxcd_headrule_box-\g_ptxcd_titlerule_dim},
			height={\box_ht:N \g_ptxcd_title_box+ \g_ptxcd_title_fill_skip+.5\c_ptxcd_logoheight_dim
			\bool_if:NT \g_ptxcd_colorbacksubtitle_bool {+\box_dp:N \g_ptxcd_title_box}
		}
			]{title.TUDa.background}
	}
	\vspace*{\dim_eval:n {
		-\topskip
		-\g_ptxcd_titlerule_dim
		+\box_ht:N \ptxcd_headrule_box
		+\box_dp:N \ptxcd_headrule_box
		+.5\c_ptxcd_logoheight_dim
	}}
	\nointerlineskip
	\ptxcd_setup_title_box:

	\bool_if:NT \g__ptxcd_LogoInHead_bool {
		\dim_compare:nT {\box_ht:N \g_ptxcd_title_info_box+ \box_dp:N \g_ptxcd_title_info_box  > \box_ht:N \g_ptxcd_title_box}
			{\msg_warning:nn{tudapub} {infobox-too-high}}
		\makebox[\linewidth][r]{\smash{
				\raisebox{-\height}{
					\makebox[2.2\c_ptxcd_logoheight_dim][l]{
						\box_use:N \g_ptxcd_title_info_box
				}}
		}}
	}
	\par
	\vspace*{\skip_use:N \g_ptxcd_title_fill_skip}
	\setlength{\fboxsep}{\z@}
}


\newkomafont{institution}{\sffamily}
\newkomafont{titleinfo}{\sffamily}
\setkomafont{subtitle}{\bfseries}
\setkomafont{subject}{}
\setkomafont{publishers}{}
\setkomafont{author}{}
\setkomafont{date}{}

\bool_if:NF \g_ptxcd_smalltitle_bool {
	\int_gdecr:N \g_ptxcd_paper_int
}
\file_input:n {tuda-a\int_use:N \g_ptxcd_paper_int paper.clo}
\ptxcd_setup_title_sizes:

\seq_new:N \g_ptxcd_title_info_seq
\box_new:N \g_ptxcd_title_info_box

\cs_new:Nn \ptxcd_make_title_info_box:n {
	\setlength{\fboxsep}{1.5mm}%
	\colorbox{InfoBox}{
	\makebox[\dim_eval:n {2.2\c_ptxcd_logoheight_dim-\fboxsep}][r]{
		\parbox{2\c_ptxcd_logoheight_dim}{
		\expandafter\fontsize\ptxcd_titlethanks_fontsize:\selectfont\usekomafont{institution}%
		\raggedright%
	#1
	}}}
}

\cs_new:Nn \ptxcd_make_title_logo_box:n {
	\setlength{\fboxsep}{\z@}%
	\parbox{2.2\c_ptxcd_logoheight_dim}{
		\colorbox{InfoBox}{
			\rlap{
			\makebox[2.5\c_ptxcd_logoheight_dim][r]{
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

\DeclareNewLayer[textarea,background,mode=picture,
	contents={
		\tl_if_empty:NTF \g_ptxcd_titleimage_code_tl
		{
			\bool_if:NF \g_ptxcd_colorbacktitle_bool
			{ 
				\bool_if:NT \g_ptxcd_colorback_bool {\putLL{\color{identbarcolor}\rule{\layerwidth}{\layerheight}}}
			}
		}
		{\putUL{\color{identbarcolor}
				\let\width\layerwidth
				\let\height\layerheight
				\raisebox{-\height}{\parbox[t]{\textwidth}{
					\leavevmode\ignorespaces
					\g_ptxcd_titleimage_code_tl
					}}}}
		\bool_if:NF \g__ptxcd_LogoInHead_bool {
			\put(\dim_to_decimal_in_unit:nn {\layerwidth-2.2\c_ptxcd_logoheight_dim
			} {\unitlength},
			\dim_to_decimal_in_unit:nn {\layerheight-\box_ht:N \g_ptxcd_title_info_box - .5\c_ptxcd_logoheight_dim} {\unitlength}){
				\rlap{\box_use:N \g_ptxcd_title_info_box}
			}
		}
	}
]{title.TUDa.image}

\DeclareNewLayer[background,mode=picture,
	contents={
		\bool_lazy_and:nnT {\g_ptxcd_colorback_bool} {\g_ptxcd_colorbacktitle_bool} {
			{\color{identbarcolor}\rule{\layerwidth}{\layerheight}}
		}
	}
]{title.TUDa.background}

\DeclareNewLayer[
	clone=plain.TUDa.pub.head.above.line,
	hoffset=\coverpageleftmargin,
	width=\paperwidth-\coverpageleftmargin-\coverpagerightmargin,
]{title.TUDa.rule}



\ptxcd_makeheadrule[color=identbarcolor, width=\textwidth]{ptxcd_title_headline}

\cs_new:Nn \ptxcd_setup_title_box: {
	\hbox_gset:Nn \g_ptxcd_title_info_box
	{
		\parbox{\dimexpr2.5\c_ptxcd_logoheight_dim}{
		\seq_use:Nn \g_ptxcd_title_info_seq  {\par\nointerlineskip\vspace{\dim_eval:n {\c_ptxcd_largerule_dim+\c_ptxcd_rulesep_dim}}}
		}
	}
}

\cs_new:Nn \ptxcd_setup_sponsor_box: {
	\bool_if:nF {\seq_if_empty_p:N \g_ptxcd_sponsors_seq &&  \tl_if_empty_p:N \@sponsors} {
		\hbox_gset:Nn \g_ptxcd_sponsor_box {
			\def\height{\dimexpr.8\c_ptxcd_logoheight_dim\relax}
			\parbox[t]{\textwidth}{
				\rule{\linewidth}{\g_ptxcd_titlerule_dim}\par\nointerlineskip
				\addvspace{\c_ptxcd_rulesep_dim}
				\seq_use:Nn \g_ptxcd_sponsors_seq {\hfill}
				\ifhmode\par\fi
				\ifx\@sponsors\@empty
				\else
					\addvspace{.1\c_ptxcd_logoheight_dim}
					\@sponsors\par
				\fi
				\par\nointerlineskip\addvspace{\c_ptxcd_rulesep_dim}
				\rule{\linewidth}{\g_ptxcd_titlerule_dim}
			}
		}
	}
}

\DeclareNewPageStyleByLayers{title.TUDa}{title.TUDa.background,title.TUDa.rule,title.TUDa.image}

%Logos
\RequirePackage{graphicx}

\if_bool:N \g_ptxcd_pdfa_bool

	\msg_new:nnn{tudapub} {prefer-lualatex} {
	You~use~pdfa-mode~in~#1.\\
	This~can~lead~to~incompatiblities~especially~with~older~compiler~versions.\\
	You~should~prefer~using~lualatex.
	}
	%only apply the hack if pdfx is older than the working version
	\@ifpackagelater{pdfx}{2021/07/06}{
		\PassOptionsToPackage{a-2b}{pdfx}
		\RequirePackage{pdfx}
	} {
		\msg_new:nnnn{tudapub} {dirty-hack-pdfa} {
			I~have~to~use~a~dirty~hack~to~workaround~some~incompatibilites~between~your~LaTeX~version~and~the~pdfa-mode.\\
			Please~use~pdfa=true~only~if~you~really~need~it.\\
			We~will~remove~this~hack~as~soon~as~all~incompatibilities~have~been~patched.
		} {
			See~the~corresponding~GitHub~Issue~for~more~information:~https://github.com/tudace/tuda_latex_templates/issues/321
		}
		\msg_warning:nn {tudapub} {dirty-hack-pdfa}
		%check if \par is expanable and add a dirty hack
		%Thanks to Ross Moore for the support
		\expandafter\ifx\csname tex_par:D\endcsname \relax
			\let\pdfx@par\par
		\else
			\expandafter\let\expandafter\pdfx@par\csname tex_par:D\endcsname
		\fi
		\let\orig@par\par
		\let\par\pdfx@par
		\PassOptionsToPackage{a-2b}{pdfx}
		\RequirePackage{pdfx}
		%restore\par
		\let\par\orig@par
	}

	\sys_if_engine_pdftex:T {
		\msg_warning:nnn{tudapub} {prefer-lualatex} {PDFTeX}
	}

	\sys_if_engine_pdftex:T {
		\msg_warning:nnn{tudapub} {prefer-lualatex} {XeTeX}
	}



	\@ifpackagelater{pdfx}{2018/12/01}{
	}{
		\msg_new:nnnn{tudapub} {outdated-pdfx} {
			Your~Version~of~the~PDFx-package~is~too~old~to~support~all~methods~required~by~tudapubs~pdfa-mode.\\
			Either~update~your~TeX-distribution~or~switch~to~pdfa=false.
		}{See~DEMO-tudapub~for~further~information.}
		\msg_error:nn{tudapub} {outdated-pdfx}
	}


	%%hyperref
	\hypersetup{hidelinks, unicode}
	\iow_new:N \ptxcd_xmpdata_stream
	\tl_new:N \g_ptxcd_xmp_title_tl
	\tl_new:N \g_ptxcd_xmp_author_tl

	\cs_if_exist:NF \prop_gput_if_new:Nnx {
	\cs_generate_variant:Nn \prop_gput_if_new:Nnn {Nnx}
	}

	\cs_if_exist:NF \tl_to_str:V {\cs_generate_variant:Nn \tl_to_str:N {V}}

	\cs_new:Nn \ptxcd_pass_TitleData: {
		\iow_open:Nn \ptxcd_xmpdata_stream {\jobname.xmpdata}
		\begingroup
		\def\newline{}
		\def\\{}
		\let\thanks\use_none:n
		\cs_set:Npn \and {\exp_not:n {\exp_not:N \sep}}
		\use:c {Hy@pdfstringtrue}
		\tl_gset:Nf \g_ptxcd_xmp_title_tl {\@title}
		\prop_gput_if_new:Nnx \g_ptxcd_MetaData_prop {title} {\tl_to_str:V \g_ptxcd_xmp_title_tl}
		\prop_if_in:NnF \g_ptxcd_MetaData_prop {author} {
			\tl_gset:Nx \g_ptxcd_xmp_author_tl {\seq_use:Nn \g_ptxcd_author_seq {\exp_not:N \sep}}
			\tl_gset:Nx \g_ptxcd_xmp_author_tl {\g_ptxcd_xmp_author_tl}
			\prop_gput:Nnx \g_ptxcd_MetaData_prop {author} {\tl_to_str:V \g_ptxcd_xmp_author_tl}
		}
		\prop_gput_if_new:Nnn \g_ptxcd_MetaData_prop {publisher}{TU~Darmstadt}
		\prop_gput_if_new:Nnn \g_ptxcd_MetaData_prop {creator}{LaTeX~using~TUDa-CI}
		\use:c {pdfx@localcommands}%should be held inside group
		\prop_map_function:NN \g_ptxcd_MetaData_prop  \ptxcd_write_xmp_line:nn
	\endgroup
	\iow_close:N \ptxcd_xmpdata_stream
		\let\ptxcd_pass_TitleData:\relax
	}
	\cs_new:Nn \ptxcd_write_xmp_line:nn {
		\begingroup
		\cs_set:Npn \sep {\exp_not:N \sep}
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
		\endgroup
	}

\prop_new:N \g_ptxcd_MetaData_prop

	\newcommand*{\Metadata}[1]{
		\keyval_parse:NNn  \use_none:n \ptxcd_set_metadata_prop:nn
		{#1}
	}

	\cs_set:Nn \ptxcd_set_metadata_prop:nn {
	\exp_args:NNf \prop_gput:Nnn \g_ptxcd_MetaData_prop {\tl_lower_case:n{#1}}  {#2}
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
	\RequirePackage[hidelinks, unicode]{hyperref}

	\newcommand{\Metadata}[1]{\ClassError{tudapub}{You~cannot~use~\string\Metadata\ ~with~pdfa=false.}{}}
\fi:

\box_new:N  \g_ptxcd_sponsor_box
\seq_new:N \g_ptxcd_sponsors_seq
\def\AddSponsor{\seq_gput_right:Nn \g_ptxcd_sponsors_seq}
\def\sponsors#1{\def\@sponsors{#1}}
\sponsors{}

\newcommand*{\ptxcd_title@footnote}[2][1]{
	\textsuperscript{\@fnsymbol{#1}}#2
}

\str_if_eq:VnTF \g_ptxcd_pubType_tl  {thesis} {
	\input{tudathesis.cfg}
} {

\msg_new:nnnn {tudapub} {only-thesis} {You~tried~to~use~\use:c { #1}.~This~macro~is~only~available~for~publications~of~type~thesis}{See~tuda-ci~documentation~for~further~information}

\clist_map_inline:nn {birthplace, group, examdate, submissiondate, tuprints, urn, reviewer} {
	\expandafter\newcommand\csname #1\endcsname[2][]{
		\msg_error:nnn {tudapub} {only-thesis} {#1}
	}
}

% The following macro is an adapted version of the corresponding KOMA-Script macro
% Copyright (c) 1994-2019 Markus Kohm [komascript at gmx info]
\renewcommand*{\maketitle}[1][1]{
	\def\and{,~ }
	\cs_if_exist_use:N \ptxcd_pass_TitleData:
	\if@titlepage
	\ptxcd_disable_marginpar:
	\begin{titlepage}
		\setcounter{page}{%
			#1%
		}%
		\def\thefootnote{\fnsymbol{footnote}}
		\if@titlepageiscoverpage
		\def\titlepage@restore{%
			\endgroup
			\ptxcd_restore_typearea:
			\bool_if:nT {! \g_ptxcd_geometry_bool && \g_ptxcd_marginpar_bool} {
				\dim_sub:Nn \evensidemargin {\marginparwidth+\marginparsep}
				\dim_add:Nn \textwidth   {\marginparwidth+\marginparsep}
				\columnwidth=\textwidth
				\hsize=\columnwidth
			}
			\global\@titlepageiscoverpagefalse
			\let\titlepage@restore\relax
		}%
		\begingroup
		\topmargin=\dimexpr \coverpagetopmargin-1in\relax
		\oddsidemargin=\dimexpr \coverpageleftmargin-1in\relax
		\evensidemargin=\dimexpr \coverpageleftmargin-1in\relax
		\textwidth=\dimexpr
		\paperwidth-\coverpageleftmargin-\coverpagerightmargin\relax
		\textheight=\dimexpr
		\paperheight-\coverpagetopmargin-\coverpagebottommargin\relax
		\headheight=0pt
		\headsep=0pt
		\footskip=\baselineskip
		\@colht=\textheight
		\@colroom=\textheight
		\vsize=\textheight
		\columnwidth=\textwidth
		\hsize=\columnwidth
		\linewidth=\hsize
		\else
		\let\titlepage@restore\relax
		\fi
		\setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
		\ptxcd_setup_sponsor_box:
		\hbox_gset:Nn \g_ptxcd_title_box {
			\parbox[t]{\linewidth}{
				\begin{minipage}[b]{\bool_if:NT \g__ptxcd_LogoInHead_bool {.75}\linewidth}
					\bool_lazy_and:nnT {\g_ptxcd_colorback_bool} {\g_ptxcd_colorbacktitle_bool} {\color{textonaccentcolor}}
					\tl_if_empty:NF \@titlehead {
						\begin{addmargin}{3mm}
							{\usekomafont{titlehead}{\@titlehead\par}}
						\end{addmargin}
					}
					\begin{addmargin}[\dim_eval:n {\box_if_empty:NF \g_ptxcd_PaperID_box {\box_wd:N\g_ptxcd_PaperID_box+.5\c_ptxcd_logoheight_dim} +3mm}]{3mm}
						\raggedright
						\leavevmode\usekomafont{title}%
						\expandafter\fontsize\ptxcd_title_fontsize:
						\selectfont
						\llap{\raisebox{\dimexpr-\height+.5\baselineskip}[0pt][0pt]{\box_use:N \g_ptxcd_PaperID_box}\hspace{.5\c_ptxcd_logoheight_dim}}
						\@title\strut
						\par
						\box_if_empty:NTF \g_ptxcd_PaperID_box
						{\vskip0pt}
						{\rule{0pt}{.5\c_ptxcd_logoheight_dim}}
					\end{addmargin}
				\end{minipage}%
				\bool_if:NT \g_ptxcd_colorbacksubtitle_bool {\color{textonaccentcolor}}
				\par\nointerlineskip
				\rule{\linewidth}{\g_ptxcd_titlerule_dim}\par\vspace{\c_ptxcd_rulesep_dim}
				\begin{addmargin}{3mm}
					\usekomafont{titleinfo}
					\expandafter\fontsize\ptxcd_titleinfo_fontsize:
					\selectfont
					{\ifx\@subtitle\@empty\else\usekomafont{subtitle}{\@subtitle\par}\fi}%
					{\ifx\@subject\@empty\else\usekomafont{subject}{\@subject\par}\fi}
					{%
						\usekomafont{author}
						\lineskip 0.75em
						\@author
						\par
					}%
					{\ifx\@date\@empty\else\usekomafont{date}{\@date\par}\fi}%
					{\ifx\@publishers\@empty\else\usekomafont{publishers}{\@publishers \par}\fi}%
				\end{addmargin}
				\tl_if_empty:NF \@thanks {
					\expandafter\fontsize\ptxcd_titlethanks_fontsize:\selectfont\par
					\rule{\linewidth}{\g_ptxcd_titlerule_dim}\par
					\begin{addmargin}{3mm}
						\let\footnotetext\ptxcd_title@footnote
						\@thanks
					\end{addmargin}
					\par\vspace{-\dp\strutbox}
				}
				\normalcolor
				\rule{\linewidth}{\g_ptxcd_titlerule_dim}\par}
		}
		\let\@thanks\@empty
		\ptxcd_adjust_titlepage_style:
		\thispagestyle{title.TUDa}
		\nointerlineskip\box_use:N \g_ptxcd_title_box
		\par
		\vfill
		\box_if_empty:NTF \g_ptxcd_sponsor_box {
			\raisebox{-\c_ptxcd_rulesep_dim}[0pt][0pt]{\rule{\linewidth}{\g_ptxcd_titlerule_dim}}
		}{
			\box_use:N \g_ptxcd_sponsor_box
		}
		\if@twoside
		\@tempswatrue
		\expandafter\ifnum \@nameuse{scr@v@3.12}>\scr@compatibility\relax
		\else
		\ifx\@uppertitleback\@empty\ifx\@lowertitleback\@empty
		\@tempswafalse
		\fi\fi
		\fi
		\if@tempswa
		\next@tpage
		\begin{minipage}[t]{\textwidth}
			\@uppertitleback
		\end{minipage}\par
		\vfill
		\begin{minipage}[b]{\textwidth}
			\@lowertitleback
		\end{minipage}\par
		\@thanks\let\@thanks\@empty
		\fi
		\fi
		\ifx\@dedication\@empty
		\else
		\next@tdpage\null\vfill
		{\centering\usekomafont{dedication}{\@dedication \par}}%
		\vskip \z@ \@plus3fill
		\@thanks\let\@thanks\@empty
		\cleardoubleemptypage
		\fi
		\ifx\titlepage@restore\relax\else\clearpage\titlepage@restore\fi
	\end{titlepage}
	\setcounter{footnote}{0}%
	\global\let\and\relax
	\cleardoublepage
	\ptxcd_restore_typearea:
	\aftergroup\ptxcd_restore_typearea:
	\else
	\par
	\@tempcnta=%
	#1%
	\relax\ifnum\@tempcnta=1\else
	\ClassWarning{\KOMAClassName}{%
		Optional argument of \string\maketitle\space ignored\MessageBreak
		in `titlepage=false' mode%
	}%
	\fi
	\ifx\@uppertitleback\@empty\else
	\ClassWarning{\KOMAClassName}{%
		non empty \string\uppertitleback\space ignored
		by \string\maketitle\MessageBreak
		in `titlepage=false' mode%
	}%
	\fi
	\ifx\@lowertitleback\@empty\else
	\ClassWarning{\KOMAClassName}{%
		non empty \string\lowertitleback\space ignored
		by \string\maketitle\MessageBreak
		in `titlepage=false' mode%
	}%
	\fi
	\begingroup
	\let\titlepage@restore\relax
	\def\thefootnote{\fnsymbol{footnote}}
	\next@tdpage
	\ifx\@extratitle\@empty
		\ifx\@frontispiece\@empty\else \mbox{}\fi
	\else
	\@makeextratitle
	\fi
	\ifx\@frontispiece\@empty
	\ifx\@extratitle\@empty\else\next@tdpage\fi
	\else
	\next@tpage
	\@makefrontispiece
	\next@tdpage
	\fi
	\if@twocolumn
	\twocolumn[\@maketitle]
	\else
	\@maketitle
	\fi
	\ifx\titlepagestyle\@empty\else\thispagestyle{\titlepagestyle}\fi
	\global\let\@thanks\@empty
	\endgroup
	\fi
}
}

\newkomafont{paperid}{\sffamily}
\box_new:N \g_ptxcd_PaperID_box
\newcommand*{\SetPaperID}[2]{
	\hbox_gset:Nn \g_ptxcd_PaperID_box {
		\usekomafont{paperid}
		\if@titlepage
		\dim_set:Nn \l_tmpa_dim {\exp_last_unbraced:No \use_i:nn \ptxcd_title_fontsize: + \exp_last_unbraced:No \use_ii:nn \ptxcd_title_fontsize:}
		\else
		\Huge
		\dim_set:Nn \l_tmpa_dim {1.8\baselineskip}
		\fi
		\fontsize{1.1\l_tmpa_dim}{1.1\l_tmpa_dim}
		\selectfont
		#1{\Huge #2}
	}
}

\renewcommand*{\@maketitle}{%
	\global\@topnum=\z@
	\setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
	\vspace*{-\dim_eval:n {
			\headheight
			+\headsep
			+\topskip
			-\box_ht:N\ptxcd_headrule_box
			-\box_dp:N \ptxcd_headrule_box
	}}
	\par
	\nointerlineskip
	\begingroup
	\usekomafont{disposition}
	\hsize=\g_ptxcd_headwidth_dim
	\setlength{\fboxsep}{\z@}
	\bool_if:NT \g_ptxcd_colorback_bool {\bool_set_true:N \g_ptxcd_colorbacktitle_bool}
	\bool_if:NT \g_ptxcd_colorbacktitle_bool {\colorbox{identbarcolor}}
	{\parbox[t]{\g_ptxcd_headwidth_dim}{
			\rule{\z@}{.5\c_ptxcd_logoheight_dim}\par\nointerlineskip
			\raisebox{-\height}{%
				\begin{minipage}[t]{\dimexpr\linewidth-2.2\c_ptxcd_logoheight_dim-1ex}
					\bool_if:NT \g_ptxcd_colorbacktitle_bool  {\begin{addmargin}{.5\c_ptxcd_largerule_dim}}
						\raggedright
						\bool_if:NT \g_ptxcd_colorback_bool {\color{textonaccentcolor}}
						\tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
						\box_if_empty:NF \g_ptxcd_PaperID_box  {\begin{addmargin}[\dim_eval:n {\box_wd:N\g_ptxcd_PaperID_box+.5\c_ptxcd_logoheight_dim}]{0pt}}
							\raggedright
							\bool_if:NT \g_ptxcd_colorback_bool {\color{textonaccentcolor}}
							\tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
							\leavevmode\usekomafont{title}%
							\Huge
							\llap{\raisebox{\dimexpr-\height+.5\baselineskip}[0pt][0pt]{\box_use:N \g_ptxcd_PaperID_box}\hspace{.5\c_ptxcd_logoheight_dim}}
							\@title\strut
							\par
							\box_if_empty:NTF \g_ptxcd_PaperID_box
							{\vskip1em}
							{\rule{0pt}{.5\c_ptxcd_logoheight_dim}}
						\box_if_empty:NF \g_ptxcd_PaperID_box {\end{addmargin}}
					\bool_if:NTF \g_ptxcd_colorbacktitle_bool {\end{addmargin}} {\par}
			\vspace{\dim_eval:n {\c_ptxcd_largerule_dim+\c_ptxcd_rulesep_dim}}
			\end{minipage}
		}
		\hfill
		\raisebox{-\height}{
		\ptxcd_setup_title_box:
		\makebox[2.2\c_ptxcd_logoheight_dim][l]{
		\box_use:N \g_ptxcd_title_info_box
		}
		}
		\dim_compare:nNnTF {\box_ht:N \g_ptxcd_title_info_box + \box_ht:N \g_ptxcd_title_info_box} > {1.1\c_ptxcd_logoheight_dim}
				{\vspace{\c_ptxcd_largerule_dim}}
				{\vspace{.5\c_ptxcd_logoheight_dim}}

		\par
	}}
	\par
	\nointerlineskip
	\rule{\g_ptxcd_headwidth_dim}{\g_ptxcd_titlerule_dim}
	\begin{addmargin}{.5\c_ptxcd_largerule_dim}
	\Large
	\clist_map_inline:nn {subtitle, subject, author, date, publishers}
		{\tl_if_empty:cF {@##1} {{\usekomafont{##1}\use:c {@##1}\par}}}
	\vspace{\c_ptxcd_rulesep_dim}
	\end{addmargin}
	\tl_if_empty:NF \@thanks {
	\par\nointerlineskip
	\rule{\g_ptxcd_headwidth_dim}{\g_ptxcd_titlerule_dim}
	\expandafter\fontsize\ptxcd_titlethanks_fontsize:\selectfont
	\begin{addmargin}{.5\c_ptxcd_largerule_dim}
		\let\footnotetext\ptxcd_title@footnote
		\@thanks
		\vspace{\c_ptxcd_rulesep_dim}
	\end{addmargin}
	\par
	\let\@thanks\@empty
	}
	\par\nointerlineskip
		\rule{\g_ptxcd_headwidth_dim}{\g_ptxcd_titlerule_dim}
	\par
	\endgroup
	\vskip .5\c_ptxcd_logoheight_dim
}%

%%Abstract anpassungen mit Sprache
\providecommand{\abstract}{}% für book
\RenewDocumentEnvironment{abstract}{o}{
	\begingroup
	\IfNoValueF{#1}{\selectlanguage{#1}}
	\bool_set_true:N \l_tmpa_bool
	\cs_if_exist:NT \if@abstrt {
		\if@abstrt
		\else
		\bool_set_false:NT \l_tmpa_bool
		\fi
	}
	\bool_if:NT \l_tmpa_bool {
		\scr@ifundefinedorrelax{chapter}{%
			\Iftocfeature{toc}{leveldown}
			{\subsection*}
			{\section*}
		}{
			\Iftocfeature{toc}{leveldown}
			{\section*}
			{\chapter*}
		} {\abstractname}

}}{
	\endgroup
}


%Anpassungen marginpar
\cs_set_eq:NN\ptxcd_orig@marginpar:\marginpar
\newkomafont{marginpar}{\accentfont\color{textaccentcolor}}
\RenewDocumentCommand{\marginpar}{om}{
	\IfNoValueTF{#1}{
		\ptxcd_orig@marginpar:{\leavevmode\usekomafont{marginpar}#2}
	}{
		\ptxcd_orig@marginpar:[\leavevmode\usekomafont{marginpar}#1]{\leavevmode\usekomafont{marginpar}#2}
	}
}

\ptxcd_declare_caption:Nnn \authorandname {und} {and}
\ptxcd_declare_caption:Nnn \ptxcd_datename {Datum}{Date}

\gdef\ptxcd_dateseparator{:~}


\providecommand*{\frontmatter}{
	\if@twoside\cleardoublepage\else\clearpage\fi \@mainmattertrue
	\pagenumbering {roman}
}

\providecommand*{\mainmatter}{
	\if@twoside\cleardoublepage\else\clearpage\fi \@mainmattertrue
	\pagenumbering {arabic}
}

\providecommand*{\backmatter}{
	\if@twoside\cleardoublepage\else\clearpage\fi \@mainmatterfalse
}


%IMRAD:Introduction
\seq_if_exist:NTF \seq_const_from_clist:Nn {
	\seq_const_from_clist:Nn \c_ptxcd_IMRAD_seq {introduction, methods, results, discussion}
} {
	\seq_new:N \c_ptxcd_IMRAD_seq
	\seq_gset_from_clist:Nn \c_ptxcd_IMRAD_seq {introduction, methods, results, discussion}
}

\newcommand*{\IMRADlabel}[1]{
	\seq_if_in:NnTF \c_ptxcd_IMRAD_seq  {#1}
		{\label{IMRAD:#1}}
		{\msg_error:nnnn {tudapub} {undefined-IMRADlabel}{#1}{\seq_use:Nn \c_ptxcd_IMRAD_seq {,}}}
}


\bool_if:NT \g_ptxcd_IMRAD_bool {
	\AtEndDocument{
		\seq_map_inline:Nn \c_ptxcd_IMRAD_seq {
			\cs_if_exist:cF {r@IMRAD:#1} {
			\msg_warning:nnn {tudapub} {missing-IMRADlabel} {#1}
			}
	 	}
	}
}

\msg_new:nnn {tudapub} {undefined-IMRADlabel} {
	You~tried~to~set~an~IMRAD~label~with~key~#1.\\
	This~label~type~is~not~declared.\\
	Possible~labels~are:~#2
}


\msg_new:nnn{tudapub} {missing-IMRADlabel} {
	You~did~not~provide~a~Label~for~key~#1.\\
	Either~you~need~to~recompile~your~document~or~add~a~label~using~\string\IMRADlabel.
}

%backwards compatibility for KOMA-Script
\cs_if_exist:NF \Iftocfeature{
	\let\Iftocfeature\iftocfeature
}

\file_if_exist_input:n {tuda\g_ptxcd_department_str.cfg}
\endinput
%End of class tudapub.cls
