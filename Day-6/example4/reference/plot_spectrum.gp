set terminal post eps enhanced solid color "Helvetica" 20
set output "silicon_spectrum.eps"
set xrange [0:30.0]
set yrange [0:3.0]
set xtics 0.0, 5.0, 30.0
set xlabel "E (eV)"
set ylabel "Intensity (unitless)"
plot "silicon.plot_eps.dat" u ($1):($3):($3*0+0.3) with circles lt rgb "red" title 'Sternheimer', \
     "../example3/reference/eels_convergence_with_extrapolation/silicon.plot_eps.500.dat" u ($1):($3) w l lw 2 lt rgb "blue" title 'Lanczos'
