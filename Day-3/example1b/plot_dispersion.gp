set terminal post eps enhanced solid color "Helvetica" 20
set output "phonon_dispersion.eps"
set xrange [0:4.280239]
set yrange [0:650]
set arrow from 1,0. to 1,650 nohead  lw 3
set arrow from 2,0. to 2,650 nohead  lw 3
set arrow from 1.5,0. to 1.5,650 nohead  lw 3
set arrow from 3.4142,0. to 3.4142,600 nohead  lw 3
set ylabel "{/Symbol w} (cm^{-1})"
unset xtics
set label "{/Symbol G}" at -0.05,-20
set label "X" at 0.95,-20
set label "W" at 1.45,-20
set label "X" at 1.95,-20
set label "{/Symbol G}" at 3.37,-20
set label "L" at 4.1897,-20

#plot "freq.plot" u 1:2 w l lw 2 title 'q-grid: 4x4x4'

plot "freq.plot" u 1:2 w l lw 2 title 'q-grid: 4x4x4', \
     "reference/freq_q-grid-222.plot" u 1:2 w l lw 2 title 'q-grid: 2x2x2', \
     "reference/data_direct_calculation.dat" u 1:2 w p pt 5 title 'direct calculation', \
     "reference/data_experimental.dat" u 1:2 w p pt 7 title 'experimental data'
