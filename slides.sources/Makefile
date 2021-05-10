compile:
	pdflatex handson-day1
	pdflatex handson-day2
	pdflatex handson-day3
	pdflatex handson-day8

install: compile
	mv handson-day1.pdf ../Day-1/handson-day1.pdf
	mv handson-day2.pdf ../Day-2/handson-day2.pdf
	mv handson-day3.pdf ../Day-3/handson-day3.pdf
	mv handson-day8.pdf ../Day-8/handson-day8.pdf

clean:
	- rm -f *.pdf *.log *.aux *.out *~
	- rm -rf auto

