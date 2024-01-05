%% This is file `tudaexercise.cls' version 3.36 (2024-01-05),
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

\ProvidesExplClass{tudaexercise}
	{\filedate}{\fileversion}{Exercise sheets and exams using TU Darmstadt's Corporate Desing (TUDa-CI)}

\msg_new:nnnn {tudaexercise} {outdated-koma-script} {
  Your~KOMA-Script~is~outdated.\\
  To~use~the~feature~'#1'~you~will~be~required~to~update.
} {
  Please~do~not~use~this~feature~or~update~your~TeX~distribution.\\
  The~feature~requires~KOMA-Script~v#2~or~newer.
}

\str_const:Nn \c__ptxcd_base_str {exercise}
\prop_new:N \g_ptxcd_clsopts_prop
\prop_new:N \g_ptxcd_unknown_clsopts_prop
\prop_gput:Nnn \g_ptxcd_clsopts_prop {captions} {nooneline}
\prop_gput:Nnn \g_ptxcd_clsopts_prop {parskip} {half-}

\prop_new:N \g__ptxcd_points_collector_prop
\prop_new:N \g__ptxcd_subtask_points_collector_prop
\bool_new:N \l__ptxcd_points_auto_bool
\bool_new:N \g__ptxcd_points_bool
\prop_new:N \g__ptxcd_loaded_points_prop
\fp_new:N \g__ptxcd_points_total_fp

\int_new:N \g_ptxcd_paper_int

\bool_new:N \g_ptxcd_geometry_bool
\bool_new:N \g_ptxcd_custommargins_bool
\bool_new:N \l_ptxcd_ex_solution_bool

\bool_new:N \g_ptxcd_smalltitle_bool
\str_new:N \g_ptxcd_department_str

\tl_new:N \g_ptxcd_tmp_tl
\int_new:N \g_ptxcd_tmp_int
\tl_new:N \l_ptxcd_tmp_tl

\clist_map_inline:nn {section,subsection,subsubsection,task,subtask,@solution} {
	\bool_new:c	{g__ptxcd_ruled_#1_bool}
	\bool_gset_true:c {g__ptxcd_ruled_#1_bool}
}

\bool_new:N \g__ptxcd_runin_subtask_bool

\RequirePackage{environ}

\newenvironment{solution}{}{}
\newenvironment{solution*}{}{}

\cs_new:Nn \ptxcd_setup_solution: {
	\bool_if:NTF \l_ptxcd_ex_solution_bool {
		\def\solution{\ptxcd_ex_solutionheader:}
		\def\endsolution{}
		\expandafter\def\csname solution*\endcsname{\ignorespaces}
		\expandafter\let\csname endsolution*\endcsname\endsolution
	}{
		\RenewEnviron{solution}{
			\if_false:
			\BODY
			\fi:
		}
		\RenewEnviron{solution*}{
			\if_false:
			\BODY
			\fi:
		}
	}
}

\ptxcd_setup_solution:

\prg_new_conditional:Nnn \__ptxcd_if_solution: {T,F,TF} {
	\bool_if:NTF \l_ptxcd_ex_solution_bool
	{\prg_return_true:}
	{\prg_return_false:}
}

\let\IfSolutionT \__ptxcd_if_solution:T
\let\IfSolutionF \__ptxcd_if_solution:F
\let\IfSolutionTF \__ptxcd_if_solution:TF


%Message Declaration for option processing
\msg_new:nnn{tudaexercise} {titlepage-option-disabled} {
	You~set~the~titlepage~option~to~#1.\\
	This option is not supported by tudaexercise.cls.\\
	The~KOMA-Script~option~titlepage~is~forced~to~"false".
}

\keys_define:nn {ptxcd/exercise} {
	color .code:n = {\PassOptionsToPackage{color=#1}{tudacolors}},
	accentcolor .code:n = {\PassOptionsToPackage{accentcolor=#1}{tudacolors}},
	textaccentcolor .code:n = {\PassOptionsToPackage{textaccentcolor=#1}{tudacolors}},
	textonaccentcolor .code:n = {\PassOptionsToPackage{textaccentcolor=#1}{tudacolors}},
	identbarcolor .code:n = {\PassOptionsToPackage{identbarcolor=#1}{tudacolors}},
	color .initial:n = 0b,
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
	fontsize .initial:n = {10pt},
	BCOR .code:n = \PassOptionsToPackage{bindingoffset=#1}{geometry},
	bindingoffset .meta:n = {BCOR=#1},
	captions .code:n = {\prop_gput:Nnx \g_ptxcd_clsopts_prop {captions} {
		\use:n {\prop_item:Nn \g_ptxcd_clsopts_prop {captions}}, #1}
	},
	titlepage .code:n = {\msg_warning:nnn {tudapub} {titlepage-option-disabled} {#1}},
	paper .choices:nn = {a0,a1,a2,a3,a4,a5,a6}{
		\int_gset_eq:NN \g_ptxcd_paper_int  \l_keys_choice_int
		\exp_args:Nx \PassOptionsToPackage{paper=\l_keys_choice_tl}{tudarules}
		\exp_args:Nx \PassOptionsToPackage{paper=\l_keys_choice_tl}{typearea}
		\exp_args:Nx \PassOptionsToPackage{\l_keys_choice_tl paper}{geometry}
	},
	paper .initial:n = a4,
	logofile .tl_gset:N = \g_ptxcd_logofile_tl,
	logofile .initial:n = tuda_logo,
	compat .bool_gset:N = \g_ptxcd_ex_compatibility_bool,
	compat .initial:n = false,
	compatilibity .meta:n = {compat=#1},
	compatibility .default:n = true,
	credit .tl_set:N = \l_ptxcd_ex_credit_tl,
	credit .initial:n =,
	headontitle .bool_gset:N = \g_ptxcd_headontitle_bool,
	headontitle .initial:n = false,
	headontitle .default:n =true,
	colorback .bool_gset:N  = \g_ptxcd_colorback_bool,
	colorback .default:n = true,
	colorback .initial:n  = true,
	title .choice:,
	title / default .meta:n = {title=large},
	title / large .code:n = \bool_gset_false:N \g_ptxcd_smalltitle_bool,
	title / small  .code:n = \bool_gset_true:N \g_ptxcd_smalltitle_bool,
	title .initial:n = default,
	department .choice:,
	department / default .code:n = \str_gset:Nn \g_ptxcd_department_str {default},
	department / mecheng .code:n = {
		\str_gset:Nn \g_ptxcd_department_str {mecheng}
		\keys_set:nn {ptxcd/exercise}{colorback=false,departmentlogofile=tuda_maschinenbau_logo,color=Primary1}
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
	match-task-subtask-syntax .bool_gset:N = \g_ptxcd_match_task_subtask_bool,
	match-task-subtask-syntax .initial:n = false, 
	match-task-subtask-syntax .default:n = true,
	solution .code:n = {
		\bool_set_eq:Nc \l_ptxcd_ex_solution_bool {c_#1_bool}
		\ptxcd_setup_solution:
	},
	solution .default:n = true,
	unknown .code:n = {\prop_gput:NVn \g_ptxcd_unknown_clsopts_prop \l_keys_key_tl {#1}},
	points .choice:,
	points / true .code:n = \bool_set_false:N \l__ptxcd_points_auto_bool\bool_gset_true:N \g__ptxcd_points_bool,
	points /false .code:n =  \bool_set_false:N \l__ptxcd_points_auto_bool\bool_gset_false:N \g__ptxcd_points_bool,
	points / auto .code:n = \bool_set_true:N \l__ptxcd_points_auto_bool\bool_gset_true:N \g__ptxcd_points_bool,
	points .initial:n = false,
	subtask .choice:,
	subtask / ruled .code:n = 
		\bool_gset_true:N \g__ptxcd_ruled_subtask_bool
		\bool_gset_false:N  \g__ptxcd_runin_subtask_bool,
	subtask / runin .code:n =
		\bool_gset_false:N \g__ptxcd_ruled_subtask_bool
		\bool_gset_true:N  \g__ptxcd_runin_subtask_bool,
	subtask / plain .code:n =
		\bool_gset_false:N \g__ptxcd_ruled_subtask_bool
		\bool_gset_false:N  \g__ptxcd_runin_subtask_bool,
}

\ProcessKeyOptions[ptxcd/exercise]

\prop_map_inline:Nn \g_ptxcd_clsopts_prop {
	\tl_if_empty:nTF {#2}
		{\PassOptionsToClass  {#1} {scrartcl}}
		{
		\clist_map_inline:nn {#2} {\PassOptionsToClass  {#1=##1} {scrartcl}}
		}
}

\RequirePackage{environ}

\bool_new:N \l_ptxcd_ex_subtask_fallback_bool
\fp_new:N \l_ptxcd_ex_task_points_fp
\fp_new:N \g__ptxcd_ex_collected_points_fp
\tl_new:N \l_ptxcd_ex_task_credit_tl

\keys_define:nn {ptxcd/task}{
	points .choice:,
	points / auto .code:n =
		\bool_set_true:N \l__ptxcd_points_auto_bool,
	points / unknown .code:n = \fp_set:Nn \l_ptxcd_ex_task_points_fp {#1}
		\bool_set_false:N \l__ptxcd_points_auto_bool,
	credit .code:n = \tl_set:Nn \l_ptxcd_ex_task_credit_tl {#1}
		\bool_set_false:N \l__ptxcd_points_auto_bool,
	solution .meta:nn ={ptxcd/exercise}{solution=#1},
}

\fp_new:N \l_ptxcd_ex_subtask_points_fp 
\keys_define:nn {ptxcd/subtask} {
	credit .tl_set:N = \l_ptxcd_ex_subtask_credit_tl,
	credit .initial:n =,
	points .code:n = \fp_set:Nn \l_ptxcd_ex_subtask_points_fp {#1}
	\bool_set_false:N \l__ptxcd_points_auto_bool,
	title .tl_set:N = \l_ptxcd_ex_title_tl,
	title .initial:n =,
	unknown .code:n = \bool_set_true:N \l_ptxcd_ex_subtask_fallback_bool \tl_clear:N \l_ptxcd_ex_subtask_credit_tl \fp_zero:N \l_ptxcd_ex_subtask_points_fp,
}

\keys_define:nn {ptxcd/exercise/headline} {
	headline .code:n = {
		\if@twoside
		\keys_set:nn  {ptxcd/exercise/headline} {odd=#1,even=#1}
		\else
		\keys_set:nn {ptxcd/exercise/headline} {oneside=#1}
		\fi
	},
}

\clist_map_inline:nn {odd, even, oneside} {
	\tl_new:c {g_ptxcd_ex_headline_#1_tl}
	\keys_define:nn {ptxcd/exercise/headline} {
		#1 .choice:,
		#1 / title-name-id .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {
			\g_ptxcd_shorttitle_tl\par
			\StudentName\StudentID},
		#1 / title-name .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {
			\g_ptxcd_shorttitle_tl\par
			\smallskip
			\StudentName},
		#1 / title .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {\g_ptxcd_shorttitle_tl},
		#1 / name-id .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {\StudentName\StudentID},
		#1 / name .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {\StudentName},
		#1 / unknown .code:n = \tl_gset:cn {g_ptxcd_ex_headline_#1_tl} {##1}
	}
}


%Load tudasize clo file if available
\file_if_exist:nT {tudasize\prop_item:Nn \g_ptxcd_clsopts_prop {fontsize}.clo}
	{\providecommand*{\@fontsizefilebase}{tudasize}}

\LoadClass{scrartcl}

\bool_if:NT \g__ptxcd_points_bool {
  \cs_if_exist:NF \AddtoDoHook{
    \msg_error:nnnn  {tudaexercise} {outdated-koma-script} {points=true/auto} {3.27}
    \keys_set:nn {ptxcd/exercise} {points=false}
    }
}

\RequirePackage{tudarules}

%Has to be loaded here due to headwidth options
\RequirePackage[draft=false]{scrlayer-scrpage}
\KOMAoptions {twoside = false}

\prop_map_inline:Nn \g_ptxcd_unknown_clsopts_prop {
	\cs_if_exist:cT {KV@KOMA.scrartcl.cls@#1} {
	\tl_if_empty:nTF {#2}
		{\KOMAoptions{#1}}
		{\KOMAoption{#1}{#2}
	}
}
}

\renewcommand*\sectionlinesformat[4]{%
\parbox{\linewidth}{
	\bool_if:cT {g__ptxcd_ruled_#1_bool} {
	\rule[5\g_ptxcd_titlerule_dim]{\linewidth}{\g_ptxcd_titlerule_dim}\par\nointerlineskip
	}
	\@hangfrom{%
		\hskip #2#3}{
		\tl_if_eq:nnT {#1} {task} {
			\exp_args:No \tl_if_empty:nF {#4}
				{:~}	
			\bool_if:NT \l__ptxcd_points_auto_bool {
				\exp_args:NNx \prop_get:NnN \g__ptxcd_loaded_points_prop {\thetask} \l_ptxcd_tmp_tl
				\quark_if_no_value:NF \l_ptxcd_tmp_tl {
					\fp_set:Nn \l_ptxcd_ex_task_points_fp {\l_ptxcd_tmp_tl}
				}
			}
		}
		#4
		\tl_if_in:nnT {#1} {task} {
			\tl_if_empty:cTF{l_ptxcd_ex_#1_credit_tl}
				{\pointformat{\fp_to_decimal:c {l_ptxcd_ex_#1_points_fp}}}
				{\creditformat{\tl_use:c {l_ptxcd_ex_#1_credit_tl}}}
		}
		\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
		\skip_vertical:n {\ptxcd_titlerule_sep: -\dp\strutbox}
	\bool_if:cT {g__ptxcd_ruled_#1_bool} {\smash{\rule{\linewidth}{\g_ptxcd_titlerule_dim}}}
}}


\RequirePackage{tudafonts}

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

\dim_new:N \g_ptxcd_headheight_dim
\dim_new:N \g_ptxcd_headwidth_dim

\dim_gset:Nn \g_ptxcd_headheight_dim {\c_ptxcd_largerule_dim +\c_ptxcd_rulesep_dim +\c_ptxcd_smallrule_dim}
%%%%%Anfang Randeinstellungen Geometry


\bool_if:NTF  \g_ptxcd_geometry_bool {
	\RequirePackage[top=\g_ptxcd_topMargin_dim, inner=\g_ptxcd_innerMargin_dim, outer=\dim_eval:n {\g_ptxcd_outerMargin_dim}, bottom=\g_ptxcd_bottomMargin_dim, columnsep= \g_ptxcd_columnSep_dim, includehead, includefoot, headheight=\g_ptxcd_headheight_dim
	]{geometry}
}{
	\KOMAoptions{headinclude, footinclude, headwidth=text,footwidth=text}
}

%%%%%%%%
%Ende Randeinstellungen klassisch

\newcommand*{\institution}[1]{
	\def\ptxcd_institution{#1}
}

\gdef\ptxcd_datename{Datum}
\gdef\ptxcd_dateseparator{:~}




\setkomafont{disposition}{\sffamily\bfseries}

\cs_new:Nn \ptxcd_titlerule_sep: {\the\dp\strutbox}

\RequirePackage{tudacolors}
\RequirePackage{environ}

\setkomafont{pageheadfoot}{\sffamily\small}
\setkomafont{pagenumber}{}
\addtokomafont{captionlabel}{\sffamily}
\addtokomafont{caption}{\sffamily}

\box_new:N \g_ptxcd_ex_headline_odd_box
\box_new:N \g_ptxcd_ex_headline_even_box
\box_new:N \g_ptxcd_ex_headline_oneside_box

\cs_new:Nn \ptxcd_preamble_ConfigureHeadline:n {
  \tl_if_empty:nF {#1} {\keys_set:nn {ptxcd/exercise/headline} {#1}}
}

\cs_new:Nn \ptxcd_ConfigureHeadline:n {
  \ptxcd_preamble_ConfigureHeadline:n {#1}
  \ptxcd_update_headline_boxes:
  \ptxcd_ex_adjust_headheight:
}

\let\ConfigureHeadline\ptxcd_preamble_ConfigureHeadline:n



\bool_if:NT \g_ptxcd_ex_compatibility_bool {
	\cs_new:Npn \ptxcd_ex_env_to_tl_aux:w #1 \q_stop { \tl_gset:Nn     \g_ptxcd_ex_headline_oneside_tl {#1} }
	
	\NewEnviron{examheader}{
	  \tl_gset:No \g_ptxcd_ex_headline_oneside_tl {\BODY}
	  \tl_gset:No \g_ptxcd_ex_headline_odd_tl {\BODY}
	  \tl_gset:No \g_ptxcd_ex_headline_even_tl {\BODY}
	  \ptxcd_ConfigureHeadline:n {}
	}
	
	  \newcommand*{\examheaderdefault}{\par\StudentName\StudentID}
}


\cs_new:Nn \ptxcd_update_headline_boxes: {
  \clist_map_inline:nn {even, odd, oneside}
  {
    \tl_if_empty:cF {g_ptxcd_ex_headline_##1_tl} {
      \vbox_gset:cn {g_ptxcd_ex_headline_##1_box} {
          \begin{minipage}[b]{\textwidth}
          \usekomafont{pagehead}
         \raggedright
          \leavevmode\rule{\z@}{\dimexpr\ht\strutbox+\c_ptxcd_rulesep_dim}
          \ignorespaces
          \use:c {g_ptxcd_ex_headline_##1_tl}\ignorespaces\strut
          \par\vspace{\z@}
        \end{minipage}
      }
    }
  }
}


\cs_new:Nn \ptxcd_ex_adjust_headheight: {
	\if@twoside
	\dim_set:Nn \l_tmpa_dim {
		\dim_max:nn
			{\box_ht:N \g_ptxcd_ex_headline_odd_box+\box_dp:N \g_ptxcd_ex_headline_odd_box}
			{\box_ht:N \g_ptxcd_ex_headline_even_box+\box_dp:N \g_ptxcd_ex_headline_even_box}
	}
	\else
	\dim_set:Nn \l_tmpa_dim {
		\box_ht:N \g_ptxcd_ex_headline_oneside_box
		+ \box_dp:N \g_ptxcd_ex_headline_oneside_box
	}
	\fi
	\dim_compare:nT {\l_tmpa_dim > \z@}
	{
		\dim_add:Nn \l_tmpa_dim {\box_dp:N \ptxcd_headrule_box +\c_ptxcd_rulesep_dim}
		\KOMAoptions{headinclude, headheight=\l_tmpa_dim,headsepline = .5\c_ptxcd_smallrule_dim}
		\if@twoside
		\cehead{\box_use:c {g_ptxcd_ex_headline_even_box}}
		\cohead{\box_use:c {g_ptxcd_ex_headline_odd_box}}
		\else
		\chead{\box_use:c {g_ptxcd_ex_headline_oneside_box}}
		\fi
		\global\setlength{\headheight}{\l_tmpa_dim}
	}
}

\newpairofpagestyles{TUDa.exercise}{
	\KOMAoptions{plainfootsepline,headtopline,plainheadtopline}
		\KOMAoptions {
			headwidth=text,
			footwidth=text
			}
	\setkomafont{pagehead}{}
	\box_if_exist:NF \ptxcd_headrule_box {
		\ptxcd_makeheadrule[color=identbarcolor, width=\sls@headwidth]{ptxcd_headrule}
	}
\ModifyLayer[
	background,
	height=\box_dp:N \ptxcd_headrule_box,
	align=tl,
	voffset=\g_ptxcd_topMargin_dim,
	contents=\raisebox{\depth}{\box_use:N \ptxcd_headrule_box},
		]{plain.TUDa.exercise.head.above.line}
	\ModifyLayer[
	background,
	height=\box_dp:N \ptxcd_headrule_box,
	align=tl,
	voffset=\g_ptxcd_topMargin_dim,
	contents=\raisebox{\depth}{\box_use:N \ptxcd_headrule_box},
		]{TUDa.exercise.head.above.line}
	\ofoot[\pagemark]{\pagemark}
	\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{TUDa.exercise.foot.even}
	\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{TUDa.exercise.foot.odd}
	\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{TUDa.exercise.foot.oneside}
	\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{plain.TUDa.exercise.foot.even}
	\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{plain.TUDa.exercise.foot.odd}
	\ModifyLayer[addvoffset=\c_ptxcd_rulesep_dim]{plain.TUDa.exercise.foot.oneside}
}

\DeclarePageStyleAlias{TUDa}{TUDa.exercise}
\DeclarePageStyleAlias{plain.TUDa}{plain.TUDa.exercise}
\renewcommand{\titlepagestyle}{plain.TUDa}
\pagestyle{TUDa}

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

\ptxcd_declare_caption:Nnn \authorandname {und} {and}

\renewcommand*{\@author}{
	\seq_use:Nnnn \g_ptxcd_author_seq {~\authorandname{}~} {,~} {~\&~}
      }

\tl_new:N \g_ptxcd_shorttitle_tl

\RenewDocumentCommand{\title}{om}{
  \IfNoValueTF{#1}{
    \tl_gset:Nn  \g_ptxcd_shorttitle_tl {#2}
  }{
    \tl_gset:Nn \g_ptxcd_shorttitle_tl {#1}
  }
  \def\@title{#2}
}

% Define \subsubtitle for compatibility
  \newcommand*{\subsubtitle}[1]{
    \def\@subsubtitle{#1}
  }
  \subsubtitle{}


\newcommand*{\ptxcd_title@footnote}[2][1]{
\textsuperscript{\@fnsymbol{#1}}#2
}


\renewcommand*{\@maketitle}{%
  \global\@topnum=\z@
  \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
  \vspace*{-\dim_eval:n {
      \headheight
	-\c_ptxcd_largerule_dim -\c_ptxcd_rulesep_dim
      +\headsep
      +\ht\strutbox
      +\p@
    }}
  \par
  \nointerlineskip
  \begingroup
  \setlength{\fboxsep}{\z@}
  \bool_if:NT \g_ptxcd_colorback_bool {\colorbox{accentcolor}}{\parbox[t]{\linewidth}{
	\rule{0pt}{\bool_if:NTF \g_ptxcd_smalltitle_bool {.25} {.5}\c_ptxcd_logoheight_dim}
	\par\nointerlineskip
      \raisebox{-\height}{%
        \begin{minipage}[t]{\dimexpr\linewidth-\__ptxcd_logowidth:-1ex}
          \bool_if:NT \g_ptxcd_colorback_bool  {\begin{addmargin}{3mm}}
            \raggedright
            \bool_if:NT \g_ptxcd_colorback_bool {\color{textonaccentcolor}}
            \tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
            \leavevmode\usekomafont{title}%
            {\usekomafont{title}\bool_if:NTF \g_ptxcd_smalltitle_bool {\LARGE} {\huge} {\@title\par}}%
            \vskip 1em
            \bool_if:NF \g_ptxcd_ex_compatibility_bool
	            {
					{\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
					\gdef\@subtitle{}
					\vskip .5em
				}
			{
              \xdef\@author {\@author}
              \ifx\@author\@empty\else\usekomafont{author}\@author\par\fi
			}
            \vskip .5em
          \bool_if:NTF \g_ptxcd_colorback_bool {\end{addmargin}} {\par}
        \end{minipage}}
		\tl_if_empty:NF \g_ptxcd_logofile_tl {
		\hfill\raisebox{\dim_eval:n {
				\bool_if:NTF \g_ptxcd_colorback_bool
				{-\height}
				{-.9\c_ptxcd_logoheight_dim}
			}}
			[0pt]
			[\dim_eval:n {
			\bool_if:NTF \g_ptxcd_smalltitle_bool
				{\bool_if:NTF \g_ptxcd_colorback_bool {1.15}{1}}
				{\bool_if:NTF \g_ptxcd_colorback_bool {1.5}{1.3}
			}\c_ptxcd_logoheight_dim}]
		{\makebox[\__ptxcd_logowidth:][l]{\includegraphics[height=\c_ptxcd_logoheight_dim]{\g_ptxcd_logofile_tl}}}
		}
      \par\medskip
    }}
  \par
  \nointerlineskip
  \rule{\linewidth}{\g_ptxcd_titlerule_dim}
    % subtitle fields if not compat
  \exp_args:Nf \tl_if_empty:nF {\g_ptxcd_ex_sheetnum_tl\@date\g_ptxcd_ex_term_tl\use:c {@subsubtitle}\@subtitle}{
    \par\nointerlineskip
    \bool_if:NT \g_ptxcd_colorback_bool {\colorbox{accentcolor}}{
      \parbox{\linewidth}{
        \begin{minipage}{\linewidth}
			\bool_if:NT \g_ptxcd_colorback_bool {
				\color{textonaccentcolor}
				\begin{addmargin}{3mm}
			}
            \null\par
            \def\ptxcd_nextsep{}
            \clist_map_inline:nn {@subtitle, @subsubtitle, g_ptxcd_ex_term_tl, @date} {
              \tl_if_empty:cF {##1} {\ptxcd_nextsep\use:c {##1}\def\ptxcd_nextsep{\\}}
            }
            \tl_if_empty:NF \g_ptxcd_ex_sheetnum_tl {\ptxcd_nextsep\sheetname\sheetsep\g_ptxcd_ex_sheetnum_tl}
          \bool_if:NT \g_ptxcd_colorback_bool {\end{addmargin}}
        \end{minipage}
        \vspace*{\dp\strutbox}
      }}\par\nointerlineskip
    \rule{\linewidth}{\g_ptxcd_titlerule_dim}
  }
  \par
  \bool_if:NT  \g_ptxcd_headontitle_bool {
    \if@twoside
    \box_use:N \g_ptxcd_ex_headline_odd_box
    \else
    \box_use:N \g_ptxcd_ex_headline_oneside_box
    \fi
    \par
    \rule{\linewidth}{\g_ptxcd_titlerule_dim}
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
\tl_new:N \g_ptxcd_ex_sheetnum_tl
\newcommand*{\sheetnumber}[1]{\tl_gset:Nn \g_ptxcd_ex_sheetnum_tl {#1}}
\sheetnumber{}
\tl_new:N \g_ptxcd_ex_term_tl
\newcommand*{\term}[1]{\tl_gset:Nn \g_ptxcd_ex_term_tl {#1}}
\term{}

%Logos
\RequirePackage{graphicx}

%%hyperref
\PassOptionsToPackage{pdfusetitle}{hyperref}
\RequirePackage{hyperref}
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
\providecommand{\creditformatsum}[1]{\creditformat{#1}}
\newcommand*{\pointformat}[1]{
	\fp_compare:nF {#1 = 0} {
		\bool_if:NTF \l__ptxcd_points_auto_bool 
			\creditformatsum
			\creditformat
		{
			\fp_to_decimal:n {#1}\space
			\fp_compare:nTF {#1=1}
				\PointName
				\PointsName
		}
	}
}
\providecaptionname{ngerman, german}{\PointName}{Punkt}
\providecaptionname{english, american, british}{\PointName}{Point}
\providecommand{\PointsName}{Punkte}
\providecaptionname{ngerman, german}{\PointsName}{Punkte}
\providecaptionname{english, american, british}{\PointsName}{Points}

%Has to be initialized after captionnames have been defined
 \AtBeginDocument{
  \ptxcd_update_headline_boxes:
  \ptxcd_ex_adjust_headheight:
  \global\let\ConfigureHeadline\ptxcd_ConfigureHeadline:n
}

%task environment
\DeclareSectionCommand[%
	style=section,%
	level=2,%
	indent=\z@,%
	beforeskip=\cs_if_exist_use:NF \scr@subsection@beforeskip {-3.25ex\@plus -1ex \@minus -.2ex},%
	afterskip=\cs_if_exist_use:NF \scr@subsection@afterskip {1.5ex \@plus .2ex},%
	tocstyle=section,%
	tocindent=\cs_if_exist_use:NF \scr@tso@subsection@indent {1.5em},%
	tocnumwidth=\cs_if_exist_use:NF \scr@tso@subsection@numwidth {2.3em},%
]{task}

\renewcommand*{\thetask}{
	\g_ptxcd_ex_sheetnum_tl\tl_if_empty:NF \g_ptxcd_ex_sheetnum_tl{.}
	\arabic{task}
}
\renewcommand*{\taskformat}{\taskname\tasksep\thetask{}}

\let\@task\task
\cs_undefine:N \task

\NewDocumentEnvironment{task}{om}{
	\IfNoValueF{#1}{\keys_set:nn {ptxcd/task}{#1}}
	\@task{#2}
	\bool_if:NF \l__ptxcd_points_auto_bool {
          \cs_if_exist_use:NF \prop_gput:Nxx
          {\exp_args:NNx \prop_gput:Nnx}
          \g__ptxcd_points_collector_prop
		{\thetask} {\fp_to_decimal:N \l_ptxcd_ex_task_points_fp}
	}
}{
  \bool_if:NT \l__ptxcd_points_auto_bool {
    \cs_if_exist_use:NF \prop_gput:Nxx
          {\exp_args:NNx \prop_gput:Nnx}
            \g__ptxcd_points_collector_prop
			{\thetask} {\fp_to_decimal:N \g__ptxcd_ex_collected_points_fp}
		\fp_gzero:N \g__ptxcd_ex_collected_points_fp
	}
}

\cs_set_eq:cN {task*} \task
\cs_set_eq:cN {endtask*} \endtask

% subtasks
\DeclareSectionCommand[%
	style=section,%
	level=3,%
	indent=\z@,%
	beforeskip=\cs_if_exist_use:NF \scr@subsubsection@beforeskip {-3.25ex\@plus -1ex \@minus -.2ex},%
	afterskip=\cs_if_exist_use:NF \scr@subsubsection@afterskip {1.5ex \@plus .2ex},%
	tocstyle=subsection,%
	tocindent=\cs_if_exist_use:NF \scr@tso@subsubsection@indent {1.5em},%
	tocnumwidth=\cs_if_exist_use:NF \scr@tso@subsubsection@numwidth {2.3em},%
	counterwithin=task,%
]{subtask}

\bool_if:NT \g__ptxcd_runin_subtask_bool {
	\RedeclareSectionCommand[runin=true]{subtask}
}

\renewcommand*{\thesubtask}{\alph{subtask})}
\renewcommand*{\subtaskformat}{\thetask{}\thesubtask\enskip}
\setkomafont{subtask}{\mdseries\normalsize}

\let\@subtask\subtask
\cs_undefine:N \subtask

\NewDocumentEnvironment{subtask}{o}{
	\begingroup
	\tl_if_in:nnT {#1} {=} {
		\keys_set:nn {ptxcd/subtask} {#1}
	}
	\bool_if:NTF \l_ptxcd_ex_subtask_fallback_bool {
		\@subtask{\IfNoValueF{#1}{#1}}
	}{
		\@subtask{\l_ptxcd_ex_title_tl}
	}
   \cs_if_exist_use:NF \prop_gput:Nxx
      {\exp_args:NNx \prop_gput:Nnx}
       \g__ptxcd_subtask_points_collector_prop
	   {\thetask\thesubtask} {\fp_to_decimal:N  \l_ptxcd_ex_subtask_points_fp }
	\bool_if:NT  \g__ptxcd_runin_subtask_bool \strut
	\tl_gset_eq:NN \g_tmpa_tl \@currentlabel
	\endgroup
	\tl_set_eq:NN \@currentlabel \g_tmpa_tl
}{}

\NewDocumentEnvironment{subtask*}{om}{
	\begingroup
	\IfNoValueF{#1}{\keys_set:nn {ptxcd/subtask}{#1}}
	\@subtask{#2}
	\tl_gset_eq:NN \g_tmpa_tl \@currentlabel
	\endgroup
	\tl_set_eq:NN \@currentlabel \g_tmpa_tl
}{}

%Solution mechanism

\DeclareSectionCommand[%
	style=section,%
	level=3,%
	indent=\z@,%
	beforeskip=\cs_if_exist_use:NF \scr@subsubsection@beforeskip {-3.25ex\@plus -1ex \@minus -.2ex},%
	afterskip=\cs_if_exist_use:NF \scr@subsubsection@afterskip {1.5ex \@plus .2ex},%
	tocstyle=subsection,%
	tocindent=\cs_if_exist_use:NF \scr@tso@subsubsection@indent {1.5em},%
	tocnumwidth=\cs_if_exist_use:NF \scr@tso@subsubsection@numwidth {2.3em},%
]{@solution}


\setkomafont{@solution}{\normalfont}

\cs_new:Nn \ptxcd_ex_solutionheader: {
  \@solution*{\solutionname\solutionsep}
  \if@newlist\global\@newlistfalse\fi
}

\box_new:N \g_ptxcd_NumberForm_box
\hbox_gset:Nn \g_ptxcd_NumberForm_box {
  \rule{\fboxrule}{1ex}
  \rule{1em}{\fboxrule}
  \rule{\fboxrule}{1ex}
  \,
}

\newcommand*\ptxcd_StudentID[1][7]{
  \StudentIDname\StudentIDsep\prg_replicate:nn {#1} {\box_use:N \g_ptxcd_NumberForm_box}
}
\let\StudentID\ptxcd_StudentID

\newcommand*\ptxcd_StudentName{
  \StudentNamename\StudentNamesep\hrulefill\qquad
}
\let\StudentName\ptxcd_StudentName

\let\ShortTitle\g_ptxcd_shorttitle_tl

% Compatibility Features

\bool_if:NT \g_ptxcd_ex_compatibility_bool {
  \cs_set_eq:NN \c@subsection \c@task
  \cs_set_eq:NN \subsection \task
  \cs_set_eq:NN \c@subsubsection \c@subtask
  \cs_set_eq:NN \subsubsection \subtask
  \cs_set_eq:NN \thetask \thesubsection
  \cs_set_eq:NN \thesubtask \thesubsection
}

\file_if_exist_input:n {\g__ptxcd_config_prefix_tl\g_ptxcd_department_str.cfg}

\ptxcd_makeheadrule[color=identbarcolor, width=\textwidth]{ptxcd_headrule}

% Point referencing
\cs_if_exist:NTF \AddtoDoHook {
  \AddtoDoHook{heading/preinit/subtask}{
    \bool_if:NT \g__ptxcd_points_bool {
      \fp_gadd:Nn \g__ptxcd_ex_collected_points_fp {\l_ptxcd_ex_subtask_points_fp}
    }
  }

  \AddtoDoHook{heading/preinit/task}{
    \fp_gzero:N \g__ptxcd_ex_collected_points_fp
  }
} {
  \msg_warning:nnnn  {tudaexercise} {outdated-koma-script} {point~references} {3.27}
}



\msg_new:nnn {tudaexercise} {points-differ} {
	Value~of~points~changed~for~at~least~one~task.\\
	Please~rerun~LaTeX~to~get~correct~references~and~calculations.
}

\msg_new:nnn {tudaexercise} {empty-point-mapping} {
	I~could~not~find~references~for~points~in~the~aux~file.\\
	Please~rerun~LaTeX~to~get~correct~references~and~calculations.
}

\msg_new:nnn {tudaexercise} {point-referencing-disabled} {
	You~try~to~use~#1.\\
	This~function~is~only~available~with~points=true~or~points=auto.\\	
	Please~activate~referencing~to~use~it.
}

\bool_if:NTF \g__ptxcd_points_bool {
	\BeforeClosingMainAux{
		\tl_clear:N \l_tmpa_tl
		\tl_clear:N \l_tmpb_tl
		\fp_zero:N \l_tmpa_fp
		\prop_map_inline:Nn  \g__ptxcd_points_collector_prop {
			\tl_put_right:Nn \l_tmpa_tl {#1=#2,}
			\fp_add:Nn \l_tmpa_fp {#2}
		}
		\prop_map_inline:Nn  \g__ptxcd_subtask_points_collector_prop {
			\tl_put_right:Nn \l_tmpa_tl {#1=#2,}
		}
		\prop_map_inline:Nn \g__ptxcd_loaded_points_prop {
			\tl_put_right:Nn \l_tmpb_tl {#1=#2,}
		}
		\tl_if_eq:NNF \l_tmpa_tl \l_tmpb_tl {
			\msg_warning:nn {tudaexercise} {points-differ}
		}
		\iow_now:Nx \@auxout{
			\exp_not:N \ptxcd@LoadPoints[\thetask][\fp_use:N \l_tmpa_fp]{\l_tmpa_tl}
		}
	}
	
	\cs_new:Nn \__ptxcd_getPoints:n {
			\prop_if_in:NnTF \g__ptxcd_loaded_points_prop {#1}
				{\prop_item:Nn \g__ptxcd_loaded_points_prop {#1}}
				{\nfss@text{\reset@font\bfseries??}}
	}
	\cs_generate_variant:Nn \__ptxcd_getPoints:n {x}

	\newcommand{\getPoints}[1]{\__ptxcd_getPoints:x {#1}}

	\newcommand{\refPoints}[1]{
		\edef\x{#1}
		\cs_if_exist:cTF {r@\x} {
			\str_if_in:cnTF {r@\x} {subtask} {
				\tl_set_eq:Nc \l_tmpa_tl {r@\x}
				\getPoints{\tl_item:Nn \l_tmpa_tl  {2}\tl_item:Nn \l_tmpa_tl  {1}}
			} {
				\getPoints{\tl_head:v {r@\x}}
			}
		}{
			\nfss@text{\reset@font\bfseries??}
		}
	}

	\newcommand{\getPointsTotal}{
		\fp_use:N \g__ptxcd_points_total_fp
	}

        \NewDocumentCommand{\mapPoints}{sO{1}m}{
	\cs_gset_nopar:Nn \__ptxcd_map_points_helper:nn {#3}
	\prop_if_empty:NTF \g__ptxcd_loaded_points_prop {
	 \msg_warning:nn {tudaexercise} {empty-point-mapping}
 	 \__ptxcd_map_points_helper:nn {?task?} {?points?}
	}{
	\int_gset:Nn \g_ptxcd_tmp_int {\value{task}}
	\setcounter{task}{#2}
	\tl_gclear:N \g_ptxcd_tmp_tl
	\bool_gset_true:N \g_tmpa_bool 
	\bool_while_do:Nn \g_tmpa_bool 
	{
			\exp_args:NNx \prop_get:NnNTF \g__ptxcd_loaded_points_prop {\thetask} \l_tmpa_tl
			{
				\fp_compare:nF {\l_tmpa_tl = 0}
				{
					\tl_gput_right:Nn \g_ptxcd_tmp_tl {\__ptxcd_map_points_helper:nn}
					\tl_gput_right:Nx \g_ptxcd_tmp_tl {{\thetask} {\l_tmpa_tl}}
				}
		}
		{\bool_gset_false:N \g_tmpa_bool}
		\stepcounter{task}
	}
	\setcounter{task}{\int_use:N \g_ptxcd_tmp_int}
	\g_ptxcd_tmp_tl 
	}
        }

} {
	\newcommand{\getPoints}[1]{
			\msg_error:nnn {tudaexercise} {point-referencing-disabled} {\getPoints}
	}
	\newcommand{\refPoints}[1]{
			\msg_error:nnn {tudaexercise} {point-referencing-disabled} {\refPoints}
	}
	\newcommand{\getPointsTotal}[1]{
		\msg_error:nnn {tudaexercise} {point-referencing-disabled} {\getPointsTotal}
	}

        \NewDocumentCommand{\mapPoints}{som} {
          \msg_error:nnn {tudaexercise} {point-referencing-disabled} {\mapPoints}
        }
}

\cs_new:Nn \__ptxcd_map_points_helper:nn {#1-#2}


\NewDocumentCommand{\ptxcd@LoadPoints}{oO{0}m}{
	\prop_gset_from_keyval:Nn \g__ptxcd_loaded_points_prop {
		#3
	}
	\fp_gset:Nn \g__ptxcd_points_total_fp {#2}
}


\endinput
%End of class tudaexercise.cls
