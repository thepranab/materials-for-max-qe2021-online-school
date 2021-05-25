dat='magnetization.dat'
set font "Helvetica,24"
set ylabel "Total Magnetization (Bohr/cell)" font "Helvetica,18"  
set xlabel "Lattice Constant (Bohr)" font "Helvetica,18"
p dat w lp pt 6 lw 2 points 2.5 t "Total Magnetization" 
pause -1
