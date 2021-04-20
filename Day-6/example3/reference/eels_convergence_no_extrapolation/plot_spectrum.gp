set terminal post eps enhanced solid color "Helvetica" 20
set output "silicon_spectrum.eps"
set xrange [0:30.0]
set yrange [0:6.0]
set xtics 0.0, 5.0, 30.0
set xlabel "E (eV)"
set ylabel "Intensity (unitless)"
plot "silicon.plot_eps.500.dat"  u ($1):($3)+2.2  w l lw 2 lt rgb "magenta"  title '500 iter.', \
     "silicon.plot_eps.750.dat"  u ($1):($3)+1.5  w l lw 2 lt rgb "blue"     title '750 iter.', \
     "silicon.plot_eps.1000.dat" u ($1):($3)+1.0  w l lw 2 lt rgb "green"    title '1000 iter.', \
     "silicon.plot_eps.1250.dat" u ($1):($3)+0.5  w l lw 2 lt rgb "red"      title '1250 iter.', \
     "silicon.plot_eps.1500.dat" u ($1):($3)      w l lw 2 lt rgb "black"    title '1500 iter.'
