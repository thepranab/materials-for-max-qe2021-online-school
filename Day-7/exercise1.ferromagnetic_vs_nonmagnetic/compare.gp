m='magnetic/energies.dat'
n='non_magnetic/energies.dat' 
set xlabel "Lattice Constant (Bohr)" font "Helvetica,16"
set ylabel "Energy per cell (Ry)"  font "Helvetica,16"
p m u 1:2 w lp points 1.3  pt 7  lw 2 t "LSDA Magnetic", n u 1:2 w lp points 1.3  pt 7   lw 2 t "LDA Non Magnetic" 
pause -1 
