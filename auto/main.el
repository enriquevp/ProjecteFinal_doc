(TeX-add-style-hook
 "main"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("tmarticle" "14pt" "a4paper" "oneside" "fleqn")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("babel" "spanish") ("inputenc" "utf8") ("beramono" "scaled=0.85") ("fontenc" "T1") ("biblatex" "backend=biber" "style=numeric" "sorting=none") ("glossaries" "toc" "section=section") ("geometry" "a4paper" "width=150mm" "top=25mm" "bottom=25mm" "bindingoffset=6mm")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "chapters/intro"
    "tmarticle"
    "tmarticle10"
    "lipsum"
    "babel"
    "inputenc"
    "beramono"
    "fontenc"
    "biblatex"
    "glossaries"
    "bibentry"
    "paralist"
    "titlesec"
    "rotating"
    "fancyhdr"
    "geometry"
    "xcolor"
    "colortbl"
    "pdfpages"
    "svg"
    "amsmath"
    "amssymb")
   (TeX-add-symbols
    "Declare")
   (LaTeX-add-bibliographies
    "bibliography")
   (LaTeX-add-counters
    "subsubsubsection"))
 :latex)

