set grid
set format y "%6.3f"
set ylabel "Total energy (Ry)"
set xlabel "smearing (Ry)"

set xrange [0.01:0.15]
set xtics 0.01,0.02

set title "'gauss' smearing\n( press <Enter> in the terminal for the next plot ... )"
plot \
     'gauss.k6.dat' w l, \
     'gauss.k12.dat' w l, \
     'gauss.k16.dat' w l
pause -1

set key bottom
set yrange [-4.19:]
set title "+ 'm-v' smearing\n( press <Enter> in the terminal for the next plot ... )"
plot \
     'gauss.k6.dat' w l, \
     'gauss.k12.dat' w l, \
     'gauss.k16.dat' w l, \
     'm-v.k6.dat' w l lw 2, \
     'm-v.k12.dat' w l lw 2, \
     'm-v.k16.dat' w l lw 2
pause -1

set title "+ 'm-p' smearing\n( the last plot )"
plot \
     'gauss.k6.dat' w l, \
     'gauss.k12.dat' w l, \
     'gauss.k16.dat' w l, \
     'm-v.k6.dat' w l, \
     'm-v.k12.dat' w l, \
     'm-v.k16.dat' w l, \
     'm-p.k6.dat' w l lw 2, \
     'm-p.k12.dat' w l lw 2, \
     'm-p.k16.dat' w l lw 2
pause -1
