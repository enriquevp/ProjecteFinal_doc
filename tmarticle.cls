\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TMarticle}
\LoadClass{article}

\RequirePackage{listings} % for our code listings
\RequirePackage[usenames, dvipsnames, svgnames, table]{xcolor}
\RequirePackage{mdframed}
\RequirePackage{graphicx}
\RequirePackage{calc}
\RequirePackage{array}
\RequirePackage{tabu}
\RequirePackage{xparse}
\RequirePackage{longtable}
\RequirePackage{fontspec}
\RequirePackage{amsthm}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{thmtools}
\RequirePackage{framed}

% color definitions
\definecolor{TMgreen}{RGB}{14, 191, 48}
\definecolor{TMorange}{RGB}{243, 126, 25}
\definecolor{TMred}{RGB}{230, 6, 85}
\definecolor{TMcodeBackground}{RGB}{224, 224, 224}
\definecolor{TMcodeFrame}{RGB}{109, 108, 109}
\definecolor{TMtableHead}{RGB}{230, 6, 85}
\definecolor{TMtableRowTwo}{RGB}{230, 230, 230}
\definecolor{TMtableRowOne}{RGB}{240, 240, 240}
\definecolor{TMemphasis}{RGB}{165, 32, 23}
\definecolor{TMwarning}{RGB}{250, 175, 52}
\definecolor{TMcritical}{RGB}{229, 0, 72}
\definecolor{TMnormal}{RGB}{54, 160, 220}
\definecolor{TMbulletinBackground}{RGB}{224, 224, 224}
\definecolor{TMtheorem}{RGB}{14, 191, 48}

% we now start creating the TM-styled code listing environments
% the lstlisting environment is wrapped in an MD-frame
% first of all we need to define the mdframestyle that
% takes care of the background and the left bar

\mdfdefinestyle{TMstyleCode}{
            skipabove=0mm,
            skipbelow=0mm,
            %remove borders
            rightline=false,
            topline=false,
            bottomline=false,
            linewidth=1mm,
            %margins
            innertopmargin=0mm,
            %innerleftmargin=-2mm,
            innerbottommargin=0mm,
            innerrightmargin=10pt,
            linecolor=TMcodeFrame,
            backgroundcolor=TMcodeBackground
}

\mdfdefinestyle{TMterm}{
            skipabove=4mm,
            skipbelow=0mm,
            %remove borders
            rightline=false,
            topline=false,
            bottomline=false,
            linewidth=1mm,
            %margins
            innertopmargin=2mm,
            innerleftmargin=0mm,
            innerbottommargin=0mm,
            innerrightmargin=10pt,
            linecolor=TMcodeFrame,
            backgroundcolor=TMcodeBackground
}

\lstdefinestyle{TMstyle}{
    showstringspaces=false,
    numbers=none,
    numbersep=7mm,
    numberstyle=\color{Black},
    stepnumber=1,
    tabsize=3,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    basicstyle=\color{Black}\ttfamily,
    commentstyle=\color{TMgreen},
    keywordstyle=\color{TMorange}\bfseries,
    stringstyle=\color{TMred},
    frame=leftline,
    framesep=0mm,
    xleftmargin=3mm,
    framesep=2mm,
    framerule=0mm,
    abovecaptionskip=5mm,
    aboveskip=\baselineskip,
    belowskip=\baselineskip
}

% need to use inner commands to avoid the verbatim nature
% of listing environments!

\lstnewenvironment{TMcode}[2]
{
  \lstset{style=TMstyle,
    language=#1,
    caption=#2,
    xleftmargin = -0.5mm,
    numbers=left}
    \mdfsetup{style=TMstyleCode}
    \mdframed
}
{
    \endmdframed
}

