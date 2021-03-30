#!/bin/bash

# let us be patient and plot all molecular-orbitals

for xsf in `ls -rt ildos_*xsf`
do
    xcrysden -r 2 --xsf $xsf --script ildos-state.xcrysden --print $xsf.png
done

pngs=`ls -rt ildos_*png`
# now let's arrange all plotted MOs neatly
montage $pngs -tile 3x2 -geometry 550 -geometry +20+20 ildos-montage.png

echo "
------------------------------------------------------------------------
The resulting PNG file with all the ILDOSes is ildos-montage.png
------------------------------------------------------------------------
"

# display the result
eom ildos-montage.png
