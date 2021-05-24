set ylabel "distance (angstrom^2)"
set xlabel "time (ps)"
dt=50.0*2.4189e-5
pl 'msd' u ($0*dt):1 w l title 'O', '' u ($0*dt):3 w l title 'H'

