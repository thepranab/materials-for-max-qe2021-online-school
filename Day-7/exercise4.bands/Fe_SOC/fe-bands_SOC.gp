Ef=17.782 
set grid xtics lw 3 lt 1 lc "black"
set border lw 3 
set font "Arial,24"
set xtics ("{/Symbol G}"  0.0, "H"  1.000, "N"  1.701, "{/Symbol G}" 2.4142, "P" 3.2802, "H" 4.1463 ) 
set xtics font "Helvetica,24"
set ytics font "Helvetica,18"
set ylabel "Energies (eV)" font "Helvetica,18" 
set parametric
set trange [0:4.1463]
set yrange [-10:5]
p "mybands_data" u 1:($2-Ef):3 w l lw 6 palette not , t,0 w l lt 0 lw 6 t "Fermi Energy"
pause -1
