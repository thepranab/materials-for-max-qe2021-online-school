Ef= 20.044
set parametric
set xtics font "Helvetica,18"
set ytics font "Helvetica,18"
set xlabel "Energies (eV)" offset 0,-0.5  font "Helvetica, 16"
set ylabel "DOS  (States/Cell/eV)" offset -0.75,0 font "Helvetica, 16" 
file="fe.pdos_atm#1(Fe)_wfc#5(d)"
 p file  u 1:2 w l lw 4 t "Majority", file u 1:(-$3) w l lw 4 t "Minority", Ef,t w i lw 4 lc "gray" t "Fermi Energy"

