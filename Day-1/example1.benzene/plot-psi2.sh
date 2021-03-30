
# let us be patient and plot all molecular-orbitals

for xsf in psi2.*_K*.xsf
do
    xcrysden --xsf $xsf --script state.xcrysden --print $xsf.png
done


# now let's arrange all plotted MOs neatly
montage psi2*png -tile 4x4 -geometry 550 -geometry +20+20 montage.png

echo "
------------------------------------------------------------------------
The resulting PNG file with all the MOs is montage.png
------------------------------------------------------------------------
"

# display the result
eom montage.png
