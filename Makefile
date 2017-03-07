FILE=main

all:$(FILE).pdf

.PHONY:remove-pdf
remove-pdf:
	\rm main.pdf

.PHONY:clean
clean:
	\rm *.aux *.bbl *.bcf *.run.xml *.toc *.blg *.log *.glg *.glo *.gls *.ist *.lof 

$(FILE).pdf:$(FILE).tex
	xelatex $(FILE)
	xelatex $(FILE)
	makeglossaries $(FILE)
	biber $(FILE)
	xelatex $(FILE)
	xelatex $(FILE)
	makeglossaries $(FILE)
	xelatex $(FILE)
