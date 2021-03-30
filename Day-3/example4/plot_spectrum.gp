set terminal post eps enhanced solid color "Helvetica" 20
set output "Benzene_spectrum.eps"
set key off
set xrange [0:9.0]
set yrange [0:0.6]
set xtics 0.0, 1.0, 9.0
set xlabel "{/Symbol w} (eV)"
set ylabel "Intensity (arb. units)"
plot "epsi_Benzene.dat" u 1:2 w l lw 2 
