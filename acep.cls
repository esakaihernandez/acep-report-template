%  File: acep.cls v0.0
% This class file provides basic functionality for producing
% PDFs that meet ACEP's style and formatting requirements.

% -------------------------------------------------------------
% Identification Part
% -------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{acep}
\typeout{ }
\typeout{ACEP.cls -- v0.0, May 2023}
\typeout{Formats documents according to the ACEP style guide}
\typeout{ }

% -------------------------------------------------------------
% Create Options
% -------------------------------------------------------------
%% PDF properties
\pdfinterwordspaceon
\pdfminorversion=6
% for processing of conditional statements
\RequirePackage{xifthen}
% Mark as draft
\newboolean{IsDraft}
\setboolean{IsDraft}{false}
% print links in black
\newboolean{blacklinks}
\setboolean{blacklinks}{false}
% Set flag to meet NREL RAAW requirements
% true by default
\newboolean{IsNREL}
\setboolean{IsNREL}{true}
% Set flag to meet EERE RAAW requirements
\newboolean{IsEERE}
\setboolean{IsEERE}{false}
% Set flag for confidentiality statement
\newboolean{IsConfidential}
\setboolean{IsConfidential}{false}
% tagged?
\newboolean{IsTagged}
\setboolean{IsTagged}{false}
% single appendix?
\newboolean{IssingleAppendix}
\setboolean{IssingleAppendix}{false}

% -------------------------------------------------------------
% Check for choice of package and formatting options
% -------------------------------------------------------------
% look out for draft
\DeclareOption{draft}{
	\setboolean{IsDraft}{true}
	\typeout{Formatting as draft}
	}
% If EERE option is set, format as EERE RAAW
\DeclareOption{EERE}{
	\setboolean{IsEERE}{true}
	\setboolean{IsNREL}{false}
	\def\NREL@class{report}
	\typeout{Using EERE report RAAW}
}
% NREL is assumed to be true by default
% unless switched off by EERE flag
\ifthenelse{\boolean{IsNREL}}{ 
	\def\NREL@class{report}
	\typeout{Using NREL report RAAW}
}{}
% If tagged option is set, format as tagged pdf
\DeclareOption{tagged}{
	\setboolean{IsTagged}{true}
	\typeout{PDF will be tagged}
	}
% If confidential option is set, add confidentiality statement
\DeclareOption{confidential}{
	\setboolean{IsConfidential}{true}
	\typeout{Confidentiality statement added to title page and headers}
	}
% report has single appendix, change formatting
\DeclareOption{singleAppendix}{
	\setboolean{IssingleAppendix}{true}
	\typeout{Changing format for single appendix}
	}

% -------------------------------------------------------------
% Process Options
% -------------------------------------------------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\NREL@class}}
\ExecuteOptions{12pt}
\ProcessOptions\relax
\LoadClass{\NREL@class}

% -------------------------------------------------------------
% Package Loading
% -------------------------------------------------------------

% titlepage stu
\RequirePackage{titling}
\RequirePackage{datetime}
\newdateformat{monthyeardate}{%
  \monthname[\THEMONTH], \THEYEAR}
% for multiple authors/affils
\RequirePackage{authblk}
% NAG: check for outdated packages
\RequirePackage[l2tabu, orthodox]{nag}
% GEOMETRY: set page size
% \RequirePackage[head=0.125in,top=0.9in,bottom=1in,inner=1in,outer=1in,includefoot]{geometry}
\RequirePackage[letterpaper, top=0.5in,bottom=1in,inner=1in,outer=1in,includefoot]{geometry}
% MATHPTMX Times for roman text and math (family ptm)
\RequirePackage{mathptmx}
% Helvetica for sans serif (family phv)
\RequirePackage[scaled=0.83]{helvet}
% Courier for typewriter font (family pcr)
\RequirePackage{courier}
% ams math
\RequirePackage{amsfonts,amssymb,amsmath}
% gensymb. Required for degrees symbol
\RequirePackage{gensymb}
% % better tables
\RequirePackage{booktabs}
% \RequirePackage{tabularx}
% For including figures, ignoring the draft status
\RequirePackage[final]{graphicx}
% use fonts of type T1
\RequirePackage[T1]{fontenc}
% colours
\RequirePackage{xcolor}
\definecolor{UAFblue}{RGB}{35, 97, 146}
\definecolor{UAFyellow}{RGB}{255, 205, 0}
% set languages
\RequirePackage[english]{babel}
% To stop hyphenation in titles etc
\RequirePackage{hyphenat}
% spacing
\RequirePackage{setspace}
\RequirePackage{parskip}
% to-do notes
\RequirePackage{todonotes}
% code listings
\RequirePackage{listings}
\RequirePackage[utf8]{inputenc}
\RequirePackage{etoolbox}
\RequirePackage[]{titlesec}
\RequirePackage[title,titletoc]{appendix}
%% ----------------------------
%% References section 
%% ----------------------------
% For formatting the bibliography. See guidance 


