# Example 2: 
## Calculation of the absorption spectrum of benzene molecule (C6H6) using the turbo_lanczos.x code
------------------------------------------------------------------------

 1. Run the SCF ground-state calculation
    Note: no nbnd in the input, i.e. only occupied states will be computed.

        pw.x < pw.benzene.scf.in > pw.benzene.scf.out

 2. Perform Lanczos recursions 

        turbo_lanczos.x < turbo_lanczos.benzene.in > turbo_lanczos.benzene.out

 3. Run the spectrum calculation

        turbo_spectrum.x < turbo_spectrum.benzene.in > turbo_spectrum.benzene.out

 4. Plot the spectrum using `gnuplot` and the script `plot_spectrum.gp`. 
    This script will make a comparison of the spectra
    calculated using `turbo_lanczos.x` and `turbo_davidson.x`

        gnuplot plot_spectrum.gp
        atril Benzene_spectrum.eps

5. Switch on the hybrid pseudo-potential (B3LYP)
    and see how changes the absorption spectrum of methane.

    Make the following modifications in the input files:

    * In the file _pw.methane.in_ add in the `SYSTEM` namelist `input_dft = 'B3LYP'`
    * In the file _turbo_davidson.methane.in_  set  `d0psi_rs = .true.`

    Once these modifications are done, repeat steps 1, 2, 3, and use the script `plot_spectrum_hyb.gp`
    to plot the spectrum.
