file=
Ef=0.0
set parametric
set xtics font "Helvetica,18"
set xlabel "Energy (eV)" font "Helvetica,20"

plot file u ($1-Ef):6 w l lw 2 notit,\
     file u ($1-Ef):(-$7) w l lw 2 notit 
pause -1
