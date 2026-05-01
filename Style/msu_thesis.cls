%% msu_thesis.cls — Mahasarakham University Thesis
%% Compiler: XeLaTeX ONLY

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Style/msu_thesis}[2025/01/01 MSU Thesis Class]

%% ============================================================
%%  Class Options
%% ============================================================
\newif\if@thai
\newif\if@doctor
\newif\if@master
\newif\if@coadvisor

\@thaitrue
\@doctorfalse
\@masterfalse
\@coadvisorfalse

\DeclareOption{doctor} {
    \@doctortrue
    \@masterfalse
    \@coadvisortrue
} 
\DeclareOption{master} {
    \@doctorfalse
    \@mastertrue
} 
\DeclareOption{thai} {
    \@thaitrue
} 
\DeclareOption{english} {
    \@thaifalse
}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\LoadClass[16pt,a4paper,oneside]{book}

%% ============================================================
%%  Required Packages
%% ============================================================
\RequirePackage{fontspec}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{multirow}
\RequirePackage{hyperref}
\RequirePackage{xcolor}
\RequirePackage{colortbl}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{indentfirst}
\RequirePackage{afterpage}
\RequirePackage{emptypage}
\RequirePackage{ragged2e}
\RequirePackage{alphalph}   %% for A B C ... AA AB ... page numbering
\RequirePackage{changepage}
\RequirePackage{ifthen}

\PassOptionsToPackage{bookmarks=true}{hyperref}
\usepackage{hyperref}

\hypersetup{
  colorlinks  = false,
  pdfborder   = {0 0 0},
  bookmarks   = false,
  unicode     = true,
  pageanchor  = false,
}

\AtBeginDocument{%
  \if@thai
    \renewcommand{\normalsize}{\fontsize{\MSUfontThai bp}{\numexpr\MSUfontThai*4/3\relax bp}\selectfont}%
  \else
    \renewcommand{\normalsize}{\fontsize{\MSUfontEnglish bp}{\numexpr\MSUfontEnglish*4/3\relax bp}\selectfont}%
  \fi
  \normalsize%
}

%% ============================================================
%%  Font Setup
%% ============================================================
\if@thai
  \setmainfont[
    Path           = Fonts/,
    Extension      = .ttf,
    UprightFont    = THSarabunNew-Regular,
    BoldFont       = THSarabunNew-Bold,
    ItalicFont     = THSarabunNew-Italic,
    BoldItalicFont = THSarabunNew-BoldItalic
  ]{THSarabunNew}
  \XeTeXlinebreaklocale "th"
  \XeTeXlinebreakskip = 0pt plus 1pt
\else
  \setmainfont{Times New Roman}
  \newfontfamily\thaifont[
    Path           = Fonts/,
    Extension      = .ttf,
    UprightFont    = THSarabunNew-Regular,
    BoldFont       = THSarabunNew-Bold,
    ItalicFont     = THSarabunNew-Italic,
    BoldItalicFont = THSarabunNew-BoldItalic
  ]{THSarabunNew}
\fi


%% ============================================================
%%  Line Spacing & Paragraph
%% ============================================================
\setlength{\parindent}{1.25cm}
\setlength{\parskip}{0pt}
\newlength{\MSUindentSize}
\setlength{\MSUindentSize}{2cm}
\providecommand{\MSUindent}{\setlength{\parindent}{\MSUindentSize}}

%% ============================================================
%%  Page Geometry
%% ============================================================
\geometry{
  a4paper,
  top    = 1.5in,
  bottom = 1in,
  left   = 1.5in,
  right  = 1in,
  headheight = 2.3cm,
  footskip   = 1.25cm
}

\renewcommand{\dotfill}{\leavevmode\cleaders\hbox to 0.2em{\hss.\hss}\hfill\kern0pt}

%% ============================================================
%%  Front-matter page numbering
%%    Thai version  : ก ข ค ง ...
%%    English version: A B C D ... Z AA AB ...
%% ============================================================

%% Thai consonant sequence
\newcommand{\thaipagenumber}[1]{%
  \ifcase#1\or ก\or ข\or ค\or ง\or จ\or ฉ\or ช\or ซ\or ญ\or ฎ%
  \or ฏ\or ฐ\or ฑ\or ฒ\or ณ\or ด\or ต\or ถ\or ท\or ธ%
  \or น\or บ\or ป\or ผ\or ฝ\or พ\or ฟ\or ภ\or ม\or ย%
  \or ร\or ล\or ว\or ศ\or ษ\or ส\or ห\or อ\or ฮ\else??\fi%
}

