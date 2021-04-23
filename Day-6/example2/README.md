# Example 2: 
## Calculation of the absorption spectrum of benzene molecule (C6H6) using the turbo_lanczos.x code
------------------------------------------------------------------------

 1. Run the SCF ground-state calculation
    Note: no nbnd in the input, i.e. only occupied states will be computed.

        pw.x < pw.benzene.scf.in > pw.benzene.scf.out

 2. Perform Lanczos recursions 

        turbo_lanczos.x < turbo_lanczos.benzene.in > turbo_lanczos.benzene.out

 3. Run the post-processing spectrum calculation

        turbo_spectrum.x < turbo_spectrum.benzene.in > turbo_spectrum.benzene.out

 4. Plot the spectrum using `gnuplot` and the script `plot_spectrum.gp`. 
    This script will make a comparison of the spectra
    calculated using `turbo_lanczos.x` and `turbo_davidson.x`

        gnuplot plot_spectrum.gp
        atril Benzene_spectrum.eps

 5. Perform a converge test of the absorption spectrum with respect to the number of 
    Lanczos iterations in two ways (for ipol=1):
    - without extrapolation (extrapolation = 'no')  for 500, 1000,  and 1500 iterations;
    - with    extrapolation (extrapolation = 'osc') for 500, 1000,  and 1500 iterations.
    Note 1: Use the "restart" keyword to do this.
    Note 2: For each new calculation, change the name of the input and output files
            (e.g. turbo_lanczos.benzene.500.in,  turbo_lanczos.benzene.500.out;
                  turbo_spectrum.benzene.500.in, turbo_spectrum.benzene.500.out)
    What conclusion can you make by comparing the results?

    TurboLanczos (ipol=4) and turboDavidson give exactly the same spectrum when both methods 
    are converged with respect to the kinetic-energy cutoff, cell size, number of iterations 
    (for Lanczos) or number of eignevalues (for Davidson). You can check this for benzene or 
    check this paper: Comput. Phys. Commun. 185, 2080 (2014).
