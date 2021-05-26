# Exercise 5: running with GPUs

In this section you will learn how to run calculations using QE on an HPC facility provided with GPUs,
trying to optimize the time to solution. 

------------------------------------------------------------------------

Let's go to the exercise5 folder in your $CINECA_SCRATCH directory

~~~~~{.bash}
cd $CINECA_SCRATCH  
cd Day-9/exercise5.GPU-tests/           
~~~~~

------------------------------------------------------------------------

To run the GPU-accelerated version of QE you are supposed to couple **each MPI with a single GPU**. 
Therefore this time your jobscript is setup to request **two MPI processes and 2 GPUs** with your submission script.

------------------------------------------------------------------------

The jobscript file to be used on Marconi100 is already available in this folder and is also reported below for your convenience.

#!/bin/bash
#SBATCH --ntasks-per-node=2     # number of MPI per node
#SBATCH --ntasks-per-socket=2   # number of MPI per socket
#SBATCH --cpus-per-task=8       # number of HW threads per task (equal to OMP_NUM_THREADS*4)
#SBATCH --gres=gpu:2            # this refers to the number of requested gpus per node
#SBATCH --mem=230000MB
#SBATCH --time 00:10:00         # format: HH:MM:SS
#SBATCH --reservation=s_tra_qe
#SBATCH -A tra21_qe
#SBATCH -p m100_usr_prod 
#SBATCH -J qeschool

module load    hpc-sdk/2020--binary    spectrum_mpi/10.3.1--binary   fftw/3.3.8--spectrum_mpi--10.3.1--binary  cuda/11.0

export QE_ROOT=/m100_scratch/usertrain/a08trd1f/Day-9/exercise4.GPU-setup/qe-gpu/

export PW=$QE_ROOT/bin/pw.x

export OMP_NUM_THREADS=1

mpirun  ${PW} -npool 1 -ndiag 1 -inp pw.CuO.scf.in | tee pw.CuO.scf.npool01.ndiag01.nthr01.log  

------------------------------------------------------------------------

1. **Analyze the difference with the previous jobscript** and,
2. **submit this jobscript** witht the usual "sbatch job.sh" command
3. Check the status of the job with "squeue -u USER" command
3. Once the calculation is done, **check the output file**.

------------------------------------------------------------------------


At the beginning of the output file you will spot

     GPU acceleration is ACTIVE.

that confirms that the code is employing GPUs. 
Moreover, this run should be much faster than any of the previous CPU tests, **taking slightly less than 2 minutes**.
You can check this at the bottom of the output file, by searching the usual WALL time.

------------------------------------------------------------------------

4. Now try to **further improve the performance by better exploiting the CPU cores with OpenMP**.

The number of OpenMP cores is set in the job.sh script by the environment variable 

```bash
export OMP_NUM_THREADS=1
```

Change this value to X=2,4,8, and run one calculation for each value. 
Remember to change also the output file name accordingly (e.g. for OMP_NUM_THREADS=2 set pw.CuO.scf.npool01.ndiag01.nthr02.log ).

Compare the WALL times for every run.

------------------------------------------------------------------------

5. You'll notice a small improvement and, eventually a saturation. 

Since the number of MPI processes in this case is bounded by the number of GPUs, the CPU remains partially idle. 
OpenMP can be thus used to better deploy the idle CPU cores. 

------------------------------------------------------------------------

## Pool parallelism

You can also improve the previous result with pool parallelism, as we did for the CPU case. 
However, since this time the number of MPI processes cannot exceed the number of GPUs (2 in this case), you can only use 2 pools. 

1. **Modify the original jobscript**, set `-npool 2`, submit the job.
2. **Check the time to solution.**

You should observe a substantial **reduction of the time to solution** which is now about **3/4 of your previous test**. 
This improvement is actually due to the fact that FTs are now performed without communications, on a single GPU.

------------------------------------------------------------------------

## Oversubscription

For small inputs, one can possibly obtain some additional performance by oversubscribing the GPU.

Try to increase the number of MPI processes used to run this job by changing the jobscript as shown below:

------------------------------------------------------------------------

~~~~~{.bash}
    #!/bin/bash
    #SBATCH --ntasks-per-node=4     # number of MPI per node
    #SBATCH --ntasks-per-socket=4   # number of MPI per socket
    #SBATCH --cpus-per-task=4      # number of HW threads per task
    #SBATCH --gres=gpu:2            # number of gpus per node

    [...]

    export OMP_NUM_THREADS=1

    mpirun  ${PW} -npool 4 -ndiag 1 -inp pw.CuO.scf.in | tee pw.CuO.scf.npool04.ndiag01.log 
~~~~~

------------------------------------------------------------------------

## Compare with theoretical performance

The ratio between the peak performance of the GPU and the CPU is about a factor 20. 

1. **Evaluate the ratio between the best time to solution of your CPU and GPU tests.**
   Do your results reproduce the ideal ratio? Why not?



