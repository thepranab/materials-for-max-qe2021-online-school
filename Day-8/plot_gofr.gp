set ylabel "arbitrary units"
set xlabel "distance (angstrom)"
dr=0.1*0.529
pl 'gofr' u ($2*dr):3 w l title "O-H", '' u ($2*dr):5 w l title "H-H", '' u ($2*dr):7 w l title "O-O"
