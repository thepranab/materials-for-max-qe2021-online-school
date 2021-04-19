# Example 2: 
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

    Make the following modifications in the input files:
    
    * In the file _turbo_davidson.benzene.in_  set  `if_dft_spectrum = .false.`
    * In the file _turbo_spectrum.benzene.in_ set  `eign_file = 'Benzene.eigen'`
    * In the script _plot_spectrum.gp_ change the title to _turbo-davidson.x (interacting electrons)_

    Once these modifications are done, repeat steps 2, 3, and 4.
