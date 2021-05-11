set grid
set format y "%6.3f"
set ylabel "Total energy (Ry)"
set xlabel "smearing (Ry)"

set xrange [0.0:0.1]
set xtics 0.0,0.02
set yrange [-4.197:]

set title "Gaussian ('gauss') smearing\n( press <Enter> in the terminal for the next plot ... )"
plot \
     'gauss.k4.dat'  w lp lt 1 lw 2, \
     'gauss.k8.dat'  w lp lt 2 lw 2, \
     'gauss.k12.dat' w lp lt 3 lw 2, \
     'gauss.k16.dat' w lp lt 4 lw 2
pause -1

set yrange [-4.186:]
set key bottom
set title "Marzari-Vanderbilt ('m-v') smearing\n( press <Enter> in the terminal for the next plot ... )"
plot \
     'gauss.k4.dat'  w l lt 1 dt (6,6), \
     'gauss.k8.dat'  w l lt 2 dt (6,6), \
     'gauss.k12.dat' w l lt 3 dt (6,6), \
     'm-v.k4.dat'    w lp lt 4 lw 2, \
     'm-v.k8.dat'    w lp lt 6 lw 2, \
     'm-v.k12.dat'   w lp lt 7 lw 2, \
     'm-v.k16.dat'   w lp lt 8 lw 2
pause -1

set title "Methfessel-Paxton ('m-p') smearing\n( the last plot )"
plot \
     'gauss.k4.dat'  w l lt 1 dt (6,6), \
     'gauss.k8.dat'  w l lt 2 dt (6,6), \
     'gauss.k12.dat' w l lt 3 dt (6,6), \
     'm-p.k4.dat'    w lp lt 4 lw 2, \
     'm-p.k8.dat'    w lp lt 6 lw 2, \
     'm-p.k12.dat'   w lp lt 7 lw 2, \
     'm-p.k16.dat'   w lp lt 8 lw 2
pause -1
