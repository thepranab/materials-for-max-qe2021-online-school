set terminal post eps enhanced solid color "Helvetica" 20
set output "Spectrum.eps"
set xrange [0:40.0]
set yrange [0:2.5]
#set yrange [-1.5:6.5]
set xtics 0.0, 5.0, 40.0
set xlabel "{/Symbol w} (eV)"

plot "Si.plot_eps.dat" u ($1):($3) w l lw 2 title '-Im[1/eps]'

#plot "Si.plot_eps.dat" u ($1):($3) w l lw 2 title '-Im[1/eps]',\
#     "Si.plot_eps.dat" u ($1):($4) w l lw 2 title ' Re[eps]   ',\
#     "Si.plot_eps.dat" u ($1):($5) w l lw 2 title ' Im[eps]   '
