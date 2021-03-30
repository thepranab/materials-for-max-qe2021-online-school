#!/bin/bash

# let us be patient and plot all molecular-orbitals

for xsf in psi2.*_K*.xsf
do
    xcrysden -r 0 --xsf $xsf --script CO-psi2-state.xcrysden --print $xsf.png    
done


# now let's arrange all plotted MOs neatly
pngs=`ls -rt psi2.*.png`
montage $pngs -tile 4x2 -geometry 550 -geometry +20+20 psi2-montage.png

echo "
------------------------------------------------------------------------
The resulting PNG file with all the MOs is psi2-montage.png
------------------------------------------------------------------------
"

# display the result
eom psi2-montage.png
