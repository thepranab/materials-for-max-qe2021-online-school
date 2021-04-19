set grid xtics lw 3 lt 1 lc "black"
set border lw 3 
set xtics ("{/Symbol G}"  0.0, "L"  0.866, "W"  1.5731, "X" 2.0731,  "{/Symbol G}" 3.0731, "K" 4.1338) 
set xtics font "Helvetica,24"
set parametric
set trange [0:4.1338]
set yrange [5:25]
p "mybands_data" u 1:2:3 w l lw 6 palette, t,17.901 w l lt 0 lw 6 t "Fermi Energy"
