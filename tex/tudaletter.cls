%% This is file `tudaletter.cls' version 3.39 (2024-06-27),
%% it is part of
%% TUDa-CI -- Corporate Design for TU Darmstadt
%% ----------------------------------------------------------------------------
%%
%%  Copyright (C) 2018--2024 by Marei Peischl <marei@peitex.de>
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
\def\fileversion{3.39}
\def\filedate{2024-06-27}
\NeedsTeXFormat{LaTeX2e}

\ProvidesExplClass{tudaletter}
	{\filedate}{\fileversion}{Letters for TUDa-CI, Corporate Design of TU Darmstadt}

\str_const:Nn \c__ptxcd_base_str {letter}
\str_new:N  \g_ptxcd_department_str
\bool_new:N \g__ptxcd_adjust_textwidth_bool

\keys_define:nn {ptxcd/letter} {
	logo .bool_gset:N = \g__ptxcd_letter_logo_bool,
	logo .default:n = true,
	logo .initial:n = true,
	premium .bool_gset:N = \g__ptxcd_letter_premium_bool,
	premium .default:n = true,
	accentcolor .code:n = \PassOptionsToPackage{accentcolor=#1}{tudacolors},
	firstpagenumber .bool_gset:N = \g__ptxcd_firstpagenumber_bool,
	firstpagenumber .initial:n = true,
	raggedright .bool_gset:N = \g__ptxcd_letter_raggedright_bool,
	pdfa .bool_gset:N = \g_ptxcd_pdfa_bool,
	pdfa .initial:n = true,
	pdfx .bool_gset:N = \g_ptxcd_pdfx_bool,
	pdfx .initial:n = true,
	logofile .tl_gset:N = \g_ptxcd_logofile_tl,
	logofile .initial:n = tuda_logo,
		department .choice:,
	department / default .code:n = \str_gset:Nn \g_ptxcd_department_str {default},
	department / mecheng .code:n = {
		\str_gset:Nn \g_ptxcd_department_str {mecheng}
		\keys_set:nn {ptxcd/letter}{departmentlogofile=tuda_maschinenbau_logo,headrule=false,logo=false,textwidth=narrow}
		\PassOptionsToPackage{identbar=Primary1,accent=Primary2}{tudacolors}
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
	headrule .bool_gset:N = \g__ptxcd_letter_headrule_bool,
	headrule .initial:n = true,
	headrule .default:n = true,
	textwidth .choice:,
	textwidth / wide .code:n = \bool_gset_true:N \g__ptxcd_adjust_textwidth_bool,
	textwidth / narrow .code:n = \bool_gset_false:N  \g__ptxcd_adjust_textwidth_bool,
	textwidth .initial:n = wide,
}


\ProcessKeyOptions[ptxcd/letter]

\bool_if:NF \g_ptxcd_pdfa_bool {\bool_gset_false:N \g_ptxcd_pdfx_bool}

\bool_if:NT \g_ptxcd_pdfa_bool {
	\msg_new:nnn {tudapub} {colors-to-rgb} {
			You~did~not~add~a~color~profile.\\
			I~will~use~the~default~one~and~automatically~try~to~convert~internal~colors~to~RGB.\\
			This~is~required~to~be~able~to~create~PDF/A~compliance.
	}

	\cs_if_exist:NT \pdfmeta_standard_get:nN {
		\pdfmeta_standard_get:nN  {outputintent_A} \l_tmpa_tl
		\quark_if_no_value:NF \l_tmpa_tl  {
			\bool_gset_false:N \g_ptxcd_pdfx_bool
			\msg_new:nnn{tudapub} {prefer-lualatex} {
				I~detected~usage~of~l3pdfmeta~(\DocumentMetadata)~to~create~PDF/A.\\
				tudapub~will~not~load~pdfx~to~avoid~conflicts.\\
				To~disable this message use pdfx=false.
			}
			\msg_info:nn {tudapub} {prefer-lualatex}
		}

		\prop_if_in:NnF \g__pdfmeta_outputintents_prop {GTS_PDFA1} {
			\PassOptionsToPackage{RGB}{xcolor}
			\msg_info:nn {tudapub} {colors-to-rgb}
		}
	}
}

\bool_if:NT \g_ptxcd_pdfx_bool {
	\PassOptionsToPackage{RGB}{xcolor}
	\msg_info:nn {tudapub} {colors-to-rgb}
}

\newcommand*{\@fontsizefilebase}{tudalettersize}

\PassOptionsToClass{fontsize=10pt,parskip=full-}{scrletter}
\PassOptionsToPackage{refline=nodate,addrfield=topaligned,firstfoot=false,pagenumber=botright}{scrletter}
\LoadClass{scrletter}

% Load the TUDa-colorscheme
\RequirePackage{tudacolors}

\bool_if:NTF \g__ptxcd_letter_premium_bool
{	\cs_new:Nn \ptxcd_premiumcolor: {accentcolor}
	\cs_new:Nn \ptxcd_use_premiumcolor: {\color{accentcolor}}
	\cs_set:Nn \ptxcd_use_premiumcolor_text: {\color{textaccentcolor}}
}{
	\cs_new:Nn \ptxcd_premiumcolor: {black}
	\let\ptxcd_use_premiumcolor:\relax
	\let\ptxcd_use_premiumcolor_text:\relax
}

\RequirePackage{tudafonts}
\RequirePackage{graphicx}
\RequirePackage{afterpage}
\RequirePackage{ragged2e}


%%%%%Briefbogen
%% Spacing:
\dim_const:Nn \c_ptxcd_HeadMargin_dim {12.5mm}
\dim_const:Nn \c_ptxcd_LeftMargin_dim {24.0mm}
\dim_const:Nn \c__ptxcd_firstpage_extraindent_dim {-\paperwidth+120mm +\c_ptxcd_LeftMargin_dim  +\c_ptxcd_HeadMargin_dim}
\bool_if:NTF \g__ptxcd_adjust_textwidth_bool
	{
		\dim_const:Nn \c_ptxcd_RightMargin_dim  {\c_ptxcd_HeadMargin_dim}
		
	}{
		\dim_const:Nn \c_ptxcd_RightMargin_dim  {\c_ptxcd_HeadMargin_dim-\c__ptxcd_firstpage_extraindent_dim}
	}
\dim_const:Nn \c_ptxcd_BottomMargin_dim {20mm}
\dim_const:Nn \c_ptxcd_Linewidth_dim {\paperwidth-\c_ptxcd_LeftMargin_dim-\c_ptxcd_RightMargin_dim}

\RequirePackage{geometry}

\geometry{
	twoside=false,
	left=\c_ptxcd_LeftMargin_dim,
	right=\c_ptxcd_RightMargin_dim,
	bottom=\c_ptxcd_BottomMargin_dim,
	footskip=7mm,
}

\dim_const:Nn \c_ptxcd_textwidth_dim {\textwidth}

\bool_if:NTF \g__ptxcd_letter_logo_bool {
	\geometry{top=64mm}
} {
	\geometry{top=30mm}
}

\@setplength{firstheadhpos}{\c_ptxcd_HeadMargin_dim}
\@setplength{firstheadvpos}{\c_ptxcd_HeadMargin_dim}
\@setplength{firstheadwidth}{\dim_eval:n {\paperwidth - 2\c_ptxcd_HeadMargin_dim}}

\@setplength{firstfootvpos}{\dim_eval:n {\paperheight -17mm}}
\@setplength{firstfoothpos}{\useplength{firstheadhpos}}
\@setplength{firstfootwidth}{\useplength{firstheadwidth}}


\@setplength{toaddrhpos}{\c_ptxcd_LeftMargin_dim}
\@setplength{toaddrvpos}{50mm}
\@setplength{backaddrheight}{4mm}
\@setplength{toaddrindent}{0mm}

\@setplength{refhpos}{\c_ptxcd_LeftMargin_dim}
\@setplength{refvpos}{106mm}

\@setplength{subjectaftervskip}{2\baselineskip}
\@setplength{lochpos}{\c_ptxcd_HeadMargin_dim}
\@setplength{locvpos}{\dimexpr\useplength{refvpos}+\useplength{subjectaftervskip}+1.4\baselineskip\relax}
\@setplength{refaftervskip}{0pt}
\@setplength{subjectbeforevskip}{0pt}
\@setplength{locwidth}{\dimexpr\paperwidth-154,5mm -\c_ptxcd_HeadMargin_dim\relax}
\@setplength{locheight}{\dimexpr\paperheight-\useplength{locvpos}-\c_ptxcd_BottomMargin_dim\relax}

\RequirePackage[paper=a4]{tudarules}

\bool_if:NTF \g__ptxcd_letter_headrule_bool {
	\ptxcd_makeheadrule[width=\useplength{firstheadwidth},color=identbarcolor]{ptxcd_LetterheadRule}
} {
	\box_new:N \ptxcd_LetterheadRule_box
	\def\ptxcd_LetterheadRule{}
}
\ptxcd_makefootrule[width=\useplength{firstheadwidth}]{ptxcd_LetterfootRule}


\box_new:N \g_TUDaLetter_firsthead_box
\hbox_gset:Nn \g_TUDaLetter_firsthead_box {
	\parbox[t]{\useplength{firstheadwidth}}{
	\raggedleft
	\smash{\ptxcd_LetterheadRule}
	\par
	\vspace{.5\c_ptxcd_logoheight_dim}
	\makebox[\__ptxcd_logowidth:][l]{\includegraphics[height=\c_ptxcd_logoheight_dim]{\g_ptxcd_logofile_tl}}
	}
}

\box_gset_dp:Nn \g_TUDaLetter_firsthead_box {\c_zero_dim}
\setkomavar{firsthead}{
	\box_use:N \g_TUDaLetter_firsthead_box
}

\KOMAoptions{backaddress=plain}
\setkomavar{backaddressseparator}{\,$\vert$\,}

%DOKU neue komavars
\newkomavar{frominstitution}
\newkomavar{frominstitution-en}

\newkomafont{ptxcd_location}{\accentfont\normalcolor}
\setkomafont{fromname}{\small}
\newkomafont{ptxcd_frominst}{\small\ptxcd_use_premiumcolor_text: }
\setkomafont{fromaddress}{\footnotesize}

\setkomafont{refname}{}
\setkomafont{refvalue}{}

\setkomafont{pageheadfoot}{\footnotesize}

\newcommand{\TUD@locfield}{%
	\usekomafont{ptxcd_location}\usekomafont{fromaddress}
	\setparsizes{\z@}{\z@}{\z@ plus 1fil}
	\par@updaterelative
      \begingroup
      \int_compare:nT {0 < \@pageat <3} {
		\ptxcd_letterpagemark:\\[\baselineskip]
  	  }
	  \usekomafont{ptxcd_frominst}
      \Ifkomavarempty{frominstitution}{}{%
      	{\usekomavar[\raggedright]{frominstitution}}
      	\\[\baselineskip]}%
      \Ifkomavarempty{frominstitution-en}{}{%
      	\usekomavar[\raggedright]{frominstitution-en}
      	\\[\baselineskip]}%
	  \endgroup
      \Ifkomavarempty{fromlogo}{}{\usekomavar{fromlogo}\\[\baselineskip]}%
      \Ifkomavarempty{fromname}{}
      {{\usekomafont{fromname}\usekomavar{fromname}}
		\Ifkomavarempty{fromfunction}{}{\\\usekomavar{fromfunction}}
      		\\[\baselineskip]}%
      \Ifkomavarempty{fromaddress}{}{\usekomavar{fromaddress}\\[\baselineskip]}%
      \@tempswafalse
      \clist_map_inline:nn {fromphone, fromfax, fromemail, fromurl}{
         \@tempswatrue
			\Ifkomavarempty{##1}{}{
			\Ifkomavarempty*{##1}{}{\makebox[1cm][l]{\usekomavar*{##1}}}\usekomavar{##1}\par
  	 	}
  	  }
      \if@tempswa
      \vspace{2\baselineskip}
      \fi
        \Ifkomavarempty*{date}{}{\usekomavar*{date}\\\usekomavar{date}}
      \seq_use:Nn  \g__ptxcd_reffields_seq {}
      \Ifkomavarempty{frombank}{}{\vfill%
        \Ifkomavarempty*{frombank}{Bankverbindung}{\usekomavar*{frombank}}\\\usekomavar{frombank}
	 }
}

\setkomavar{location}{\parbox[t][.45\paperheight][t]{\useplength{locwidth}}{\TUD@locfield}}

\tl_const:Nn \ptxcd_reffield_separator_tl {\\}

\cs_new:Nn \ptxcd_set_reffield:n {
	\Ifkomavarempty{#1}{}{%
		\if@tempswa\\[\baselineskip]\fi
		\parbox[t]{\linewidth}{\noindent\raggedright
			\usekomafont{refname}
			\usekomavar*{#1}\ptxcd_reffield_separator_tl
			\usekomafont{refvalue}
			\usekomavar{#1}
		}%
		\@tempswatrue
	}%
}



\seq_new:N  \g__ptxcd_reffields_seq
\newlength{\TUD@page@free}
\newcounter{TUD@page@free@lines}
\dim_new:N \g__ptxcd_page_free_dim
\int_new:N \g__ptxcd_free_lines_int

\renewcommand{\opening}[1]{%
	\widowpenalty=100
	\@PapersizeWarning
	\seq_gclear:N \g__ptxcd_reffields_seq
	\renewcommand*{\@set@reffield}[1]{
		\typeout{Field: ##1}%
		\str_if_eq:nnT {##1}{datemarkerfield}{%
			\let\scr@datemarkerfield@var=\scr@date@var
			\let\scr@datemarkerfield@name=\scr@date@name
			\setkomavar{date}{}%
		}
		\Ifkomavarempty{##1}{}{%
			\seq_gput_right:Nn \g__ptxcd_reffields_seq {%
				\ptxcd_set_reffield:n {##1}
			}%
		}%
	}
	\let\do@set@reffield\@set@reffield
	\@set@reffields
	\removereffields
	\@gen@firsthead
	\@mkboth{\scr@fromname@var}{\scr@subject@var}%
	\thispagestyle{letter.first}\noindent
	\Ifkomavarempty{toname}{\setkomavar{toname}{\mbox{}}}{}
	\@foldmarks\@firstheadfootfield\@addrfield\@locfield
	\ifdim\useplength{subjectvpos}=\z@\else\@subjfield\fi
	\@datefield
	\@makelettertitle
	\ifdim\useplength{subjectvpos}=\z@\if@subjafter\else\@subjfield\fi\fi
	{\setparsizes{\z@}{\z@}{\z@ plus 1fil}\par@updaterelative#1\par}%
	{\setlength{\@tempdima}{\baselineskip}%
	\addtolength{\@tempdima}{-\parskip}%
	\ifdim \@tempdima>\z@\vskip\@tempdima\fi}%
	\ifdim\useplength{subjectvpos}=\z@\if@subjafter\@subjfield\fi\fi
	\setcounter{equation}{0}%
	\@afterheading%
	\@nobreaktrue
	\@afterindentfalse
	\bool_if:NT \g__ptxcd_adjust_textwidth_bool {
		\everypar{%
			\if@nobreak
				\@nobreakfalse\clubpenalty\@M
				\if@afterindent
				\else{\setbox\z@\lastbox}
				\fi
			\else
				\clubpenalty\@clubpenalty
			\fi
			\ifnum\thepage=1%
			\dim_gset:Nn \g__ptxcd_page_free_dim {-\pagegoal + \pagetotal}
			\dim_compare:nTF {-\g__ptxcd_page_free_dim>2\baselineskip}
			{
				\int_gset:Nn \g__ptxcd_free_lines_int {\fp_eval:n {ceil(\g__ptxcd_page_free_dim/\baselineskip)}}
				\int_compare:nT {\g__ptxcd_free_lines_int<0} {
					\hangafter=\g__ptxcd_free_lines_int\hangindent=\c__ptxcd_firstpage_extraindent_dim%
				}
		} {
			\dim_compare:nT {-\TUD@page@free>\baselineskip} {
				\hangafter=-2\hangindent=\c__ptxcd_firstpage_extraindent_dim%
			}
		}
			\fi%
		}%
		\global\setlength{\linewidth}{\dim_eval:n {\c_ptxcd_Linewidth_dim + \c__ptxcd_firstpage_extraindent_dim}}
		\afterpage{
			\global\setlength{\linewidth}{\c_ptxcd_Linewidth_dim}
			\widowpenalty=10000
		}
	}
}

\AtBeginDocument{%
  \raggedbottom%
}

\setkomafont{backaddress}{\accentfont\tiny\ptxcd_use_premiumcolor_text:\raisebox{\dimexpr-\totalheight+\ht\strutbox\relax}{\rule{\z@}{4mm}}}

\raggedbottom

\int_new:N \l_ptxcd_letter_lastpage_int
\cs_new:Nn \ptxcd_letterpagemark: {
	%get lastpage for this letter if not already done
	\int_compare:nNnTF {\value{page}} = {1} {
			\bool_if:NTF \g__ptxcd_firstpagenumber_bool
			{\bool_set_true:N \l_tmpa_bool}
			{\bool_set_false:N \l_tmpa_bool}
		}
		{\bool_set_true:N \l_tmpa_bool}
	\bool_if:NT \l_tmpa_bool {
		\int_if_exist:cF {c_ptxcd_letter\thisletter _lastpage_int} {
			\cs_if_exist:cTF {r@\thisletter.lastpage} {
				\int_const:cn {c_ptxcd_letter\thisletter _lastpage_int} {
					\exp_args:NNc \expandafter \@secondoffive { r@\thisletter.lastpage}
				}
			} {
				%warning -> rerun latex
				\int_const:cn {c_ptxcd_letter\thisletter _lastpage_int} {0}
			}
		}
		\usekomafont{pagenumber}\pagename\nobreakspace\thepage
		\int_compare:nT {
			\int_use:c {c_ptxcd_letter\thisletter _lastpage_int}
			> 1
		} {/\int_to_arabic:n{\int_use:c {c_ptxcd_letter\thisletter _lastpage_int}}}
	}
}


\setkomavar{firstfoot}{\usekomavar{nextfoot}}

\setkomavar{nextfoot}{%
	\ifnum\@pageat>2
	\parbox[c]{\layerwidth}{%
		\ifcase\@pageat\or\or\or\raggedright\or\centering\or\raggedleft\fi
		\strut\pagemark%
	}%
	\fi
}

\cs_set_eq:NN \letterpagemark \ptxcd_letterpagemark:


\bool_if:NT \g__ptxcd_letter_headrule_bool {
	\bool_if:NTF \g__ptxcd_letter_logo_bool {
		\setkomavar{nexthead}{\raisebox{\topskip}{\box_use:N \g_TUDaLetter_firsthead_box}}
	}{
		\setkomavar{nexthead}{\raisebox{\depth}{\ptxcd_LetterheadRule}}
	}
}

\newpairofpagestyles[letter]{TUDaLetter}{
	\exp_args:Nx \KOMAoptions{
		footwidth=\dimexpr\paperwidth-2\c_ptxcd_HeadMargin_dim \c_colon_str-\dim_eval:n {\c_ptxcd_HeadMargin_dim -1mm},
		headwidth=\dimexpr\paperwidth-2\c_ptxcd_HeadMargin_dim \c_colon_str-\dim_eval:n {\c_ptxcd_HeadMargin_dim -1mm},
		footsepline=.5\c_ptxcd_smallrule_dim,plainfootsepline
	}
	\ModifyLayer[voffset=\c_ptxcd_HeadMargin_dim,align=tl]{TUDaLetter.head.even}
	\ModifyLayer[voffset=\c_ptxcd_HeadMargin_dim,align=tl]{TUDaLetter.head.odd}
	\ModifyLayer[voffset=\c_ptxcd_HeadMargin_dim,align=tl]{TUDaLetter.head.oneside}
	\ModifyLayer[voffset=\c_ptxcd_HeadMargin_dim,align=tl]{plain.TUDaLetter.head.even}
	\ModifyLayer[voffset=\c_ptxcd_HeadMargin_dim,align=tl]{plain.TUDaLetter.head.odd}
	\ModifyLayer[voffset=\c_ptxcd_HeadMargin_dim,align=tl]{plain.TUDaLetter.head.oneside}
	\lehead{\usekomavar{nexthead}}%
	\lohead{\usekomavar{nexthead}}%
	\lefoot{\usekomavar{nextfoot}}%
	\lofoot{\usekomavar{nextfoot}}%
}

\DeclarePageStyleByLayers{TUDaLetter.first}{TUDaLetter.foot.even,TUDaLetter.foot.odd,TUDaLetter.foot.oneside,TUDaLetter.foot.above.line}
\pagestyle{TUDaLetter}

\DeclarePageStyleAlias{letter.first}{TUDaLetter.first}
\def\letterpagestyle{TUDaLetter}

%pdfa
\if_bool:N \g_ptxcd_pdfx_bool
	\PassOptionsToPackage{a-2b}{pdfx}
% Workaround posted by David Carlisle on tex.stackexchange
% Thanks to Ulrike Fischer for mentioning it in #472
	\let \__ptxcd_grouplevel_before_pdfx: \currentgrouplevel
	\chardef\currentgrouplevel0
	\ExplSyntaxOff
	\RequirePackage{pdfx}
	\ExplSyntaxOn
	\let \currentgrouplevel \__ptxcd_grouplevel_before_pdfx:
	\cs_undefine:N \__ptxcd_grouplevel_before_pdfx:
% end of the workaround
	%%hyperref
	\hypersetup{hidelinks, unicode}
	\iow_new:N \ptxcd_xmpdata_stream

	\cs_if_exist:NF \prop_gput_if_new:Nnx {
		\cs_generate_variant:Nn \prop_gput_if_new:Nnn {Nnx}
	}
	\cs_if_exist:NF \tl_to_str:V {\cs_generate_variant:Nn \tl_to_str:N {V}}

	\cs_new:Nn \ptxcd_pass_TitleData: {
		\prop_if_empty:NF \g_ptxcd_MetaData_prop {
		\iow_open:Nn \ptxcd_xmpdata_stream {\jobname.xmpdata}
		\begingroup
		\def\newline{}
		\def\\{}
		\let\thanks\use_none:n
		\cs_set:Npn \and {\exp_not:N \sep}
		\use:c {pdfx@localcommands}
		\prop_map_function:NN \g_ptxcd_MetaData_prop  \ptxcd_write_xmp_line:nn
		\endgroup
		\iow_close:N  \ptxcd_xmpdata_stream
		}
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
			\msg_error:nnn{tudaletter} {unknown-metadata} {#1}
		}
	}

	\bool_new:N \g_ptxcd_pass_TitleData_bool
	\bool_gset_true:N  \g_ptxcd_pass_TitleData_bool
	\prop_new:N \g_ptxcd_MetaData_prop

	\newcommand*{\Metadata}[1]{
		\bool_gset_false:N \g_ptxcd_pass_TitleData_bool
		\prop_gset_from_keyval:Nn \g_ptxcd_MetaData_prop {#1}
	}

	\msg_new:nnnn{tudaletter} {unknown-metadata} {
		You~ used~ the~ #1~ metadata~ entry.\\
		I~ don't~ know~ how~ to~ handle~ that.\\
		It~ will~ be~ ignored.
	} {See~ TUDa-CI~ or~ pdfx~ documentation~ for~ details.}

\else:
	\PassOptionsToPackage{hidelinks, unicode}{hyperref}
	\RequirePackage{hyperref}
	\hypersetup{pdfcreator=LaTeX~using~TUDa-CI}

	\msg_new:nnnn {tudapub} {metadata-to-hypersetup} {
		You~don't~use~pdfx.~
		Here~the~\string\Metadata\~command~only~exists~for~compatibility~reasons.\\
		I~will~pass~the~data~to~ḩypersetup.
	}{
		If~possible~please~use~hyperref's~\strung\hypersetup~command~for~the~metadata~directly.\\
		See~hyperref~documentation~for~details~on~usage.
	}

	\newcommand*{\Metadata}[1]{
		\tl_set:Nn \l_tmpa_tl {#1}
		\tl_replace_all:Nnn \l_tmpa_tl {\sep} {;~}% pdfx-Syntax compatibility
		\clist_map_inline:Nn \l_tmpa_tl {
			\exp_args:Nx \hypersetup{pdf\tl_trim_spaces:n {##1}}
		}
		\msg_warning:nn {tudapub} {metadata-to-hypersetup}
	}


	\cs_new:Nn \ptxcd_pass_TitleData: {
		% check if pdfmanagement is active
		\prop_if_exist:NTF \g__pdfmanagement_documentproperties_prop {
			\prop_set_eq:NN \l_tmpa_prop \g__pdfmanagement_documentproperties_prop
		} {
			\prop_set_eq:NN \l_tmpa_prop   \g__hyp_documentproperties_prop
		}

		% title
		\prop_if_in:NnF \l_tmpa_prop {hyperref/pdftitle} {
			\begingroup
			\def\newline{}
			\def\\{}
			\let\thanks\use_none:n
			\tl_gset:Nf \g_tmpa_tl {\@title}
			\endgroup
			\hypersetup{pdftitle={\tl_to_str:V \g_tmpa_tl}}
		}

		% author
		\prop_if_in:NnF \l_tmpa_prop {hyperref/pdfauthor} {
			\begingroup
				\def\newline{}
				\def\\{}
				\let\thanks\use_none:n
				\tl_gset:Nx \g_tmpa_tl {\seq_use:Nn \g_ptxcd_author_seq {\exp_not:N \and}}
				\tl_gset:Nx \g_tmpa_tl  {\g_tmpa_tl }
			\endgroup
			\hypersetup{pdfauthor=\g_tmpa_tl}
		}
	}

	\bool_if:NF \g_ptxcd_pdfa_bool {
		\msg_new:nnn{tudapub} {no-pdfa}{The~ tudapub~ class~ won't~ create~ PDF/A-mode.}
		\msg_info:nn{tudapub} {no-pdfa}
	}

\fi:


%Widows and clubs
\widowpenalty=10000
\clubpenalty=10000

%default values
\setkomavar*{fromemail}{}
\setkomavar*{fromurl}{}
\setkomavar{backaddress}{Technische~ Universität~ Darmstadt\\Karolinenplatz~ 5\\64289~ Darmstadt}

%renewcaptions
\defcaptionname{german,ngerman,austrian,naustrian,%
	swissgerman,nswissgerman}\yourmailname{Ihre~ Nachricht}%
\defcaptionname{german, ngerman,austrian,naustrian,%
	swissgerman,nswissgerman}\phonename{Tel.}%


%signature raggedright
\let\raggedsignature\raggedright

\newkomavar{fromfunction}

\bool_if:NT \g__ptxcd_letter_raggedright_bool {\AtBeginLetter{\RaggedRight}}

%backwards compatibility for KOMA-Script
\cs_if_exist:NF \Ifkomavarempty{
	\let\Ifkomavarempty\ifkomavarempty
}

\file_if_exist_input:n {\g__ptxcd_config_prefix_tl\g_ptxcd_department_str.cfg}
\endinput
