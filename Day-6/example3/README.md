# Example 3: 
## Calculation of the electron energy loss spectra (EELS) of bulk silicon 
## using the turbo_eels.x code (Lanczos algorithm)
------------------------------------------------------------------------

 1. Run the SCF ground-state calculation

        pw.x < pw.si.scf.in > pw.si.scf.out

 2. Perform Lanczos recursions

        turbo_eels.x < turbo_eels.si.lanczos.in > turbo_eels.si.lanczos.out

 3. Run the post-processing spectrum calculation

        turbo_spectrum.x < turbo_spectrum.si.in > turbo_spectrum.si.out

 4. Plot the spectrum using `gnuplot` and the script `plot_spectrum.gp`. 

        gnuplot plot_spectrum.gp
        atril silicon_spectrum.eps

 5. Perform a converge test of EELS with respect to the number of 
    Lanczos iterations in two ways:
    - without extrapolation (extrapolation = 'no')  for 500, 750, 1000, 1250, and 1500 iterations;
    - with    extrapolation (extrapolation = 'osc') for 500, 750, 1000, 1250, and 1500 iterations.
    Note 1: Use the "restart" keyword to do this.
    Note 2: For each new calculation, change the name of the input and output files 
            (e.g. turbo_eels.si.lanczos.500.in, turbo_eels.si.lanczos.500.out;
                  turbo_spectrum.si.500.in,     turbo_spectrum.si.500.out)
    What conclusion can you make by comparing the results?
