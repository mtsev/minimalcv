%%  minimalcv.cls
%%  Resume and cover letter template. Extends article class.
%%  Mandy Tao, March 2023


%---------------------------------------------------------------------
%                Identification
%---------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{minimalcv}[2023-03-21 v1.0.0 Minimal CV class]


%---------------------------------------------------------------------
%                Class options
%---------------------------------------------------------------------
% Declare any class options here.
% ...

% Set default options, and pass all unknown to article class.
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ExecuteOptions{a4paper,10pt}
\ProcessOptions\relax

% Extend article as base class.
\LoadClass{article}

%---------------------------------------------------------------------
%                Packages
%---------------------------------------------------------------------
% Standard encoding
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Language settings
\RequirePackage[UKenglish]{babel}
\RequirePackage[UKenglish]{isodate}
\cleanlookdateon

% Margin settings
\RequirePackage{geometry}

% Text settings
% \RequirePackage{parskip}
\RequirePackage{setspace}

% if... then... else... constructs
\RequirePackage{ifthen}

% String comparison
\RequirePackage{stringstrings}

% Calculate lengths
% \RequirePackage{calc}

% Graphics for signature
\RequirePackage{graphicx}

% Hyperlinks
\RequirePackage[hidelinks]{hyperref}
\urlstyle{same}


%---------------------------------------------------------------------
%                Base layout configuration
%---------------------------------------------------------------------
% Page settings
\geometry{vmargin=1.2cm, hmargin=2cm}
\pagestyle{empty}

% Text settings
\raggedright
\renewcommand{\arraystretch}{1.1}