\RequirePackage[babel]{csquotes}

\RequirePackage[ %footnote-based citations
    style=verbose,
    backend=biber,
    natbib=true,
    sorting=nyt,
    doi=true, 
]{biblatex}

%\RequirePackage[ %Chicago author-year citations
%	style=chicago-authordate,
%	strict,backend=bibtex,
%	natbib=true,
%	bibencoding=inputenc,
%	sorting=nyt,
%	doi=true, 
%	maxbibnames=10,
%	giveninits=true, 
%	maxcitenames=3,
%]{biblatex}
% change the name of the bib 
% (see http://tex.stackexchange.com/questions/82993/how-to-change-the-name-of-document-elements-like-figure-contents-bibliogr)
\DefineBibliographyStrings{american}{%
  bibliography = {References},
}
% fix spacing between heading and references
\AtBeginBibliography{
	% \titleformat{\chapter}{\fontsize{18pt}{0pt}\bfseries\selectfont}
	% \vspace*{12pt}
	}
% see NREL formatting guidelines at 
% https://communications_resources.nrel.gov/style_guide/references
% technical reports
\DeclareBibliographyAlias{techreport}{book}
% make one type of publication look like another
% map unknown bibliography entry types to the misc type
\DeclareBibliographyAlias{*}{misc} 
% make sure URLs in the bibliography are shown in roman fonts
\urlstyle{same}

% --------------------------------------------------------
% Main Code
% --------------------------------------------------------
% NREL default is ragged right.
% Load ragged2e so \justifying and environment justify are available.
% Redefines \centering, \raggedleft, and \raggedright, and environments center
% flushleft and flushright to use versions made by ragged2e. 
% Sets default alignment to ragged right. 
% To override, use the command \justifying or the environment justify.
\RequirePackage[newcommands,document]{ragged2e}

%This changes parindent to 0
\setlength{\RaggedRightRightskip}{0pt plus 3em}


% -------------------------------------------
% Changes to TOC and list of figures/tables
% -------------------------------------------
% improved table of contents and list of figures/tables
\RequirePackage{tocloft}
% remove numbering on bibliography but still allow in TOC
\RequirePackage[nottoc, notlot, notlof]{tocbibind}

% add Figure before # and a period after
\renewcommand{\cftfigfont}{\fontfamily{phv} Figure }
\renewcommand{\cfttabfont}{\fontfamily{phv} Table }
\renewcommand{\cftfigaftersnum}{.}
\renewcommand{\cfttabaftersnum}{.}

% title font
\renewcommand{\cfttoctitlefont}{\color{UAFblue} \raggedright  \fontsize{18}{6}\sffamily\bfseries}
\renewcommand{\cftloftitlefont}{\color{UAFblue} \raggedright  \fontsize{18}{6}\sffamily\bfseries}
\renewcommand{\cftlottitlefont}{\color{UAFblue} \raggedright  \fontsize{18}{6}\sffamily\bfseries}
\renewcommand{\cftchapfont}{ \fontsize{10pt}{10pt}\sffamily\bfseries}
\renewcommand{\cftsecfont}{ \fontsize{11pt}{11pt}}
\renewcommand{\cftsubsecfont}{ \fontsize{11pt}{11pt}}

% linespacing in the TOC
\setlength\cftparskip{-2pt}
\setlength\cftbeforechapskip{2pt}
\setlength\cftbeforesecskip{2pt}
\setlength\cftbeforesubsecskip{2pt}
\setlength\cftaftertoctitleskip{-6pt}

% Rename the title of contents
\addto{\captionsenglish}{\renewcommand*{\contentsname}{\fontsize{18}{18} Table of Contents}}
% add dotfill in toc
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}

% remove indentation
\setlength{\cftfigindent}{0pt}
\setlength{\cfttabindent}{0pt}

