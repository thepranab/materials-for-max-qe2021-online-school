set grid
set format y "%6.3f"
set format x "%4.1f"
set ylabel "Total energy (Ry)"
set xlabel "Lattice parameter (Bohr)"

plot 'Etot-vs-alat.dat' w linespoints lw 2 pt 4 ps 1.2
pause -1