%% English alpha sequence via alphalph package (A..Z, AA, AB ...)
\newcommand{\alphapagenumber}[1]{\AlphAlph{#1}}

%% Frontmatter pagestyle — switches by document language
\if@thai
  \fancypagestyle{frontmatter}{%
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\thepage}{\thaipagenumber{\value{page}}}%
    \fancyhead[R]{\fontsize{\MSUfontThai}{\MSUfontThai}\selectfont\thepage}%
  }
  \pagestyle{fancy}
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[R]{\fontsize{\MSUfontThai}{\MSUfontThai}\selectfont\thepage}
  \fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead[R]{\fontsize{\MSUfontThai}{\MSUfontThai}\selectfont\thepage}
  }
\else
  \fancypagestyle{frontmatter}{%
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\thepage}{\alphapagenumber{\value{page}}}%
    \fancyhead[R]{\fontsize{\MSUfontEnglish}{\MSUfontEnglish}\selectfont\thepage}%
  }
  \pagestyle{fancy}
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[R]{\fontsize{\MSUfontEnglish}{\MSUfontEnglish}\selectfont\thepage}
  \fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead[R]{\fontsize{\MSUfontEnglish}{\MSUfontEnglish}\selectfont\thepage}
  }
\fi

%% ============================================================
%%  Main pagestyle
%% ============================================================
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[R]{%
  \if@thai
    \fontsize{\MSUfontThai}{\MSUfontThai}\selectfont
  \else
    \fontsize{\MSUfontEnglish}{\MSUfontEnglish}\selectfont
  \fi
  \thepage}

\fancypagestyle{plain}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[R]{%
    \if@mainmatter
      \if@thai
        \fontsize{\MSUfontThai}{\MSUfontThai}\selectfont
      \else
        \fontsize{\MSUfontEnglish}{\MSUfontEnglish}\selectfont
      \fi
      \thepage
    \else
      \if@thai
        \fontsize{\MSUfontThai}{\MSUfontThai}\selectfont
        \thaipagenumber{\value{page}}%
      \else
        \fontsize{\MSUfontEnglish}{\MSUfontEnglish}\selectfont
        \alphapagenumber{\value{page}}%
      \fi
    \fi
  }%
}

%% ============================================================
%%  Chapter / Section names
%% ============================================================
\if@thai
  \renewcommand{\chaptername}{บทที่}
  \renewcommand{\appendixname}{ภาคผนวก}
  \renewcommand{\bibname}{บรรณานุกรม}
  \renewcommand{\contentsname}{สารบัญ}
  \renewcommand{\listfigurename}{สารบัญภาพ}
  \renewcommand{\listtablename}{สารบัญตาราง}
  \renewcommand{\figurename}{ภาพประกอบ}
  \renewcommand{\tablename}{ตาราง}
\else
  \renewcommand{\chaptername}{CHAPTER}
  \renewcommand{\appendixname}{APPENDIX}
  \renewcommand{\bibname}{REFERENCES}
  \renewcommand{\contentsname}{TABLE OF CONTETS}
  \renewcommand{\listfigurename}{LIST OF FIGURES}
  \renewcommand{\listtablename}{LIST OF TABLES}
  \renewcommand{\figurename}{Figure.}
  \renewcommand{\tablename}{Table}
\fi

%% ============================================================
%%  Chapter / Section heading format
%% ============================================================
\titleformat{\chapter}[display]
  {\normalfont\bfseries\centering}{\chaptername~\thechapter}{0pt}{\bfseries\centering}
\titlespacing*{\chapter}{0pt}{-20pt}{20pt}

%% --- \section ---
\titleformat{\section}
  {\normalfont\bfseries}{\thesection}{0.5em}{}
\titlespacing*{\section}{0pt}{12pt}{6pt}

