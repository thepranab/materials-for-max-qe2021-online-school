dat='magmom.dat'
set font "Helvetica,24"
set ylabel "(Bohr/cell)" font "Helvetica,18"  
set xlabel "Lattice Constant (Bohr)" font "Helvetica,18"
p dat w lp pt 6 lw 2 points 2.5 t "Fe Magnetic Moment" 
pause -1