%---------------------------------------------------------------------
%                Profile command definitions
%---------------------------------------------------------------------
% elements
\newcommand*{\name}[2]{
    \def\@firstname{#1}\def\@lastname{#2}
    \author{\@firstname~\@lastname}
}
\newcommand*{\signature}[2][2.5em]{
    \def\@signaturesize{#1}
    \def\@signatureimage{#2}
}
\renewcommand*{\title}[1]{\def\@title{#1}}
\newcommand*{\city}[1]{\def\@city{#1}}
\newcommand*{\phone}[1]{\def\@phone{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}
\newcommand*{\homepage}[2]{\def\@homepage{#1}\def\@homepagetitle{#2}}

% makes a generic hyperlink
% usage: \link[optional text]{link}
\newcommand*{\link}[2][]{
    \ifthenelse{\equal{#1}{}}
        {\href{#2}{#2}}
        {\href{#2}{#1}}
}

% makes a http hyperlink
% usage: \httplink[optional text]{link}
\newcommand*{\httplink}[2][]{
    \ifthenelse{\equal{#1}{}}
        {\href{https://#2}{#2}}
        {\href{https://#2}{#1}}
}

% makes an email hyperlink
% usage: \emaillink[optional text]{link}
\newcommand*{\emaillink}[2][]{
    \ifthenelse{\equal{#1}{}}
        {\href{mailto:#2}{#2}}
        {\href{mailto:#2}{#1}}
}

% makes profile section as document letterhead
% usage: \makeprofile
\newcommand*{\makeprofile}{
    \begin{center}
    	{\Huge \scshape {\@firstname~\@lastname}}\\
        \vspace{2mm}
    	\@city~$\cdot$~\emaillink{\@email}~$\cdot$~{\@phone}\\
    \end{center}
}


%---------------------------------------------------------------------
%                Resume command definitions
%---------------------------------------------------------------------
% --- Common
% define environment for resume
\newenvironment{cv}{
    \clearpage
    \makeprofile
}{}

% make section header
\newcommand{\cvheader}[1]{
    {\hspace*{-18pt}\vspace*{6pt} \textsc{#1}}
    \vspace*{-14pt} \\
    \hspace*{-18pt} \hrulefill
}

% define environment for a generic cv section
\newenvironment{cvsection}[1][Section]{
    \cvheader{#1}\\
}{
    \vspace{1mm}
}

% define environment for cv entry description (dot points)
\newenvironment{cvdescription}{
    \vspace{-2.5mm}
    \begin{itemize} \itemsep 0mm
}{
    \end{itemize}
    \vspace{-1.5mm}
}

% --- Education
% define environment for education section
\newenvironment{cveducation}[1][Education]{
    \cvheader{#1}\\
}{
    \vspace{1mm}
}

% make school name
% usage: \cvschool{school name}
\newcommand*{\cvschool}[1]{
    \textbf{#1}\\
}

% make new degree
% usage: \cvdegree{degree}{dates}
\newcommand*{\cvdegree}[2]{
    #1~\hfill~#2\\
}

% --- Experience
% define environment for experience section
\newenvironment{cvexperience}[1][Experience]{
    \cvheader{#1}\\
}{
    \vspace{1mm}
}

% make company name
% usage: \cvcompany{company name}
\newcommand*{\cvcompany}[1]{
    \textbf{#1}\\
}

% make new position
% usage: \cvposition{job title}{dates}
\newcommand*{\cvposition}[2]{
    \textit{#1}~\hfill~#2\\
}

% --- Skills
% define environment for skills section
\newenvironment{cvskills}[1][Skills]{
    \cvheader{#1}\\
    \vspace{1mm}
    \begin{tabular}{ l l }
}{
    \end{tabular}
    \vspace{3mm}
}

% make new command to add new skill
% usage: \cvskill{skill name}{skill details}
\newcommand*{\cvskill}[2]{
    #1: & #2\\
}

% --- Projects
% define environment for projects section
\newenvironment{cvprojects}[1][Projects]{
    \cvheader{#1}\\
}{
    \vspace{1mm}
}

% make new project
% usage: \cvproject{project name}{tools used}
\newcommand*{\cvproject}[2]{
    \textbf{#1} {\sl #2}\\
}

% --- Links
% define environment for links section
\newenvironment{cvlinks}[1][Links]{
    \cvheader{#1}\\
    \vspace{1mm}
    \begin{tabular}{ l l }
}{
    \end{tabular}
    \vspace{2mm}
    \vspace{1mm}
}

% make link with or without http
% usage: \cvlink{link name}{URL}
\newcommand*{\cvlink}[2]{
    \substring[q]{#2}{1}{4}
    \ifthenelse{\equal{\thestring}{http}}
        {#1: & \link{#2}\\}
        {#1: & \httplink{#2}\\}
}


%---------------------------------------------------------------------
%                Cover letter command definitions
%---------------------------------------------------------------------
% elements
\newcommand*{\recipient}[3]{
    \def\@recipienttitle{#1}
    \def\@recipientfirstname{#2}
    \def\@recipientlastname{#3}
}
\newcommand*{\jobtitle}[1]{\def\@recipientjobtitle{#1}}
\newcommand*{\company}[1]{\def\@recipientcompany{#1}}
\newcommand*{\address}[1]{\def\@recipientaddress{#1}}
\renewcommand*{\date}[1]{\def\@date{#1}}\date{\today}
\newcommand*{\subject}[1]{\def\@subject{#1}}

% Define cover letter
\newenvironment{coverletter}{
    % page settings
    \clearpage
    \newgeometry{vmargin=1.2cm, hmargin=2.5cm}
    % build header area
    \makeprofile
    \hrulefill\\[1ex]
    % text settings
    \setstretch{1.1}
    \parskip=12pt plus1pt
    % fill address and subject block
    \makelettertitle
    % salutation
    \makeletteropening
}{
    % valediction
    \makeletterclosing
    % restore geometry
    \restoregeometry
}

% makes the letter title block
% usage: \makelettertitle
\newcommand*{\makelettertitle}{
    % recipient block
    \begin{minipage}[t]{.5\textwidth}
        \normalsize\mdseries\slshape
        \ifthenelse{\isundefined{\@recipientlastname}}
            {{\bfseries\upshape\@recipientjobtitle}\\}
            {
                {\bfseries\upshape\@recipienttitle~\@recipientfirstname~\@recipientlastname}\\
                \@recipientjobtitle\\
            }
        \@recipientcompany\\
        \@recipientaddress
    \end{minipage}
    % date
    \hfill \@date\\[2em]
    % subject
    {\bfseries\centering\@subject\\[1.2em]}
    % ensure no extra spacing after \makelettertitle due to a possible blank line
    %  \ignorespacesafterend% not working
    \hspace{0pt}\par\vspace{-\baselineskip}\vspace{-\parskip}
}

% makes the letter opening salutation
% usage: \makeletteropening
\newcommand*{\makeletteropening}{
    \ifthenelse{\isundefined{\@recipientlastname}}
        {Dear Sir or Madam,}
        {Dear \@recipienttitle~\@recipientlastname,}
    \par
}

% makes the letter closing
% usage: \makeletterclosing
\newcommand*{\makeletterclosing}{
    \vspace{2em}
    % valediction
    \ifthenelse{\isundefined{\@recipientlastname}}
        {Yours faithfully,}
        {Yours sincerely,}
    \par
    % signature
    \ifthenelse{\isundefined{\@signatureimage}}
        {}
        {\includegraphics[height=\@signaturesize]{\@signatureimage}\\}
    % name
    \@firstname~\@lastname
}

\endinput