% don't add extra spaces in list of figures between chapters
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{lof}{\protect\noaddvspace}
\addtocontents{lot}{\protect\noaddvspace}
\setlength{\cftbeforefigskip}{5pt}
\setlength{\cftbeforetabskip}{5pt}
\setlength{\cftaftertoctitleskip}{0pt}
\setlength{\cftafterloftitleskip}{0pt}
\setlength{\cftafterlottitleskip}{0pt}

% -------------------------------------------
% Changes to the chapter and section markings
% -------------------------------------------
% Chapter Headings
\renewcommand{\@makechapterhead}[1]{%
	\vspace*{-20\p@}%
	{\color{UAFblue} \parindent \z@ \raggedright \normalfont \interlinepenalty\@M
	\ifnum \c@secnumdepth >\m@ne
		\fontfamily{phv} \fontsize{18}{6}\fontseries{b}\selectfont
		\thechapter \hspace*{1em}#1
		\else
		\fontfamily{phv} \fontsize{18}{6}\fontseries{b}\selectfont #1
	\fi
	\par\nobreak
	% \vspace*{0pt}
	}}
\renewcommand{\@makeschapterhead}[1]{%
	\vspace*{-20\p@}%
	{\color{UAFblue} \parindent \z@ \raggedright \normalfont \interlinepenalty\@M
	\Large\sffamily\bfseries #1
	\par\nobreak
	% \vspace*{-12pt}
	}
	}

% Section Headings
\renewcommand{\section}{%
	\@startsection{section}{1}{\z@}
	{-3.25ex \@plus -1ex \@minus -.2ex}
	{0.25ex \@plus .2ex}
	{\color{UAFblue}\fontfamily{phv}\fontsize{14}{14}\fontseries{b}\selectfont}}
\renewcommand{\subsection}{%
	\@startsection{subsection}{2}{\z@}
	{-3.25ex \@plus -1ex \@minus -.2ex}
	{0.25ex \@plus .2ex}
	{\color{UAFblue}\sffamily\normalsize\bfseries\slshape}}
\renewcommand{\subsubsection}{%
	\@startsection{subsubsection}{3}{\z@}
	{-3.25ex \@plus -1ex \@minus -.2ex}
	{0.25ex \@plus .2ex}
	{\color{UAFblue}\sffamily\normalsize\itshape}}
\renewcommand{\paragraph}{%
	\@startsection{paragraph}{4}{\z@}
	{-3.25ex \@plus -1ex \@minus -.2ex}
	{0.25ex \@plus .2ex}
	{\bfseries\normalsize}}
\renewcommand{\subparagraph}{%
	\@startsection{subparagraph}{5}{\z@}
	{-3.25ex \@plus -1ex \@minus -.2ex}
	{0.25ex \@plus .2ex}
	{\bfseries\normalsize\itshape}}

% \renewenvironment{table}
% 	{\@float{table} \fontfamily{phv}\selectfont}
% 	{\end@float}
% inherit fonts etc from TOC
\let\printlottitle\printtoctitle
\let\printloftitle\printtoctitle

% % Format Captions
% % see e.g. http://www.peteryu.ca/tutorials/publishing/latex_captions for details of how to adjust
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup[table]{font={small,sf,bf},
	labelfont={small,sf,bf},
	textfont={small,sf,bf},
	position=above,
	labelsep=period,
	justification=centering,
	singlelinecheck=true}
\captionsetup[figure]{font={small,sf,bf},
	labelfont={small,sf,bf},
	textfont={small,sf,bf},
	position=below,
	labelsep=period,
	justification=centering,
	singlelinecheck=true,
	belowskip=-12pt,
	aboveskip=12pt}

% number figures and tables continuously across chapters
\RequirePackage{chngcntr}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\counterwithout{footnote}{chapter}

\RequirePackage{footmisc}
\renewcommand{\footnotelayout}{\fontsize{10pt}{10pt}}
\renewcommand{\footnoterule}{% Kerns avoid vertical space
  \kern -3pt                         % This -3 is negative
  \hrule width 0.3\textwidth height 0.4pt % of the sum of this 1
  \kern 10pt}                         % and this 2
% \renewcommand{\thefootnote}{\fnsymbol{\fontsize{10pt}{10pt}footnote}}

