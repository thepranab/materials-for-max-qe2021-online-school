# Example 6: Calculation of the absorption spectrum of benzene molecule (C6H6) using the turbo_lanczos.x code

 1. Run the SCF ground-state calculation

    ```
    mpirun -np 8 pw.x < pw.benzene.in > pw.benzene.out
    ```

 2. Perform Lanczos recursions 

    ```
    mpirun -np 8 turbo_lanczos.x < turbo_lanczos.benzene.in > turbo_lanczos.benzene.out
    ```

 3. Run the spectrum calculation

    ```
    mpirun -np 8 turbo_spectrum.x < turbo_spectrum.benzene.in > turbo_spectrum.benzene.out
    ```

 4. Plot the spectrum using "gnuplot" and the script "plot_spectrum.gp". 
    This script will make a comparison of the spectra
    calculated using turbo_lanczos.x and turbo_davidson.x

    ```
    gnuplot -> load 'plot_spectrum.gp'
    evince Benzene_spectrum.eps
    ```
