set ylabel 'Hartree'
set xlabel 'number of steps'
pl 'h2o.evp' u 1:8 w l title 'physical total energy', '' u 1:9 w l title 'constant of motion', '' u 1:6 w l title 'potential energy', '' u 1:($3+$9) w l title 'electron kinetic energy (shifted)'
