# set Fermi energy to correct value
Efermi=0.0

set grid
set xzeroaxis lt -1
set xlabel "Energy (eV)"
set ylabel "DOS"
set style fill solid 0.4
set yzeroaxis lt -1

set title "Total DOS\n( press <Enter> in the terminal for the next plot ... )"

plot [:][-3:3] \
     'Fe.dos' u ($1-Efermi):2     notit w filledcurve y1=0.0 lt 1, \
     'Fe.dos' u ($1-Efermi):2     title "majority spin" w l lt 1 lw 2, \
     \
     'Fe.dos' u ($1-Efermi):(-$3) notit w filledcurve y1=0.0 lt 2, \
     'Fe.dos' u ($1-Efermi):(-$3) title "minority spin" w l lt 2 lw 2
pause -1

set title "Orbital projected DOS - PDOS"

set style fill solid 0.2
set ylabel "PDOS"

plot [:][-3:3] \
     'Fe.pdos.pdos_atm#1(Fe)_wfc#2(d)' u ($1-Efermi):2  notit w filledcurve y1=0.0 lt 2, \
     'Fe.pdos.pdos_atm#1(Fe)_wfc#1(s)' u ($1-Efermi):2  notit w filledcurve y1=0.0 lt 1, \
     'Fe.pdos.pdos_atm#1(Fe)_wfc#1(s)' u ($1-Efermi):2  title "majority spin: s-states" w l lt 1 lw 2, \
     'Fe.pdos.pdos_atm#1(Fe)_wfc#2(d)' u ($1-Efermi):2  title "majority spin: d-states" w l lt 2 lw 2, \
     \
     'Fe.pdos.pdos_atm#1(Fe)_wfc#2(d)' u ($1-Efermi):(-$3)  notit w filledcurve y1=0.0 lt 4, \
     'Fe.pdos.pdos_atm#1(Fe)_wfc#1(s)' u ($1-Efermi):(-$3)  notit w filledcurve y1=0.0 lt 7, \
     'Fe.pdos.pdos_atm#1(Fe)_wfc#1(s)' u ($1-Efermi):(-$3)  title "minority spin: s-states" w l lt 7 lw 2, \
     'Fe.pdos.pdos_atm#1(Fe)_wfc#2(d)' u ($1-Efermi):(-$3)  title "minority spin: d-states" w l lt 4 lw 2
pause -1