%% --- \subsection ---
\titleformat{\subsection}
  {\normalfont\bfseries}{\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{0pt}{10pt}{4pt}

%% --- \subsubsection ---
\titleformat{\subsubsection}
  {\normalfont\bfseries}{\thesubsubsection}{0.5em}{}
\titlespacing*{\subsubsection}{0pt}{8pt}{2pt}

%% ============================================================
%%  List style (enumerate / itemize)
%% ============================================================
\setlist{topsep=0pt, itemsep=0pt, parsep=0pt, partopsep=0pt}
\setlist[enumerate]{
  labelindent = \parindent,
  labelsep    = 0.5em,
  leftmargin  = *,
  align       = left
}
\setlist[itemize]{
  labelindent = \parindent,
  labelsep    = 0.5em,
  leftmargin  = *,
  align       = left
}

%% sublist environment — สำหรับ list ที่กำหนดเลขเอง เช่น 1.2.1, 1.2.2
%% ใช้: \begin{sublist}
%%        \item[1.2.1] ข้อความ
%%        \item[1.2.2] ข้อความ
%%      \end{sublist}
\newenvironment{sublist}{%
  \begin{description}[labelindent=\parindent, labelsep=0.5em, leftmargin=*,
                      align=left, topsep=0pt, itemsep=0pt, parsep=0pt,
                      font=\normalfont]%
  }{%
    \end{description}%
}

%% ============================================================
%%  Table of Contents
%% ============================================================
\renewcommand{\frontmatter}{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}
  \if@thai
    \addtocontents{toc}{\protect\hfill\protect\textbf{หน้า}\protect\par}%
  \else
    \addtocontents{toc}{\protect\hfill\protect\textbf{Page}\protect\par}%
  \fi
}
\renewcommand*{\l@chapter}[2]{%

 \ifnum\c@tocdepth>\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip\cftbeforechapskip
    {\leftskip\z@
     \rightskip\@tocrmarg
     \parfillskip-\rightskip
     \leavevmode
     \def\numberline##1{%
        \if@thai
          {บทที่~##1}%
        \else
          {CHAPTER~##1}%
        \fi
        \dotfill\nobreak
        \hb@xt@\@pnumwidth{\hss#2}\par
     }%
     #1\nobreak
     \dotfill\nobreak
     \hb@xt@\@pnumwidth{\hss#2}\par
    }%
  \fi
}
\newcommand{\maketablesofcontents}{%
  \clearpage
  \phantomsection
  \if@thai
    \renewcommand{\contentsname}{สารบัญ}
    \addcontentsline{toc}{chapter}{สารบัญ}
  \else
    \renewcommand{\contentsname}{\MakeUppercase{Table of Contents}}
    \addcontentsline{toc}{chapter}{\MakeUppercase{Table of Contents}}
  \fi
  \setlength{\cftbeforetoctitleskip}{0pt}
  \setlength{\cftaftertoctitleskip}{0pt}
  \renewcommand{\cfttoctitlefont}{\hfill\bfseries\normalsize}
  \renewcommand{\cftaftertoctitle}{\hfill}
  \renewcommand{\dotfill}{\leavevmode\cleaders\hbox to 0.2em{\hss.\hss}\hfill\kern0pt}
  
  \setcounter{tocdepth}{2}
  \setlength{\cftbeforechapskip}{0pt}
  \setlength{\cftsecnumwidth}{0.75cm}
  \setlength{\cftsubsecnumwidth}{1cm}
  \setlength{\cftsubsubsecnumwidth}{1.25cm}

  \renewcommand{\cftsecleader}{\dotfill}
  \renewcommand{\cftsubsecleader}{\dotfill}
  \renewcommand{\cftsubsubsecleader}{\dotfill}

  \renewcommand{\cftsecindent}{0.2in}
  \renewcommand{\cftsubsecindent}{0.4in}
  \renewcommand{\cftsubsubsecindent}{0.6in}
  \tableofcontents
}

%% ============================================================
%%  List of Tables
%% ============================================================
\newcommand{\makelistoftables}{%
  \if@thai
    \renewcommand{\listtablename}{สารบัญตาราง}
  \else
    \renewcommand{\listtablename}{\MakeUppercase{List of Tables}}
  \fi
  \setlength{\cftbeforelottitleskip}{0pt}
  \setlength{\cftafterlottitleskip}{0pt}

  \renewcommand{\cftlottitlefont}{%
    \phantomsection
    \if@thai
      \addcontentsline{toc}{chapter}{สารบัญตาราง}%
    \else
      \addcontentsline{toc}{chapter}{\MakeUppercase{List of Tables}}%
    \fi
    \hfill\bfseries\normalsize
  }
  \renewcommand{\cftafterlottitle}{\hfill}

  \setlength{\cftbeforetabskip}{0pt}
  \setlength{\cfttabindent}{0pt}
  \setlength{\cfttabnumwidth}{1.75cm}
  \if@thai
    \renewcommand{\cfttabpresnum}{\tableTH~}
  \else
    \renewcommand{\cfttabpresnum}{\tableEN~}
  \fi
  \renewcommand{\cfttabaftersnum}{~~}
  \renewcommand{\cfttableader}{\dotfill}
  \if@thai
    \addtocontents{lot}{\protect\hfill\protect\textbf{หน้า}\protect\par}%
  \else
    \addtocontents{lot}{\protect\hfill\protect\textbf{Pages}\protect\par}%
  \fi
  \listoftables
}

%% ============================================================
%%  List of Figures
%% ============================================================
\newcommand{\makelistoffigures}{%
  \if@thai
    \renewcommand{\listfigurename}{สารบัญภาพประกอบ}
  \else
    \renewcommand{\listfigurename}{\MakeUppercase{List of Figures}}
  \fi

  \setlength{\cftbeforeloftitleskip}{0pt}
  \setlength{\cftafterloftitleskip}{0pt}
  \renewcommand{\cftloftitlefont}{%
    \phantomsection
    \if@thai
      \addcontentsline{toc}{chapter}{สารบัญภาพประกอบ}%
    \else
      \addcontentsline{toc}{chapter}{\MakeUppercase{List of Figures}}%
    \fi
    \hfill\bfseries\normalsize
  }
  \renewcommand{\cftafterloftitle}{\hfill}

  \setlength{\cftbeforefigskip}{0pt}
  \setlength{\cftfigindent}{0pt}
  \if@thai
    \setlength{\cftfignumwidth}{2.75cm}
    \renewcommand{\cftfigpresnum}{\figureTH~}
  \else
    \setlength{\cftfignumwidth}{1.85cm}
    \renewcommand{\cftfigpresnum}{\figureEN~}
  \fi
  \renewcommand{\cftfigaftersnum}{~~}
  \renewcommand{\cftfigleader}{\dotfill}
  \if@thai
    \addtocontents{lof}{\protect\hfill\protect\textbf{หน้า}\protect\par}%
  \else
    \addtocontents{lof}{\protect\hfill\protect\textbf{Pages}\protect\par}%
  \fi
  \listoffigures
}

%% ============================================================
%%  Front matter commands
%% ============================================================
\newcommand{\makecover}{
  \if@thai
    \makeoutercoverTH
    \makeinnercoverTH
    \makeinnercoverEN
  \else
    \makeoutercoverEN
    {%
      \renewcommand{\normalsize}{%
        \thaifont
        \fontsize{\MSUfontThai bp}{\numexpr\MSUfontThai*4/3\relax bp}\selectfont
      }%
      \normalsize
      \makeinnercoverTH
    }%
    \makeinnercoverEN
  \fi
}
\newcommand{\makeoutercoverTH}{
  \begin{titlepage}
    \thispagestyle{empty}
    \begin{center}
      \includegraphics[width=1.6in]{Figure/logo.jpg}
      \vspace{1cm}

      %----- Title -----%
      {\normalsize\thesistitleTH}
      %----- Author -----%
      \vfill
      {\normalsize วิทยานิพนธ์}\\
      {\normalsize ของ}\\
      {\normalsize \authornameTH}
      \vfill
      %----- Institution text -----%
      {\normalsize
        เสนอต่อมหาวิทยาลัยมหาสารคาม เพื่อเป็นส่วนหนึ่งของการศึกษาตามหลักสูตร\\
        ปริญญา\degreeTH~สาขาวิชา\FieldOfStudyTH\\
        \academicyearTH \yearTH \\
        ลิขสิทธิ์เป็นของมหาวิทยาลัยมหาสารคาม \\
      }
    \end{center}
  \end{titlepage}
}
\newcommand{\makeoutercoverEN}{
  \begin{titlepage}
    \thispagestyle{empty}
    \begin{center}
      \includegraphics[width=1.6in]{Figure/logo.jpg}
      \vspace{1cm}

      %----- Title -----%
      {\normalsize\thesistitleEN}
      %----- Author -----%
      \vfill
      {\normalsize \authornameEN}
      \vfill
      %----- Institution text -----%
      {\normalsize
        A Thesis Submitted in Partial Fulfillment of Requirements for \\
        \degreeEN \FieldOfStudyEN \\
        \academicyearEN \yearEN \\
        Copyright of Mahasarakham University
      }
    \end{center}
  \end{titlepage}
}
\newcommand{\makeinnercoverTH}{
  \clearpage
  \thispagestyle{empty}
  \begin{center}
    %----- Thai Title -----%
    {\normalsize\thesistitleTH}
    \vfill
    {\normalsize วิทยานิพนธ์}\\
    {\normalsize ของ}\\
    {\normalsize \authornameTH}
    \vfill
    {\normalsize
      เสนอต่อมหาวิทยาลัยมหาสารคาม เพื่อเป็นส่วนหนึ่งของการศึกษาตามหลักสูตร\\
      ปริญญา\degreeTH~สาขาวิชา\FieldOfStudyTH\\
      \academicyearTH \yearTH \\
      ลิขสิทธิ์เป็นของมหาวิทยาลัยมหาสารคาม \\
    }
  \end{center}
  \clearpage
} 
\newcommand{\makeinnercoverEN}{
  \clearpage
  \thispagestyle{empty}
  \begin{center}
    %----- English Title -----%
    {\normalsize\thesistitleEN}
    \vfill
    {\normalsize \authornameEN}
    \vfill
    {\normalsize
      A Thesis Submitted in Partial Fulfillment of Requirements for \\
      \degreeEN\ \FieldOfStudyEN\\
      \academicyearEN \yearEN \\
      Copyright of Mahasarakham University \\
    }
  \end{center}
  \clearpage
}

\newcommand{\makeapproval}{%
  \clearpage
  \thispagestyle{frontmatter}
    \begin{center}
    \includegraphics[width=1in]{Figure/logo.jpg}
    \vspace{0.5cm}
    \end{center}

    \if@thai
      {\MSUindent\normalsize
        คณะกรรมการสอบวิทยานิพนธ์ ได้พิจารณาวิทยานิพนธ์ของ\authorprefixTH\authornameTH
        แล้วเห็นสมควรรับเป็นส่วนหนึ่งของการศึกษาตามหลักสูตรปริญญา\degreeTH
        สาขาวิชา\FieldOfStudyTH ของมหาวิทยาลัยมหาสารคาม
      }
    \else
      {\MSUindent\normalsize
        The examining committee has unanimously approved this Thesis,
        submitted by \authorprefixEN\authornameEN as a partial fulfillment of the requirements for the
        \degreeEN at Mahasarakham University
      }
    \fi

    \if@thai
      \vspace{0.5cm}
      {\MSUindent\normalsize คณะกรรมการสอบวิทยานิพนธ์}
      \vspace{0.5cm}
    \else
      \vspace{0.5cm}
      {\MSUindent\normalsize Examining Committee}
      \vspace{0.5cm}
    \fi

    \begin{adjustwidth}{2cm}{}
      \begin{flushleft}
        \begin{tabular}{@{}>{\centering}p{6cm}l}
          \if@thai
            \dotfill & \committeeChairTH \\
            (\committeeChairshortTH) &  \\
            \dotfill & \advisorTH \\
            (\advisorshortTH) &  \\ 
          \else
            \dotfill & \committeeChairEN \\
            (\committeeChairshortEN) &  \\
            \dotfill & \advisorEN \\
            (\advisorshortEN) &  \\ 
          \fi

          \if@thai
            \ifthenelse{\equal{\coOnedvisorshortTH}{}}{}{%
              \dotfill & \coadvisorTH \\
              (\coOnedvisorshortTH) &  \\
            }
          \else
            \ifthenelse{\equal{\coOnedvisorshortEN}{}}{}{%
              \dotfill & \coadvisorEN \\
              (\coOnedvisorshortEN) &  \\
            }
          \fi
          
          \if@thai
            \ifthenelse{\equal{\coTwoadvisorshortTH}{}}{}{%
              \dotfill & \coadvisorTH \\
              (\coTwoadvisorshortTH) &  \\
            }
          \else
            \ifthenelse{\equal{\coTwoadvisorshortEN}{}}{}{%
              \dotfill & \coadvisorEN \\
              (\coTwoadvisorshortEN) &  \\
            }
          \fi

          \if@thai
            \dotfill & \committeeTH \\
            (\OnecommitteeshortTH) &  \\
          \else
            \dotfill & \committeeEN \\
            (\OnecommitteeshortEN) &  \\
          \fi

          \if@thai
            \ifthenelse{\equal{\TwocommitteeshortTH}{}}{}{%
              \dotfill & \committeeTH \\
              (\TwocommitteeshortTH) &  \\
            }
          \else
            \ifthenelse{\equal{\TwocommitteeshortEN}{}}{}{%
              \dotfill & \committeeEN \\
              (\TwocommitteeshortEN) &  \\
            }
          \fi

          \if@thai
            \ifthenelse{\equal{\examinershortTH}{}}{}{%
              \dotfill & \examinerTH \\
              (\examinershortTH) &  \\
            }
          \else
            \ifthenelse{\equal{\examinershortEN}{}}{}{%
              \dotfill & \examinerEN \\
              (\examinershortEN) &  \\
            }
          \fi

        \end{tabular}
      \end{flushleft}
    \end{adjustwidth}

    \if@thai
      \vspace{1cm}
      {\MSUindent\normalsize
        มหาวิทยาลัยอนุมัติให้รับวิทยานิพนธ์ฉบับนี้ เป็นส่วนหนึ่งของการศึกษาตามหลักสูตร
        ปริญญา\degreeTH สาขาวิชา\FieldOfStudyTH ของมหาวิทยาลัยมหาสารคาม
      }
      \vspace{1cm}
    \else
      \vspace{1cm}
      {\MSUindent\normalsize
        Mahasarakham University has granted approval to accept this Thesis as a
        partial fulfillment of the requirements for \degreeEN~\FieldOfStudyEN 
      }
      \vspace{1cm}
    \fi

    \noindent
    \begin{tabular}{@{}p{0.5\textwidth}p{0.5\textwidth}@{}}
      \centering
      \begin{minipage}[t]{0.45\textwidth}
        \centering
        \if@thai
          \makebox[0.95\textwidth]{\dotfill}\\
          (\deanEngshortTH)\\
          \deanEngTH
        \else
          \makebox[0.95\textwidth]{\dotfill}\\
          (\deanEngshortEN)\\
          \deanEngEN
        \fi
      \end{minipage}
      &
      \centering
      \begin{minipage}[t]{0.45\textwidth}
        \centering
        \if@thai
          \makebox[0.95\textwidth]{\dotfill}\\
          (\deanGradshortTH)\\
          \deanGradTH
        \else
          \makebox[0.95\textwidth]{\dotfill}\\
          (\deanGradshortEN)\\
          \deanGradEN
        \fi
      \end{minipage}
      \\
    \end{tabular}
}

\newcommand{\makeabstract}{%
  \if@thai
      \clearpage
      \thispagestyle{frontmatter}
      \phantomsection
      \addcontentsline{toc}{chapter}{บทคัดย่อภาษาไทย}

      \noindent
      \begin{tabular}{@{}p{1.2in}p{\dimexpr\linewidth-1.2in-2\tabcolsep\relax}@{}}
        {\bfseries ชื่อเรื่อง}    & \thesistitleTH \\
        {\bfseries ผู้วิจัย}   & \authornameTH \\
        {\bfseries อาจารย์ที่ปรึกษา} & \advisorFullTH 
        \ifthenelse{\equal{\coOneadvisorFullTH}{}}{}{%
          \\ & \coOneadvisorFullTH
        }%
        \ifthenelse{\equal{\coTwoadvisorFullTH}{}}{}{%
          \\ & \coTwoadvisorFullTH
        }%
        \\
        
      \end{tabular}

      \noindent
      \begin{tabular}{@{}p{1.2in}p{1.6in}p{0.6in}p{\dimexpr\linewidth-1.2in-1.6in-0.6in-6\tabcolsep\relax}@{}}
        {\bfseries ปริญญา}     & \degreeTH & {\bfseries สาขา} & \FieldOfStudyTH \\
        {\bfseries มหาวิทยาลัย} & มหาวิทยาลัยมหาสารคาม & {\bfseries ปีที่พิมพ์} & \yearTH \\
      \end{tabular}

      \vspace{0.5cm}
      \begin{center}{\bfseries บทคัดย่อ}\end{center}

      {\MSUindent\normalsize\abstractTH}

      \vspace{0.5cm}
      \noindent\textbf{คำสำคัญ}: \keywordTH
  \fi

  \clearpage
  \thispagestyle{frontmatter}
  \phantomsection
  \if@thai
    \addcontentsline{toc}{chapter}{บทคัดย่อภาษาอังกฤษ}
  \else
    \addcontentsline{toc}{chapter}{\MakeUppercase{Abstract}}
  \fi

  \noindent
  \begin{tabular}{@{}p{1.2in}p{\dimexpr\linewidth-1.2in-2\tabcolsep\relax}@{}}
    {\bfseries TITLE}    & \thesistitleEN \\
    {\bfseries AUTHOR}   & \authornameEN \\
    {\bfseries ADVISORS} & \advisorFullEN \\
  \end{tabular}

  \noindent
  \begin{tabular}{@{}p{1.2in}p{1.6in}p{0.7in}p{\dimexpr\linewidth-1.2in-1.6in-0.7in-6\tabcolsep\relax}@{}}
    {\bfseries DEGREE}     & \degreeEN & {\bfseries MAJOR} & \FieldOfStudyEN \\
    {\bfseries UNIVERSITY} & Mahasarakham \newline University & {\bfseries YEAR} & \yearEN \\
  \end{tabular}

  \vspace{0.5cm}
  \begin{center}{\bfseries ABSTRACT}\end{center}

  {\MSUindent\normalsize\abstractEN}

  \vspace{0.5cm}
  \noindent\textbf{Keywords}: \keywordEN
}

\newcommand{\makeacknowledgement}{
  \clearpage
  \thispagestyle{frontmatter}
  \phantomsection 
    \if@thai
      \addcontentsline{toc}{chapter}{กิตติกรรมประกาศ}
      \begin{center}{\bfseries กิตติกรรมประกาศ}\end{center}
      \vspace{0.8cm}
      
      \indent\normalsize\acknowledgementTH

      \vspace{2cm}
      \begin{flushright}\authornameTH\end{flushright}
    \else
      \addcontentsline{toc}{chapter}{\MakeUppercase{Acknowledgement}}
      \begin{center}{\bfseries Acknowledgement}\end{center}
      \vspace{0.8cm}

      \indent\normalsize\acknowledgementEN

      \vspace{2cm}
      \begin{flushright}\authornameEN\end{flushright}
  \fi
}

\newcommand{\makebio}{
  \clearpage
  \thispagestyle{frontmatter}
  \phantomsection 
    \if@thai
      \addcontentsline{toc}{chapter}{ประวัติผู้เขียน}
      \thispagestyle{fancy}
      \begin{center}{\bfseries ประวัติผู้เขียน}\end{center}
      \vspace{1cm}
    \else
      \addcontentsline{toc}{chapter}{\MakeUppercase{biography}}
      \thispagestyle{fancy}
      \begin{center}{\bfseries {\MakeUppercase{biography}}}\end{center}
      \vspace{1cm}
    \fi

  \if@thai
    \noindent\begin{tabular}{@{}p{4cm}p{\dimexpr\linewidth-4cm-2\tabcolsep\relax}@{}}
      ชื่อ               & \bioName \\
      วันเกิด            & \bioDOB \\
      สถานที่เกิด         & \bioPOB \\
      สถานที่อยู่ปัจจุบัน    & \bioAddress \\
      ตำแหน่งหน้าที่การงาน & \bioPosition \\
      สถานที่ทำงานปัจจุบัน & \bioPOW \\
      ประวัติการศึกษา    & \bioEdu \\
    \end{tabular}
    \begin{description}[leftmargin=\dimexpr4cm+2\tabcolsep\relax,
                        labelwidth=\dimexpr4cm+2\tabcolsep\relax,labelsep=0pt,
                        align=left,style=sameline,font=\normalfont,
                        topsep=0pt,partopsep=0pt,itemsep=0pt,parsep=\parskip]
      \item[ผลงานวิจัย] {\sloppy\bioResearchAward}
    \end{description}
  \else
    \noindent\begin{tabular}{@{}p{4cm}p{\dimexpr\linewidth-4cm-2\tabcolsep\relax}@{}}
      {\MakeUppercase{Name}}                   & \bioName \\
      {\MakeUppercase{Date of birth}}          & \bioDOB \\
      {\MakeUppercase{Place of birth}}         & \bioPOB \\
      {\MakeUppercase{Address}}                & \bioAddress \\
      {\MakeUppercase{Positiom}}               & \bioPosition \\
      {\MakeUppercase{Place of work}}          & \bioPOW \\
      {\MakeUppercase{Education}}              & \bioEdu \\
    \end{tabular}
    \begin{description}[leftmargin=\dimexpr4cm+2\tabcolsep\relax,
                        labelwidth=\dimexpr4cm+2\tabcolsep\relax,labelsep=0pt,
                        align=left,style=sameline,font=\normalfont,
                        topsep=0pt,partopsep=0pt,itemsep=0pt,parsep=\parskip]
      \item[{\MakeUppercase{Research}}] {\sloppy\bioResearchAward}
    \end{description}
  \fi
}


%% ============================================================
%%  Captions
%% ============================================================
\if@thai
  \captionsetup{labelsep=space,font=normalsize}
  \captionsetup[figure]{name=ภาพประกอบ}
  \captionsetup[table]{name=ตาราง}
\else
  \captionsetup{labelsep=space,font=normalsize}
\fi

%% ============================================================
%%  Numbering
%% ============================================================
\numberwithin{equation}{chapter}
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}

%% ============================================================
%%  Thesis Info Commands
%% ============================================================
%% Utility
\newcommand{\blankpage}{\clearpage\thispagestyle{empty}\mbox{}\clearpage}


\newcommand{\thesistitles}[2]{
    \newcommand{\thesistitleTH}{#1}
    \newcommand{\thesistitleEN}{#2}
    \newcommand{\thesistitleENUP}{\MakeUppercase{#2}}
}

\newcommand{\authorprefix}[2]{
    \newcommand{\authorprefixTH}{#1}
    \newcommand{\authorprefixEN}{#2}
}

\newcommand{\thesisauthor}[3]{
    \newcommand{\authornameTH}{#1}
    \newcommand{\authornameEN}{#2}
    \newcommand{\studentID}{#3}
}

\newcommand{\advisor}[6]{
    \newcommand{\advisorshortTH}{#1}
    \newcommand{\advisorFullTH}{#2}
    \newcommand{\advisorshortEN}{#3}
    \newcommand{\advisorFullEN}{#4}
    \newcommand{\advisorTH}{#5}
    \newcommand{\advisorEN}{#6}
}

\newcommand{\coadvisorlist}[8]{
    \newcommand{\coOnedvisorshortTH}{#1}
    \newcommand{\coOneadvisorFullTH}{#2}
    \newcommand{\coOnedvisorshortEN}{#3}
    \newcommand{\coOneadvisorFullEN}{#4}
    \newcommand{\coTwoadvisorshortTH}{#5}
    \newcommand{\coTwoadvisorFullTH}{#6}
    \newcommand{\coTwoadvisorshortEN}{#7}
    \newcommand{\coTwoadvisorFullEN}{#8}
}
\newcommand{\coadvisorName}[2]{
    \newcommand{\coadvisorTH}{#1}
    \newcommand{\coadvisorEN}{#2}

}

\newcommand{\committeeChair}[6]{
    \newcommand{\committeeChairshortTH}{#1}
    \newcommand{\committeeChairFullTH}{#2}
    \newcommand{\committeeChairshortEN}{#3}
    \newcommand{\committeeChairFullEN}{#4}
    \newcommand{\committeeChairTH}{#5}
    \newcommand{\committeeChairEN}{#6}
}

\newcommand{\committeelist}[8]{
    \newcommand{\OnecommitteeshortTH}{#1}
    \newcommand{\OnecommitteeFullTH}{#2}
    \newcommand{\OnecommitteeshortEN}{#3}
    \newcommand{\OnecommitteeFullEN}{#4}
    \newcommand{\TwocommitteeshortTH}{#5}
    \newcommand{\TwocommitteeFullTH}{#6}
    \newcommand{\TwocommitteeshortEN}{#7}
    \newcommand{\TwocommitteeFullEN}{#8}
}
\newcommand{\committeeName}[2]{
    \newcommand{\committeeTH}{#1}
    \newcommand{\committeeEN}{#2}
}

\newcommand{\examiner}[6]{
    \newcommand{\examinershortTH}{#1}
    \newcommand{\examinerFullTH}{#2}
    \newcommand{\examinershortEN}{#3}
    \newcommand{\examinerFullEN}{#4}
    \newcommand{\examinerTH}{#5}
    \newcommand{\examinerEN}{#6}
}

\newcommand{\deanEng}[6]{
    \newcommand{\deanEngshortTH}{#1}
    \newcommand{\deanEngFullTH}{#2}
    \newcommand{\deanEngshortEN}{#3}
    \newcommand{\deanEngFullEN}{#4}
    \newcommand{\deanEngTH}{#5}
    \newcommand{\deanEngEN}{#6}
}

\newcommand{\deanGrad}[6]{
    \newcommand{\deanGradshortTH}{#1}
    \newcommand{\deanGradFullTH}{#2}
    \newcommand{\deanGradshortEN}{#3}
    \newcommand{\deanGradFullEN}{#4}
    \newcommand{\deanGradTH}{#5}
    \newcommand{\deanGradEN}{#6}
}

\newcommand{\degree}[6]{
    \newcommand{\degreeTH}{#1}
    \newcommand{\degreeEN}{#2}
    \newcommand{\FieldOfStudyTH}{#3}
    \newcommand{\FieldOfStudyEN}{#4}
    \newcommand{\FacultyTH}{#5}
    \newcommand{\FacultyEN}{#6}
}

\newcommand{\academicyear}[4]{
    \newcommand{\academicyearTH}{#1}
    \newcommand{\academicyearEN}{#2}
    \newcommand{\yearTH}{#3}
    \newcommand{\yearEN}{#4}
}

\newcommand{\abstract}[4]{
    \newcommand{\abstractTH}{#1}
    \newcommand{\keywordTH}{#2}
    \newcommand{\abstractEN}{#3}
    \newcommand{\keywordEN}{#4}
}

\newcommand{\acknowledgement}[2]{
    \newcommand{\acknowledgementTH}{#1}
    \newcommand{\acknowledgementEN}{#2}
}

\newcommand{\biographyAuthor}[9]{
    \newcommand{\bioName}{#1}
    \newcommand{\bioDOB}{#2}
    \newcommand{\bioPOB}{#3}
    \newcommand{\bioAddress}{#4}
    \newcommand{\bioPosition}{#5}
    \newcommand{\bioPOW}{#6}
    \newcommand{\bioEdu}{#7}
    \newcommand{\bioResearchAward}{#8}
    \newcommand{\bioResearch}{#9}
}

\newcommand{\headinglist}[4]{
    \newcommand{\tableTH}{#1}
    \newcommand{\tableEN}{#2}
    \newcommand{\figureTH}{#3}
    \newcommand{\figureEN}{#4}
}

\endinput
