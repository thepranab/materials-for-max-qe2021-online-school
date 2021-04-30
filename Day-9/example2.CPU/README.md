# Optimize CPU execution

In this section we only make use of CPUs and try to optimize the time to solution keeping the amount of compute power fixed.

-------

## 1. Pool parallelism

Optimize the number of kpoint pools, starting with 1 up to 8 (what are the admissible values for this option?). 
The jobscript file to be used on Marconi100 is already available in this folder and is also reported below for your convenience.

---

~~~~~{.bash}
#!/bin/bash
#SBATCH --nodes=1              # number of nodes
#SBATCH --ntasks-per-node=16   # number of MPI per node
#SBATCH --cpus-per-task=4      # number of HW threads per task
#SBATCH --mem=230000MB
#SBATCH --time 00:30:00         # format: HH:MM:SS
#SBATCH -p m100_usr_prod
#SBATCH -J qeschool

module load    hpc-sdk/2020--binary    spectrum_mpi/10.3.1--binary   fftw/3.3.8--spectrum_mpi--10.3.1--binary  

export QE_ROOT=../example1.setup/qe-cpu/

export PW=$QE_ROOT/bin/pw.x

# This sets OpenMP parallelism, in this case we do a pure MPI 
export OMP_NUM_THREADS=1 

# Run pw.x with default options for npool and ndiag
mpirun  ${PW} -npool 1 -ndiag 1 -inp pw.CuO.scf.in | tee no_options
~~~~~

-------

1. First, **submit the job as is**, with npool set to 1. 
2. Second, **open the job-script file** (`job.sh`) and **change the number of pools to be used `-npool X`**, with X={2,4,8}. Don't forget to rename the output file as well.
3. **Collect the time** taken by the code as a function of the number of k point pools.

The execution time can be obtained by looking at one of the last lines of the output, that reads for example

    PWSCF        :   5m53.84s CPU   5m58.18s WALL

the WALL time is the value you want to note down (if you wonder what CPU time is, [check wikipedia](https://en.wikipedia.org/wiki/CPU_time) ).

-------

You should be able to produce a plot similar to this one:

![](pool.png)

Congrats! With the same computational resources, the time to solution is reduced by 1/3!

---

Pool parallelism can be actually much better than what you obtained in this example.
Indeed for this small input file the parallelization on plane waves
is good enough, especially because all our MPI processes reside on a single node and inter-process communication is fast.

-------

## 2. Parallel diagonalization

In this second part we want to speedup the code by solving the dense eigenvalue problem using more than one core. 

1. **Set `-npool` to 4 and activate parallel diagonalization by changing `-ndiag 4`** to improve the performance.

2. Inspect the beginning of the output file and look for this message

```
Subspace diagonalization in iterative solution of 
the eigenvalue problem:
one sub-group per band group will be used
custom distributed-memory algorithm 
(size of sub-group:  2*  2 procs)
```

---

3. Check the time to solution. Did you manage to reduce the WALL time?

Unfortunately you'll notice that the simulation is actually **taking longer**.


There are two reasons for this:

1. the eigenvalue is too small to take advantage of parallel diagonalization,
2. we didn't use optimized libraries for this task. The code is using a suboptimal parallel eigensolver. Two common options to improve in this case are linking Scalapack or ELPA libraries.


