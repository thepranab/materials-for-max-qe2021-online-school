set grid
set format y "%6.3f"
set ylabel "Total energy (Ry)"
set xlabel "ecutwfc (Ry)"
set key bottom

plot \
     'Etot-vs-ecutwfc.dual4.dat' title 'dual=4' w linespoints lw 2 pt 4 ps 1.2, \
     'Etot-vs-ecutwfc.dual8.dat' title 'dual=8' w linespoints lw 2 pt 5 ps 1.2, \
     'Etot-vs-ecutwfc.dual12.dat' title 'dual=12' w linespoints lw 2 pt 6 ps 1.2
pause -1