% Note that if we use the front matter / main matter, we have to change numbers
% need to renew the front, main, and back matter commands
\makeatletter
	\newcommand{\frontmatter}{%
		\renewcommand\thechapter{\hspace{-1.65ex}}
		\pagenumbering{roman} %
		\setcounter{page}{3} %
		\setcounter{figure}{0} %
		\renewcommand{\thefigure}{\Alph{figure}} %
		\setcounter{table}{0} %
		\renewcommand{\thetable}{\Alph{table}}
	}
	\newcommand{\mainmatter}{%
		\clearpage %
		\renewcommand\thechapter{\arabic{chapter}}
		\setcounter{chapter}{0} %
		\pagenumbering{arabic} %
		\setcounter{figure}{0} %
		\renewcommand{\thefigure}{\arabic{figure}} %
		\setcounter{table}{0} %
		\renewcommand{\thetable}{\arabic{table}}%
		\setlength\parskip{10pt}
	}
	\newcommand{\backmatter}{}
\makeatother

% deal with the appendix
\renewcommand\appendix{\par
	\setcounter{chapter}{0} 
	\setcounter{section}{0}
	\setcounter{footnote}{0} 
	% counters should reset each chapter
	\counterwithin{figure}{chapter}
	\counterwithin{table}{chapter}
	% footnote formatting
	\renewcommand*{\thefootnote}{\fnsymbol{\fontsize{10pt}{10pt}footnote}}
}

