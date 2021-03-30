# insert here correct Efermi
Ef=0.0
# when Efermi is correctly set uncomment below line
#set yzeroaxis lt -1

set size 1.0, 1.
set multiplot
set size 1.0, 0.67

set origin 0, 0.33
set title "DOS projected to HOMO-3, HOMO-2, HOMO-1, HOMO and LUMO of CO"

set ylabel "PDOS (arb.u.)"
unset tics
unset xlabel


set xtics -10,2
set mxtics 2
set grid xtics, mxtics lw 1.0
set style fill solid 0.2
set bmargin 1
Ys=3
plot [-7-Ef:7+Ef][0:18] \
     'CO-Rh100.proj_to_CO.mopdos' u ($2-Ef):($3+($1-2)*3) notitle w filledcurve lt 1, \
     'CO-Rh100.proj_to_CO.mopdos' u ($2-Ef):($3+($1-2)*3) notitle w l lt 1 lw 3, \
     Ys notitle w l lt -1

set size 1.0, 0.33
set origin 0, 0.
set bmargin 3
unset title
set xlabel "Energy  (eV)"

plot [-7-Ef:7-Ef][:] \
     'CO-Rh100.pdos_atm#2(C)_wfc#2(p)'  u ($1-Ef):2 notitle  w filledcurve lt 1, \
     'CO-Rh100.pdos_atm#2(C)_wfc#2(p)'  u ($1-Ef):2 t 'C p-states' w l lt 1 lw 3, \
     'CO-Rh100.pdos_atm#4(Rh)_wfc#1(d)' u ($1-Ef):2 t 'Rh d-states' w l lt 2 lw 3
pause -1
