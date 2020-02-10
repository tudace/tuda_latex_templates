\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplClass{tudaletter}
	{\filedate}{\fileversion}{Letters for TUDa-CI, Corporate Design of TU Darmstadt}

\RequirePackage{l3keys2e}

\keys_define:nn {TUDaLetter} {
	logo .bool_gset:N = \g_TUDaletter_logo_bool,
	logo .default:n = true,
	logo .initial:n = true,
	premium .bool_gset:N = \g_TUDaletter_premium_bool,
	premium .default:n = true,
	accentcolor .code:n = \PassOptionsToPackage{accentcolor=#1}{tudacolors},
	firstpagenumber .bool_gset:N = \g_TUDa_firstpagenumber_bool,
	firstpagenumber .initial:n = true,
	raggedright .bool_gset:N = \g_TUDa_raggedright_bool,
	pdfa .bool_gset:N = \g_TUDa@pdfa_bool,
	pdfa .initial:n = true,
	logofile .tl_gset:N = \g_TUDa_logofile_tl,
	logofile .initial:n = tuda_logo,
}


\ProcessKeysOptions{TUDaLetter}

\bool_if:NT  \g_TUDa@pdfa_bool {\PassOptionsToPackage{RGB}{xcolor}}


\newcommand*{\@fontsizefilebase}{tudalettersize}

\PassOptionsToClass{fontsize=10pt, refline=nodate, parskip=full-,addrfield=topaligned}{scrlttr2}
\LoadClass{scrlttr2}

% Load the TUDa-colorscheme
\RequirePackage{tudacolors}

\bool_if:NTF \g_TUDaletter_premium_bool
{	\def\TUDa@premiumcolor{accentcolor}
	\def\TUDa@use@premiumcolor{\color{accentcolor}}
	\def\TUDa@use@premiumcolor@text{\color{textaccentcolor}}
}{
	\def\TUDa@premiumcolor{black}
	\let\TUDa@use@premiumcolor\relax
	\let\TUDa@use@premiumcolor@text\relax
}



\RequirePackage{tudafonts}
\RequirePackage{graphicx}
\RequirePackage{afterpage}
\RequirePackage{ragged2e}


%%%%%Briefbogen
%% Spacing:
\dim_const:Nn \c_TuDa_HeadMargin_dim {12.5mm}
\dim_const:Nn \c_TuDa_LeftMargin_dim {24.0mm}
\dim_const:Nn \c_TuDa_RightMargin_dim  {\c_TuDa_HeadMargin_dim}
\dim_const:Nn \c_TuDa_BottomMargin_dim {\c_TuDa_LeftMargin_dim}
\dim_const:Nn \c_TuDa_Linewidth_dim {\paperwidth-\c_TuDa_LeftMargin_dim-\c_TuDa_RightMargin_dim}

\RequirePackage[heightrounded]{geometry}

\geometry{
	twoside=false,
	left=\c_TuDa_LeftMargin_dim,
	right=\c_TuDa_RightMargin_dim,
	bottom=20mm,
	footskip=3mm,
}

\dim_const:Nn \c_TUDa_textwidth_dim {\textwidth}

\bool_if:NTF \g_TUDaletter_logo_bool {
	\geometry{top=64mm}
} {
	\geometry{top=30mm}
}

\@setplength{firstheadhpos}{\c_TuDa_HeadMargin_dim}
\@setplength{firstheadvpos}{\c_TuDa_HeadMargin_dim}
\@setplength{firstheadwidth}{\dim_eval:n {\paperwidth - 2\c_TuDa_HeadMargin_dim}}

\@setplength{firstfootvpos}{\dim_eval:n {\paperheight -17mm}}
\@setplength{firstfoothpos}{\useplength{firstheadhpos}}
\@setplength{firstfootwidth}{\useplength{firstheadwidth}}


\@setplength{toaddrhpos}{\c_TuDa_LeftMargin_dim}
\@setplength{toaddrvpos}{50mm}
\@setplength{backaddrheight}{4mm}
\@setplength{toaddrindent}{0mm}

\@setplength{refhpos}{\c_TuDa_LeftMargin_dim}
\@setplength{refvpos}{106mm}

\@setplength{subjectaftervskip}{2\baselineskip}
\@setplength{lochpos}{\c_TuDa_HeadMargin_dim}
\@setplength{locvpos}{\dimexpr\useplength{refvpos}+\useplength{subjectaftervskip}+1.4\baselineskip\relax}
\@setplength{refaftervskip}{0pt}
\@setplength{subjectbeforevskip}{0pt}
\@setplength{locwidth}{\dimexpr\paperwidth-154,5mm -\c_TuDa_RightMargin_dim\relax}
\@setplength{locheight}{\dimexpr\paperheight-\useplength{locvpos}-\c_TuDa_BottomMargin_dim\relax}



\dim_const:Nn \c_TuDa_firstpage_extraindent_dim {-\paperwidth+120mm +\c_TuDa_LeftMargin_dim  +\c_TuDa_RightMargin_dim}


\RequirePackage[paper=a4]{tudarules}


\TUDa@makeheadrule[width=\useplength{firstheadwidth}, color=\TUDa@premiumcolor]{TuDa@LetterheadRule}
\TUDa@makefootrule[width=\useplength{firstheadwidth}]{TuDa@LetterfootRule}


\box_new:N \g_TUDaLetter_firsthead_box
\hbox_gset:Nn \g_TUDaLetter_firsthead_box {
	\parbox{\useplength{firstheadwidth}}{
	\raggedleft
	\smash{\TuDa@LetterheadRule}\par
	\vspace{.5\c_TUDa_logoheight_dim}
	\makebox[2.2\c_TUDa_logoheight_dim][l]{\includegraphics[height=\c_TUDa_logoheight_dim]{\g_TUDa_logofile_tl}}
	}
}

\setkomavar{firsthead}{
	\box_use:N \g_TUDaLetter_firsthead_box
}

\KOMAoptions{backaddress=plain}
\setkomavar{backaddressseparator}{\,$\vert$\,}

%DOKU neue komavars
\newkomavar{frominstitution}
\newkomavar{frominstitution-en}

\newkomafont{TUDa_location}{\accentfont\normalcolor}
\setkomafont{fromname}{\small}
\newkomafont{TUDa_frominst}{\small\TUDa@use@premiumcolor@text}
\setkomafont{fromaddress}{\footnotesize}

\setkomafont{refname}{}
\setkomafont{refvalue}{}


\newcommand{\TUD@locfield}{%
	\usekomafont{TUDa_location}\usekomafont{fromaddress}
	\setparsizes{\z@}{\z@}{\z@ plus 1fil}
	\par@updaterelative
      \begingroup
	  \usekomafont{TUDa_frominst}
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
      \seq_use:Nn  \g_TUDa_reffields_seq {}
      \Ifkomavarempty{frombank}{}{\vfill%
        \Ifkomavarempty*{frombank}{Bankverbindung}{\usekomavar*{frombank}}\\\usekomavar{frombank}
	 }
}

\setkomavar{location}{\parbox[t][.45\paperheight][t]{\useplength{locwidth}}{\TUD@locfield}}

\tl_const:Nn \TUDa@reffield_separator_tl {\\}

\cs_new:Nn \TUDa@set@reffield:n {
	\Ifkomavarempty{#1}{}{%
		\if@tempswa\\[\baselineskip]\fi
		\parbox[t]{\linewidth}{\noindent\raggedright
			\usekomafont{refname}
			\usekomavar*{#1}\TUDa@reffield_separator_tl
			\usekomafont{refvalue}
			\usekomavar{#1}
		}%
		\@tempswatrue
	}%
}



\seq_new:N  \g_TUDa_reffields_seq
\newlength{\TUD@page@free}
\newcounter{TUD@page@free@lines}

\renewcommand{\opening}[1]{%
	\widowpenalty=100
	\@PapersizeWarning
	\seq_gclear:N \g_TUDa_reffields_seq
	\renewcommand*{\@set@reffield}[1]{
		\typeout{Field: ##1}%
		\str_if_eq:nnT {##1}{datemarkerfield}{%
			\let\scr@datemarkerfield@var=\scr@date@var
			\let\scr@datemarkerfield@name=\scr@date@name
			\setkomavar{date}{}%
		}
		\Ifkomavarempty{##1}{}{%
			\seq_gput_right:Nn \g_TUDa_reffields_seq {%
				\TUDa@set@reffield:n {##1}
			}%
		}%
	}
	\let\do@set@reffield\@set@reffield
	\@set@reffields
	\removereffields
	\@gen@firsthead
	\@mkboth{\scr@fromname@var}{\scr@subject@var}%
	\thispagestyle{empty}\noindent
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
	\everypar{%
		\if@nobreak
			\@nobreakfalse\clubpenalty\@M
			\if@afterindent
			\else{\setbox\z@\lastbox}
			\fi
		\else
			\clubpenalty \@clubpenalty
		\fi
		%TODO: ifdum < 2 \baselineskip
		\ifnum\thepage=1%
		\TUD@page@free=-\pagegoal%
		\advance\TUD@page@free\pagetotal%
		\dim_compare:nTF {-\TUD@page@free>2\baselineskip}
		{
			\bool_if:NF \g_TUDaletter_logo_bool {
				\advance\TUD@page@free-.3\baselineskip
			}
			\divide\TUD@page@free\baselineskip%
			\c@TUD@page@free@lines=\TUD@page@free%
			\int_compare:nT {\value{TUD@page@free@lines}<0} {
			\hangafter=\value{TUD@page@free@lines}\hangindent=\c_TuDa_firstpage_extraindent_dim%
			}
	} {
		\dim_compare:nT {-\TUD@page@free>\baselineskip} {
			\hangafter=-2\hangindent=\c_TuDa_firstpage_extraindent_dim%
		}
	}
		\fi%
	}%
	\global\setlength{\linewidth}{\dim_eval:n {\c_TuDa_Linewidth_dim + \c_TuDa_firstpage_extraindent_dim}}
	\afterpage{
		\global\setlength{\linewidth}{\c_TuDa_Linewidth_dim}
		\widowpenalty=10000
	}
}

\AtBeginDocument{%
  \raggedbottom%
}

\setkomafont{backaddress}{\accentfont\tiny\TUDa@use@premiumcolor@text\raisebox{\dimexpr-\totalheight+\ht\strutbox\relax}{\rule{\z@}{4mm}}}
\setkomafont{pagenumber}{\tiny}

\raggedbottom

\int_new:N \l_TUDa_letter_lastpage_int
\newcommand*{\TUDa@letterpagemark}{
	%get lastpage for this letter if not already done
	\int_compare:nTF {\value{page} = 1} {
			\bool_if:NTF \g_TUDa_firstpagenumber_bool
			{\bool_set_true:N \l_tmpa_bool}
			{\bool_set_false:N \l_tmpa_bool}
		}
		{\bool_set_true:N \l_tmpa_bool}
	\bool_if:NT \l_tmpa_bool {
		\int_if_exist:cF {c_TUDa_letter\thisletter _lastpage_int} {
			\expandafter\ifx\csname r@\thisletter.lastpage\endcsname\relax
			%warning -> rerun latex
			\int_const:cn {c_TUDa_letter\thisletter _lastpage_int} {0}
			\else
			\int_const:cn {c_TUDa_letter\thisletter _lastpage_int} {
				\cs_if_exist:NTF \hypersetup
				{\exp_args:NNc \expandafter \@secondoffive { r@\thisletter.lastpage}}
				{\exp_args:NNc \expandafter \use_ii:nn { r@\thisletter.lastpage}}
			}
			\fi
		}
		\usekomafont{pagenumber}\pagename\nobreakspace\thepage
		\int_compare:nT {
			\int_use:c {c_TUDa_letter\thisletter _lastpage_int}
			> 1
		} {/\int_to_arabic:n{\int_use:c {c_TUDa_letter\thisletter _lastpage_int}}}
	}
}

\setkomavar{nextfoot}{
	\parbox{\useplength{firstfootwidth}}{\usekomafont{pagefoot}
		\raggedleft\TuDa@LetterfootRule\par\TUDa@letterpagemark}
}

\setkomavar{firstfoot}{
	\usekomavar{nextfoot}
}

%pagestyle
\RequirePackage{scrlayer}

\bool_if:NTF \g_TUDaletter_logo_bool {
	\DeclareNewLayer[
	background,
		align=tl,
		hoffset=\useplength{firstheadhpos},
		voffset=\useplength{firstheadvpos},
		width=\box_wd:N \g_TUDaLetter_firsthead_box,
		height=\box_ht:N \g_TUDaLetter_firsthead_box,
		contents={\box_use:N \g_TUDaLetter_firsthead_box}
	]{letter.head}
}{
	\DeclareNewLayer[
	background,
	align=tl,
	hoffset=\useplength{firstheadhpos},
	voffset=\useplength{firstheadvpos},
	%TODO: replace leiste logo=?
	width=\box_wd:N \TuDa@LetterheadRule_box,
	height=\box_ht:N \TuDa@LetterheadRule_box,
	contents=\TuDa@LetterheadRule
	]{letter.head}
}

\DeclareNewLayer[
	background,
	align=tl,
	hoffset=\useplength{firstfoothpos},
	voffset=\useplength{firstfootvpos},
	width=\useplength{firstfootwidth},
	height=\baselineskip,
	contents={\raisebox{\ht\strutbox}{\parbox[t]{\layerwidth}{\usekomavar{nextfoot}}}}
]{letter.foot}

\RequirePackage{tikz}
\DeclareNewPageStyleByLayers{TUDaletter}{
	letter.head, letter.foot.rule, letter.foot
}

\DeclarePageStyleAlias{letter}{TUDaletter}
\DeclarePageStyleAlias{plain.letter}{TUDaletter}

\pagestyle{plain.letter}

%pdfa
\if_bool:N \g_TUDa@pdfa_bool
\PassOptionsToPackage{a-2b}{pdfx}
\RequirePackage{pdfx}
%%hyperref
\hypersetup{hidelinks, unicode}
\iow_new:N \TUDa@xmpdata_stream
\tl_new:N \g_TUDa@xmp_title
\tl_new:N \g_TUDa@xmp_author

\cs_new:Nn \TUDa_pass_TitleData: {
	\prop_if_empty:NF \g_TUDa_MetaData_prop {
	\iow_open:Nn \TUDa@xmpdata_stream {\jobname.xmpdata}
	\begingroup
	\def\newline{}
	\def\\{}
	\let\thanks\use_none:n
	\cs_set:Npn \and {\exp_not:N \sep}
	\use:c {pdfx@localcommands}
	\prop_map_function:NN \g_TUDa_MetaData_prop  \TUDa_write_xmp_line:nn
	\endgroup
	\iow_close:N  \TUDa@xmpdata_stream
	}
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

\bool_if:NT \g_TUDa_raggedright_bool {\AtBeginLetter{\RaggedRight}}

%backwards compatibility for KOMA-Script
\cs_if_exist:NF \Ifkomavarempty{
	\let\Ifkomavarempty\ifkomavarempty
}

\endinput
