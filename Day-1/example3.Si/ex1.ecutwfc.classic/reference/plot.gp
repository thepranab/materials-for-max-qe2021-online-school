set grid
set format y "%6.3f"
set ylabel "Total energy (Ry)"
set xlabel "ecutwfc (Ry)"

plot 'si.etot_vs_ecut' w linespoints lw 2 pt 4 ps 1.2
pause -1

