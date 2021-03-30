# insert here the correct Fermi energy:
Efermi=0.0
# .. and uncomment the next line:
#set xzeroaxis lt -1

set grid xtics lt -1 lw 1
set format y "%5.1f"
set format x ""
set ylabel "Energy (Ry)"
unset xlabel

set xtics ("L" 0.0000, "{/Symbol G}" 0.8660, "X" 1.8660, "W" 2.3660, "K" 2.7196, "L" 3.3320)

plot [0:3.3320] 'Si.bands.dat.gnu' u 1:($2-Efermi) notitle w linespoints lw 2 pt 6
pause -1

