Ef=17.79 
set grid xtics lw 3 lt 1 lc "black"
set border lw 3 
set font "Arial,24"
set xtics ("{/Symbol G}"  0.0, "H"  1.7321, "N"  2.9568, "{/Symbol G}" 3.6639, "P" 4.1639, "H" 5.6639 ) 
set xtics font "Helvetica,24"
set ytics font "Helvetica,18"
set ylabel "Energies (eV)" font "Helvetica,18" 
set parametric
set trange [0:5.6639]
set yrange [-10:5]
p "mybands_data" u 1:($2-Ef):3 w p lw 6 palette not , t,0 w l lt 0 lw 6 t "Fermi Energy"
pause -1