\lstnewenvironment{TMterminal}[3]
{
    \lstset{style=TMstyle}
    \mdfsetup{style=TMterm}
    \mdframed
    \hspace*{3mm}
    \minipage{0.75cm}
    \includegraphics[width=\linewidth]{images/code2.png}
    \endminipage
    \hspace*{1mm}
    \minipage{\textwidth-1.05cm}
    {\Large\sffamily #3}
    \endminipage
    \vspace*{-2mm}
}
{
    \endmdframed
}


% We now want to create the bulletin-environments
% we first define two new mdenvironments, one for the header and one for
% the content
\newmdenv[
        skipabove=4mm,
        skipbelow=1mm,
        innertopmargin=1mm,
        innerbottommargin=1mm,
        innerleftmargin=0mm,
        innerrightmargin=0pt,
        rightline=false,
        topline=false,
        bottomline=false,
        linewidth=1mm,
        frametitlefont={\bfseries},
        backgroundcolor=TMbulletinBackground]{TMbulletinBase}
\newmdenv[default, linewidth=0pt, backgroundcolor=TMbulletinBackground]{TMbulletinContent}

% we then define three styles, one for each type
\mdfdefinestyle{normal}{linecolor=TMnormal}
\mdfdefinestyle{warning}{linecolor=TMwarning}
\mdfdefinestyle{critical}{linecolor=TMcritical}

% we then define some auxilliary commands
\newcommand{\@TMbulletinTitleContent}[2]
{
    \hspace*{2mm}\begin{minipage}{0.75cm}
        \includegraphics[width=\linewidth]{#1}
    \end{minipage}\hspace*{1mm}\begin{minipage}{\textwidth-1.05cm}
            #2
    \end{minipage}
}

% and finally the main environment
% takes type (warning/normal/critical) as first argument
% takes bulletin title as second argument
\newenvironment{TMbulletin}[2]{
    \begin{TMbulletinBase}[style=#1, frametitle=\@TMbulletinTitleContent{images/#1.png}{#2}]
    \vspace*{1mm}
    \begin{TMbulletinContent}
}
{
    \end{TMbulletinContent}
    \end{TMbulletinBase}
}

% we now define the mdtable styles
\newcommand{\tableCaption}{}
\mdfdefinestyle{TMstyleTable}{
            skipabove=4mm,
            skipbelow=0mm,
            %remove borders
            rightline=false,
            topline=false,
            bottomline=false,
            linewidth=1mm,
            %margins
            innertopmargin=0mm,
            innerleftmargin=0mm,
            innerbottommargin=0mm,
            innerrightmargin=0pt,
            backgroundcolor=TMcodeBackground,
            linecolor=TMtableHead,
}
\everyrow{\tabucline[.4mm white]{}}
\tabulinesep=^3mm_2mm
\taburowcolors[2] 2{TMtableRowOne .. TMtableRowTwo}
\newenvironment{TMtable}[3]
{
    \renewcommand{\tableCaption}{#3}
    \begin{table}[#2]
    \begin{mdframed}[style=TMstyleTable]
    \begin{tabu} to \textwidth{#1}
        \rowfont{\bfseries\leavevmode\color{white}}
        \rowcolor{TMtableHead!}
}
{
    \end{tabu}
    \end{mdframed}
    \caption{\tableCaption}
    \end{table}
}

% theorem styles
\declaretheoremstyle[
    postheadspace=\newline,
    headfont=\bfseries\large,
    mdframed={
            skipabove=4mm,
            skipbelow=0mm,
            rightline=false,
            topline=false,
            bottomline=false,
            linewidth=1mm,
            linecolor=TMtheorem,
            backgroundcolor=TMcodeBackground,
    }
]{TMtheoremStyle}
\declaretheorem[style=TMtheoremStyle, within=section]{theorem}
\declaretheorem[style=TMtheoremStyle, sibling=theorem]{lemma}
\declaretheorem[style=TMtheoremStyle, sibling=theorem]{corollary}
\declaretheorem[style=TMtheoremStyle, sibling=theorem]{proposition}
