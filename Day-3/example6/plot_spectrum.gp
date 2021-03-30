set terminal post eps enhanced solid color "Helvetica" 20
set output "Benzene_spectrum.eps"
set xrange [0:9.0]
set yrange [0:0.2]
set xtics 0.0, 1.0, 9.0
set xlabel "{/Symbol w} (eV)"
set ylabel "Intensity (arb. units)"
plot "Benzene.plot_chi.dat" u ($2)*13.6:($4)*0.000276 w l lw 2 title 'turbo-lanczos.x (interacting electrons)', \
     "../example5/reference/with_interaction/Benzene.plot.dat" u ($1)*13.6:($3)*0.006 w l lw 2 title 'turbo-davidson.x (interacting electrons)'
