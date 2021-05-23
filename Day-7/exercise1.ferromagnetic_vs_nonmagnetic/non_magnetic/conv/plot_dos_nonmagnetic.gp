GNUTERM = "qt"
set xtics font "Helvetica,18"
set ytics font "Helvetica,18"
set xlabel "Energy (eV)" font "Helvetica,24" 
set parame
set xrange [-8:4]
Ef = 21.345
## Last datafile plotted: "fe.dos"
p "fe.dos" u ($1-Ef):2 w l lw 4 t "Majority", "fe.dos" u ($1-Ef):(-$3) w l lw 4 t "Minority", 0.0, t w i lw 4 t "Fermi Energy"
pause -1
#    EOF
