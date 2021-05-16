# set Fermi energy to correct value
Efermi=0.0
# ... and uncomment the following line
#set yzeroaxis lt -1

set grid
set xlabel "Energy (eV)"
set ylabel "DOS"
set style fill solid 0.4
set format y "%.1f"

set title "Total DOS\n( press <Enter> in the terminal to exit ... )"

plot [:][:] \
     'graphene.dos' u ($1-Efermi):($1-Efermi<0?$2:0) notit w filledcurve y=0 lt 1, \
     'graphene.dos' u ($1-Efermi):2 notit w l lt 1 lw 2
pause -1
