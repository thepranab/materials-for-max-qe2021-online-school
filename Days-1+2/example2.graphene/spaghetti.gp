# set Fermi energy to correct value
Efermi=0.0
# ... and uncomment the following line
#set xzeroaxis lt -1

set grid xtics lt -1 lw 1
set format y "%5.1f"
set format x ""
set ylabel "Energy (Ry)"
unset xlabel

set xtics ("{/Symbol G}" 0.0000, "K" 0.6667, "M" 1.0000, "{/Symbol G}" 1.5774)

plot [0:1.7440] 'graphene.bands.dat.gnu' u 1:($2-Efermi) notitle w linespoints lw 2 pt 6
pause -1

