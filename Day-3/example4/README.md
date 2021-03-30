# Example 4: Calculation of the absorption spectrum of benzene molecule (C6H6) using the Independent Particle Approximation

 1. Run the SCF ground-state calculation

    ```
    mpirun -np 8 pw.x < pw.benzene.in > pw.benzene.out
    ```

 2. Run the spectrum calculation

    ```
    mpirun -np 8 epsilon.x < epsilon.benzene.in > epsilon.benzene.out 
    ```

 3. Plot the spectrum using "gnuplot" and the script "plot_spectrum.gp":

    ```
    gnuplot -> load 'plot_spectrum.gp'
    evince Benzene_spectrum.eps
    ```
