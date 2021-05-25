GNUTERM = "qt"
set xtics font "Helvetica,12"
set ytics font "Helvetica,12"
Ef = 20.044
set parametric
set xlabel "Energy (eV)" font "Helvetica,18"
set xrange [-10:4]
## Last datafile plotted: "fe.pdos_atm#1(Fe)_wfc#5(d)"
p "fe.pdos_atm#1(Fe)_wfc#5(d)" u ($1-Ef):2 w l lw 4 t "d bands Majority", "fe.pdos_atm#1(Fe)_wfc#5(d)" u ($1-Ef):(-$3) w l lw 4 t "d bands Minority", 0.0,t w i lw 4 t "Ef"
pause -1 
#    EOF
