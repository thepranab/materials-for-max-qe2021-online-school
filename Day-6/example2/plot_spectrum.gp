set terminal post eps enhanced solid color "Helvetica" 20
set output "Benzene_spectrum.eps"
set xrange [0:13.0]
set yrange [0:350]
set xtics 0.0, 1.0, 13.0
set xlabel "{/Symbol w} (eV)"
set ylabel "Intensity (arb. units)"
plot "Benzene.plot_chi.dat"  u ($2)*13.6:($4) w l lw 2 lt rgb "red"   title 'Absorption spectrum'
