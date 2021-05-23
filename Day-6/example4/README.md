# Example 4: 
## Calculation of the electron energy loss spectra (EELS) of bulk silicon 
## using the turbo_eels.x code (Sternheimer algorithm)
------------------------------------------------------------------------

 1. Run the SCF ground-state calculation

        pw.x < pw.si.scf.in > pw.si.scf.out

 2. Solve the Sternheimer equations

        turbo_eels.x < turbo_eels.si.sternheimer.in > turbo_eels.si.sternheimer.out

    Note: this calculation is very slow. 

 3. Plot the spectrum using `gnuplot` and the script `plot_spectrum.gp`. 

        gnuplot plot_spectrum.gp
        atril silicon_spectrum.eps

 4. Perform a converge test of EELS with respect to the size of the k mesh:
    consider k meshes 4x4x4, 6x6x6, 8x8x8, 10x10x10.
    To do this, use the Sternheimer (or Lanczos) algorithm.
    Note that Sternheimer is much slower than Lanczos.

 5. Compute and plot the plasmon dispersion, i.e. compute EELS for
    |q| = 0.1, 0.3, 0.5, 0.7, 0.9, 1.1, 1.3 a.u. along the [100] direction.

