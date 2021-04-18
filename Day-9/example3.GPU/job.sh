#!/bin/bash
#SBATCH --ntasks-per-node=2     # number of tasks per node
#SBATCH --ntasks-per-socket=2   # number of tasks per socket
#SBATCH --cpus-per-task=8      # number of HW threads per task (equal to OMP_NUM_THREADS*4)
#SBATCH --gres=gpu:2            # this refers to the number of requested gpus per node, and can vary between 1 and 4
#SBATCH --mem=230000MB
#SBATCH --time 00:10:00         # format: HH:MM:SS
#SBATCH -A cin_QEdevel1_4 
#SBATCH -p m100_usr_prod 
#SBATCH -J qeschool

module load    hpc-sdk/2020--binary    spectrum_mpi/10.3.1--binary   fftw/3.3.8--spectrum_mpi--10.3.1--binary  

export QE_ROOT=../example1.setup/qe-gpu/

export PW=$QE_ROOT/bin/pw.x

export OMP_NUM_THREADS=1

mpirun  ${PW} -npool 1 -ndiag 1 -inp pw.CuO.scf.in | tee no_options
