set terminal post eps enhanced solid color "Helvetica" 20
set output "Benzene_spectrum.eps"
set xrange [0:9.0]
set yrange [0:0.6]
set xtics 0.0, 1.0, 9.0
set xlabel "{/Symbol w} (eV)"
set ylabel "Intensity (arb. units)"
plot "Benzene.plot.dat" u ($1)*13.6:($3)*0.00600 w l lw 2 title 'turbo-davidson.x (no-interacting electrons)', \
     "../example4/reference/epsi_Benzene.dat" u 1:2 w l lw 2 title 'epsilon.x (non-interacting electrons)'  
