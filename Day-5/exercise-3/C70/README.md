This simulation uses the gamma point to sample the reciprocal space so you cannot exploit pool parallelism.

Modify the jobscript below

    #!/bin/bash
    #SBATCH --exclusive
    #SBATCH --nodes=1
    #SBATCH --ntasks=16            # Number of MPI processes
    #SBATCH --ntasks-per-node=16   # Number of MPI processes
    #SBATCH --cpus-per-task=1      # Number of OpenMP threads
    #SBATCH --ntasks-per-core=1
    #SBATCH --reservation=qe2019
    #SBATCH --gres=gpu:2
    
    module load mpi/openmpi-x86_64 MKL/mkl_2019.4.243
    
    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK   # you may also check what happens if you forget this.
    
    srun --mpi=pmix /path/to/bin/pw.x -inp  pw.C70.scf.in -ndiag 1 > pw.C70.scf.out

in order to:

i. try to improve the time to solution using the `-ndiag` and `-ntg`; Is the time to solution reduced? Why not?

ii. reduce the number of MPI processes and increase the number of OpenMP threads. Is the time to solution reduced?

If you perform 10 scf steps, you should eventually be able to run the simulation in **about 6 min**.
