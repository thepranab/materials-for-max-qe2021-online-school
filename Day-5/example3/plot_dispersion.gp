set terminal post eps enhanced solid color "Helvetica" 20
set output "phonon_dispersion.eps"
set xrange [0:1.577350]
set yrange [0:1600]
set arrow from 0.6666667,0. to 0.666667,1600 nohead  lw 3
set arrow from 1,0. to 1,1600 nohead  lw 3
set ylabel "{/Symbol w} (cm^{-1})"
unset xtics
set label "{/Symbol G}" at -0.01,-50
set label "K" at 0.6566667,-50
set label "M" at 0.99,-50
set label "{/Symbol G}" at 1.567350,-50

plot "reference/freq.disp.plot" u 1:2 w l lw 2 title 'q-grid: 6x6x1'