\ifthenelse{\boolean{IssingleAppendix}}{ % true
	\AtBeginEnvironment{appendices}{
		\titleformat{\chapter}{\fontfamily{phv}\fontsize{18}{0}\selectfont\bfseries}{\textcolor{UAFblue}
		{Appendix}}{11pt}{\textcolor{UAFblue}}
		\titlespacing*{\chapter}{0pt}{-20pt}{-6pt}
		} %<--------- Use this if only one appendix	
	\newcommand{\appchapter}[1]{
	\chapter*{Appendix\hspace{11pt} #1}
    \addcontentsline{toc}{chapter}{{Appendix\hspace{11pt} #1}}}
	}
	{% False
	\AtBeginEnvironment{appendices}{
		\titleformat{\chapter}{\fontfamily{phv}\fontsize{18}{0}\selectfont\bfseries}{\textcolor{UAFblue}
  		{Appendix \thechapter}}{11pt}{\textcolor{UAFblue}}
		\titlespacing*{\chapter}{0pt}{-20pt}{-6pt}
		  } %<--------- Use this if more than one appendix
	\newcommand{\appchapter}[1]{
		\chapter{#1}}
	}


% check that the default san-serif font is sort-of-arial				
% (required for tables)					
% \renewcommand{\sfdefault}{phv} % Arial
% Indenting and spacing between paragraphs
\setlength{\parindent}{0pt}

%-----------------------
% GENERAL CODE
%-----------------------
% Require at least 3 characters before a hyphenation.
\lefthyphenmin=3

% Don't hyphenate the months (or any proper noun---other proper nouns must be addressed in the tex file
\hyphenation{January February April July August September October December Department Energy National Renewable Laboratory Washington Colorado Standard}

% Enumerate list environment -- change the default numbering to match our style
\renewcommand{\theenumi}{\arabic{enumi}}
\renewcommand{\theenumii}{\Alph{enumii}}
\renewcommand{\theenumiii}{\roman{enumiii}}
\renewcommand{\theenumiv}{\alph{enumiv}}
\renewcommand{\labelenumi}{\theenumi.}
\renewcommand{\labelenumii}{\theenumii.}
\renewcommand{\labelenumiii}{\theenumiii.}
\renewcommand{\labelenumiv}{\theenumiv)}

% Draft mode
\ifthenelse{\boolean{IsDraft}}{ % tue
	\RequirePackage{draftwatermark}
	\SetWatermarkAngle{60}
	\SetWatermarkLightness{0.875}
	\SetWatermarkFontSize{6cm}
	\setboolean{blacklinks}{false}
	}{% False
	}

% % Add .pdf links
% \ifthenelse{\boolean{blacklinks}}{% True
% 	\RequirePackage[
% 		final, 
% 		pdfa, 
% 		linktocpage, 
% 		colorlinks, 
% 		linktoc=all, 
% 		linkcolor=black, 
% 		citecolor=black, 
% 		menucolor=black, 
% 		urlcolor=black, 
% 		pdfborder={0 0 0}, 
% 		unicode, 
% 		pdflang={en-US}
% 	]{hyperref}
% }{% False
% 	\RequirePackage[
% 		final, 
% 		pdfa, 
% 		linktocpage, 
% 		colorlinks, 
% 		linktoc=all, 
% 		linkcolor=black, 
% 		citecolor=UAFblue, 
% 		menucolor=black, 
% 		urlcolor=UAFblue, 
% 		pdfborder={0 0 0},
% 		unicode, 
% 		pdflang={en-US}
% 	]{hyperref}
% }

% Enable tooltips
\RequirePackage[linewidth = 0]{pdfcomment}

%%%#TODO review verbatim/listings code
%% ----------------------------
%% CODE / VERBATIM
%% ----------------------------
% \@ifundefined{lstlisting}{}{%
% 	\let\verbatim\relax%
% 	\lstnewenvironment{verbatim}{\lstset{language=[LaTeX]TeX,                     % the language of the code
% 		basicstyle=\small\sffamily,
% 		numbers=none,                   % where to put the line-numbers
% 		numberstyle=\tiny\color{gray},  % the style that is used for the line-numbers
% 		stepnumber=1,                   % the step between two line-numbers. If it's 1, each line will be numbered
% 		numbersep=5pt,                  % how far the line-numbers are from the code
% 		backgroundcolor=\color{white},  % choose the background color. You must add \usepackage{color}
% 		showspaces=false,               % show spaces adding particular underscores
% 		showstringspaces=false,         % underline spaces within strings
% 		breaklines=true,                % sets automatic line breaking
% 		breakatwhitespace=true,        % sets if automatic breaks should only happen at whitespace
% 		keywordstyle=\color{blue},      % keyword style
% 		commentstyle=\color{gray},   % comment style
% 		stringstyle=\color{green},      % string literal style
% 		escapeinside={\%*}{*)},         % if you want to add a comment within your code
% 		morekeywords={*,...}}%            % if you want to add more keywords to the set
% 	}{}%
% }

%%#TODO update the page format (fancy head/foot)
%% ----------------------------
%% ACCESSIBILITY
%% ----------------------------
\ifthenelse{\boolean{IsTagged}}{% True
	\RequirePackage[tagged,highstructure]{accessibility}
}{}

% need to add page number and availability information to every page, including new chapters.
\RequirePackage{fancyhdr}
% \fancyhf{} % clear all header and footer fields
\ifthenelse{\boolean{IsConfidential}}{%IsConfidential==True
	\fancypagestyle{acep}{%
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{\thepage\\\vspace{1em} \textbf{The contents of the report are confidential} }}
}{%IsConfidential==False
	\fancypagestyle{acep}{%
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{\thepage\\\vspace{1em} \fontsize{10pt}{10pt}\sffamily \textcolor{lightgray}{This report is available at no cost from the Alaska Center for Energy and Power (ACEP) at the University of Alaska, Fairbanks (UAF) at \underline{\href{www.uaf.edu/acep/our-resources/index.php}{www.uaf.edu/acep/our-resources/index.php}}}}
}


	% \renewcommand{\headrulewidth}{0.5pt}
	% \renewcommand{\headrule}{\hbox to\headwidth{%
	% 		\color{UAFblue}\leaders\hrule height \headrulewidth\hfill}}
	
	% \renewcommand{\footrulewidth}{0.5pt}
	% \renewcommand{\footrule}{\hbox to\headwidth{%
	% 		\color{UAFblue}\leaders\hrule height \headrulewidth\hfill}}
% \thispagestyle{acep}
% \pagestyle{acep}
}

\appto\frontmatter{\pagestyle{acep}}                                       
\appto\mainmatter{\pagestyle{acep}}                                        
\appto\backmatter{\pagestyle{empty}}   

% note that the first page of a chapter uses "plain", so we need to redefine that to match the "acep" page style.
% \let\ps@plain\ps@acep



%% command to scrape authors from authblk (without affils or markers)
\RequirePackage{xstring}
\RequirePackage{hyperref}

\typeout{TEST LOCATION}
\makeatletter
\typeout{AB@authlist}
\pdfstringdef\cleanlist{\AB@authlist}
\makeatother
\StrDel{\cleanlist}{1}[\cleanlist]
\StrDel{\cleanlist}{2}[\cleanlist]
\StrDel{\cleanlist}{3}[\cleanlist]
\StrDel{\cleanlist}{4}[\cleanlist]
\StrDel{\cleanlist}{5}[\cleanlist]

%% add pdf title and authors
\makeatletter
\typeout{\cleanlist}
\hypersetup{
	final, 
	linktocpage, 
	colorlinks=false, 
	linktoc=all, 
	linkcolor=black, 
	citecolor=UAFblue, 
	menucolor=black, 
	urlcolor=UAFblue, 
	pdfborder={0 0 0},
	unicode, 
	pdflang={en-US},
	pdftitle=\@title,
	pdfauthor={Nicholas Hamilton}
	% pdfauthor={\cleanlist}
}
\makeatother


%% format of make title (title, authors, affils)
\makeatletter
	\renewcommand{\maketitle}{\bgroup\setlength{\parindent}{0pt}
	\null
	\vskip 2em%
	\begin{flushright}
		\fontfamily{phv}
		\textbf{\huge{\@title}}
		\vskip 1.5em%
		\large{\@author}
		\vskip 4em%
	\end{flushright}
	\egroup
	}
\makeatother


%#TODO add ifthenelse statement to change from NREL cover page to EERE cover page
%% THINGS WE NEED TO DO AT THE START OF THE DOCUMENT
\AtBeginDocument{
	\setlength{\headsep}{6em}

	% -------------------------------------
	% hard-coded formatting for title page
	% * no changes needed *
	% -------------------------------------
	\thispagestyle{empty}		
	\centering
	  \vspace*{-8em}
   \includegraphics[width=\textwidth]{Figures/ACEP_report_bannerV4.png}\\
   %\includegraphics[width=1.4\textwidth]{ACEP_report_bannerV4.png}\\
   \vspace*{1em}
	  \includegraphics[width=\textwidth]{Figures/paper_banner.JPG}\\
	\vspace*{4em}
	\begin{flushright}
		\begin{minipage}{\textwidth}
			\maketitle	
		\end{minipage}
%        \end{flushright}
        \vfill
        %\includegraphics[width=0.5\textwidth]{ACEP-logo-sm.png}\\
        %\includegraphics[width=0.25\textwidth]{uaf_logo.png}\\
%		\\	
%		\vfill
		\begin{minipage}[b]{\textwidth}
               %\includegraphics[width=\textwidth]{ACEP-logo-sm.png}\\
			\begin{minipage}[b]{\textwidth}
				\large{\textbf{Technical Report}}\\ 
				UAF/ACEP/TP-XX-XXXX\\ %UAF/ACEP/TP(technical paper) - program code - report number
				%Date
                June 2023\\
                \vspace*{1em}
                \large{Suggested Citation:}\\
                E. Xample, "Title," Alaska Center for Energy and Power, University of Alaska, Fairbanks, 2023. UAF/ACEP/TP-XX-XXXX. AddLink.edu\\
                % PSI Program: UAF/ACEP/TP-01-0001
                % Solar Program: UAF/ACEP/TP-02-000X
                % PMEC: UAF/ACEP/TP-03-000X
                % Energy Economics: UAF/ACEP/TP-04-XXXX
                DOI:XXXXX
                % Upload your document to Zenodo.org and get a DOI from there. Paste it here.
			\end{minipage}
		\end{minipage}
	\end{flushright}
	\raggedright
 \newpage
 \begin{center}
 \textbf{Notice}
 \end{center}
 
 The University of Alaska Fairbanks is an affirmative action/equal opportunity employer and educational institution. UAF does not discriminate on the basis of race, religion, color, national origin, citizenship, age, sex, physical or mental disability, status as a protected veteran, marital status, changes in marital status, pregnancy, childbirth or related medical conditions, parenthood, sexual orientation, gender identity, political affiliation or belief, genetic information, or other legally protected status. The University's commitment to nondiscrimination, including against sex discrimination, applies to students, employees, and applicants for admission and employment. Contact information, applicable laws, and complaint procedures are included on UA's statement of nondiscrimination available at www.alaska.edu/nondiscrimination/.

 This report is available at no cost from the Alaska Center for Energy and Power (ACEP) at the University of Alaska, Fairbanks (UAF) at www.uaf.edu/acep/our-resources/index.php.

 This template is based off of the National Renewable Energy Laboratory Report Template, which is available at no cost at www.nrel.gov/comm-standards/editorial/report-template.html.

Cover Photo by Jeff Fisher. % Change the name if using a different cover photo.

}

% end of file
