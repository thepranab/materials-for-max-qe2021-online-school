Ef= 20.044
set parametric
set xtics font "Helvetica,18"
set ytics font "Helvetica,18"
set xlabel "Energies (eV)" offset 0,-0.5  font "Helvetica, 16"
set ylabel "DOS  (States/Cell/eV)" offset -0.75,0 font "Helvetica, 16" 
 p "fe.dos" u 1:2 w l lw 4 t "Majority", "fe.dos" u 1:(-$3) w l lw 4 t "Minority", Ef,t w i lw 4 lc "gray" t "Fermi Energy"
pause -1
