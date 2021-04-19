set terminal post eps enhanced solid color "Helvetica" 20
set output "Benzene_spectrum.eps"
set xrange [0:9.0]
set yrange [0:20]
set xtics 0.0, 1.0, 9.0
set xlabel "{/Symbol w} (eV)"
set ylabel "Intensity (arb. units)"
plot "Benzene.plot.dat" u ($1)*13.6:($3) w l lw 2 lt rgb "blue" title 'with interactions', \
     "reference/no_interaction/Benzene.plot.dat" u ($1)*13.6:($3) w l lw 2 lt rgb "red" title 'no interactions'
