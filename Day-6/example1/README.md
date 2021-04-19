# Example 1: 
## Calculation of the absorption spectrum of benzene molecule (C6H6) using the turbo_davidson.x code

 1. Run the SCF ground-state calculation

        pw.x < pw.benzene.scf.in > pw.benzene.scf.out

 2. Run the turboDavidson calculation using Independent Particle Approximation (IPA).
    This will produce a file Benzene-dft.eigen.

        turbo_davidson.x < turbo_davidson.benzene.in > turbo_davidson.benzene.out

 3. Run the post-processing spectrum calculatioin (this will use Benzene-dft.eigen).
    This will produce a file Benzene.plot.dat

        turbo_spectrum.x < turbo_spectrum.benzene.in > turbo_spectrum.benzene.out

 4. Plot the spectrum using `gnuplot` and the script `plot_spectrum.gp`.
    This will use the file Benzene.plot.dat 

        gnuplot plot_spectrum.gp
        atril Benzene_spectrum.eps

 5. Switch on the electronic interaction (Hartree and Exchange-Correlation) 
    and see how changes the absorption spectrum of benzene.

    Make the following modifications:
    
    * In the file turbo_davidson.benzene.in:
      - set  `if_dft_spectrum = .false.`
      - add `num_eign = 15`
      - keep `num_init = 30`
      - add `num_basis_max = 90`
      - add `start = 0.0`
      - add `finish = 1.0`
      - add `step = 0.001`
      - add `broadening = 0.004`
    * In the file turbo_spectrum.benzene.in set `eign_file = 'Benzene.eigen'`
    * In the script plot_spectrum.gp change the last line to:
      plot "Benzene.plot.dat" u ($1)*13.6:($3) w l lw 2 lt rgb "blue" title 'with interactions', \
     "reference/no_interaction/Benzene.plot.dat" u ($1)*13.6:($3) w l lw 2 lt rgb "red" title 'no interactions'

    Once these modifications are done, repeat steps 2, 3, and 4.
    Note: step 4 is optional in this case.

    Note that the turboDavidson calculation inlcuding interactions is much more expensive than IPA.
