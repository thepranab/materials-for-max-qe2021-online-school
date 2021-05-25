file=
Ef=0.0
set parametric
set xtics font "Helvetica,18"
set xlabel "Energy (eV)" font "Helvetica,20"

plot file u ($1-Ef):4 w l lw 2 notit,\
     file u ($1-Ef):(-$5) w l lw 2 notit 
pause -1
