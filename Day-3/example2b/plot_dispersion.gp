set terminal post eps enhanced solid color "Helvetica" 20
set output "phonon_dispersion.eps"
set xrange [0:4.280239]
set yrange [0:450]
set arrow from 1,0. to 1,450 nohead  lw 3
set arrow from 2,0. to 2,450 nohead  lw 3
set arrow from 1.5,0. to 1.5,450 nohead  lw 3
set arrow from 3.4142,0. to 3.4142,420 nohead  lw 3
set ylabel "{/Symbol w} (cm^{-1})"
unset xtics
set label "{/Symbol G}" at -0.05,-15
set label "X" at 0.95,-15
set label "W" at 1.45,-15
set label "X" at 1.95,-15
set label "{/Symbol G}" at 3.37,-15
set label "L" at 4.1897,-15

plot "freq.plot" u 1:2 w l lw 2 title 'q-grid: 4x4x4'

