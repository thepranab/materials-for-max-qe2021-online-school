# Exercise 3

Here we test the parallel options of pw.x with the help of some examples.

## Pools

The first option to consider is `-npool`. This sets the number of groups of processors that will perform the task of solving the Kohn-Sham Hamiltonian on a subset of points in reciprocal space.

    # Run it!
    cd CuO

## Task groups

In addition, the parallel performance of the code may be improved by batching together the Fourier transform of multiple bands.
You will check this in the directory `CuO`

## Parallel eigensolver

When the size of the matrix to be diagonalized in the iterative Davidson 
diagonalization becomes large, you can speedup the code by solving the 
generalized eigenvalue problem using multiple MPI processes in parallel.
This is done for example in `C70`

    # Run it!
    cd C70

## OpenMP

When parallel performance saturation is reached, an additional level of parallelism based on OpenMP can further reduce the time to solution.
This can be tested with the `C70` input.

