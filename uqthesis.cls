% uqthesis.cls - University of Queensland PhD Thesis LaTeX Class File.

% Copyright (C) 2004 Paul Cochrane
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uqthesis}[2004/12/01 University of Queensland thesis LaTeX class]

% ifthenelse for if loops
\RequirePackage{ifthen}

% is the thesis for Phd or Honours?  Default is PhD
\newcommand{\degreetext}{for the degree of Doctor of Philosophy}
\DeclareOption{phd}{\renewcommand{\degreetext}%
{for the degree of Doctor of Philosophy}}
\DeclareOption{honours}{\renewcommand{\degreetext}%
{in partial fulfilment of the degree of Bachelor of Science with Honours}}

% print a copyright page on the back of the title page?
\newboolean{copyrightpage}
\setboolean{copyrightpage}{false}
\DeclareOption{copyrightpage}{\setboolean{copyrightpage}{true}}

% print ``Examiner's copy'' on the title page?
\newboolean{examinerscopy}
\setboolean{examinerscopy}{false}
\DeclareOption{examinerscopy}{\setboolean{examinerscopy}{true}}

% use small caps for the title text?
\newboolean{titlesmallcaps}
\setboolean{titlesmallcaps}{false}
\DeclareOption{titlesmallcaps}{\setboolean{titlesmallcaps}{true}}

% finished processing options
\ProcessOptions\relax

% load the book class using a4paper
\LoadClass[12pt,a4paper]{book}

% set up margins (these are worked out from info from Printery)
\setlength{\oddsidemargin}{-1in}   \setlength{\evensidemargin}{-1in}
\addtolength{\oddsidemargin}{25mm} \addtolength{\evensidemargin}{20mm}
\setlength{\marginparwidth}{40pt}  \setlength{\marginparsep}{10pt}
\setlength{\topmargin}{-5mm}       \setlength{\headsep}{0.5in}
\setlength{\textheight}{227mm}     \setlength{\textwidth}{165mm}

\brokenpenalty=10000   % dunno what this does, maybe handy

% this stops one figure taking up a whole page and lets more text onto
% the one page when a figure exists
\renewcommand\floatpagefraction{0.8} %   Default = 0.5

% macros for defining the department, various dates and the title and
% author of the thesis.
\def\department#1{\gdef\@department{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}} % \author, \title in report
\def\@title{}
\def\@author{}
\def\@submitdate{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
\def\@copyrightyear{\number\the\year}

%%% load the required packages
% fancyhdr for nice, fancy headings
\RequirePackage{fancyhdr}
% ccaption for good caption handling
\RequirePackage{ccaption}
% xspace so that spaces after commands are handled correctly
\RequirePackage{xspace}

% This constructs the standard UQ title page
\def\titlep{%
    \thispagestyle{empty}%
    \null\vskip1in%
    \begin{center}
        \ifthenelse{\boolean{titlesmallcaps}}
            {\huge\sc\expandafter{\@title}} % put in small caps
            {\Large\uppercase\expandafter{\@title}} % use standard title
    \end{center}
    \vfill
    \begin{center}
        \textrm{By}\\
        \vskip.5in
        \textrm{\@author}\\
    \end{center}
    \vskip1in
    \begin{center}
        \textsc{A thesis submitted to the University of Queensland\\
        \degreetext{}\\
        Department of \expandafter{\@department}\\
        \@submitdate\\}
    \end{center}
    \ifthenelse{\boolean{examinerscopy}}{%
        \begin{center}
            \vskip1in
            {\LARGE \textsc{Examiner's Copy}}
        \end{center}%
        }{}
    \vfill
    \vskip.5in\newpage}

% this defines the signature for the signature page where the standard
% UQ declaration is put
%%% begin: original uqthesis.sty
\long\def\signature#1{%
\begin{center}
\begin{minipage}{4in}
\parindent=0pt
Except where acknowledged in the customary manner, the material
presented in this thesis is, to the best of my knowledge, original and
has not been submitted in whole or part for a degree in any university.
\par
\vspace{.5in}
\hbox to 4in{\hfil\shortstack{\vrule width 3in height 0.4pt\\#1}}
\end{minipage}
\end{center}}
%%% end: original uqthesis.sty

% this is the actual signature page
%%% begin: original uqthesis.sty
\def\signaturepage{%
	\vskip.5in
	\signature{\@author}}
%%% end: original uqthesis.sty

% now put in the titlepage
% (bit of a misnomer really, as it is really the first three or four pages.
\def\titlepage{%
    \pagenumbering{roman}  % make sure that front matter is numbered roman
    \titlep
    \ifthenelse{\boolean{copyrightpage}}{%
        \newpage
        \vspace*{\fill}
        \begin{center}
            \copyright{} \@author, \@copyrightyear.
        \end{center}
        \begin{center}
            Typeset in \LaTeXe{}.
        \end{center}
        \normalsize
        \newpage
        \signaturepage}{}
}

% improved version of caption handling
\usepackage{ccaption}
\captionnamefont{\scshape}
\captionstyle{}
\makeatletter
\renewcommand{\fnum@figure}[1]{\quad\small\textsc{\figurename~\thefigure}:}
\renewcommand{\fnum@table}[1]{\quad\small\textsc{\tablename~\thetable}:}
\renewcommand{\@makecaption}[2]{%
\vskip\abovecaptionskip
\sbox\@tempboxa{#1: #2}%
\ifdim \wd\@tempboxa >\hsize
  \def\baselinestretch{1}\@normalsize
  #1: #2\par
  \def\baselinestretch{1.5}\@normalsize
\else
  \global \@minipagefalse
  \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
\fi
\vskip\belowcaptionskip}
\makeatother

% set the pagestyle to look good
\pagestyle{fancy}

%%%%% Fancyhdr stuff
% give the header a bit more room, otherwise LaTeX will spew on each page
\addtolength{\headheight}{2.5pt}
% define how headers are marked, for details, see fancyhdr docs
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}

% define where sections, chapters and pagenumbers are put
% see fancyhdr docs for details
% the \nouppercase stops book.cls making the contents, bibliography
% and index headers from being all in uppercase.
% The options used here are essentially that in Lamport's book, but
% with small caps for the headings.
\fancyhf{}
\fancyhead[LE,RO]{\nouppercase{\thepage}}
\fancyhead[LO]{\sc \nouppercase{\rightmark}}
\fancyhead[RE]{\sc \nouppercase{\leftmark}}

%%% other settings required for a thesis
% It's a references section, not a bibliography, hence redefine
% \bibname i.e. change ``Bibliography'' to ``References''
\renewcommand*{\bibname}{References}

% use 1.5 line spacing for the examiners copy
% single line spacing for the final copy
\ifthenelse{\boolean{examinerscopy}}{%
\renewcommand{\baselinestretch}{1.5}}%
{\renewcommand{\baselinestretch}{1}}
