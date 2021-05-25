# Exercise 1: preparing QE (CPU version)

We will first prepare an HPC ready installation of QE. This exercise will show how to compile QE and check for relevant libraries in the context of standard and accelerated systems.

------------------------------------------------------------------------

Download the last release, extract it and rename it with the commands below:

~~~~~{.bash}
wget https://gitlab.com/QEF/q-e/-/archive/qe-6.7MaX-Release/q-e-qe-6.7MaX-Release.tar.bz2
tar xjf q-e-qe-6.7MaX-Release.tar.bz2
mv q-e-qe-6.7MaX-Release qe-cpu
cd qe-cpu
~~~~~


*Note:* for the copy-paste friendly version, open the `README.md` file in each directory. Alternatively you can [click here](https://gitlab.com/QEF/q-e/-/releases) to jump to the web-page with QE releases.


------------------------------------------------------------------------


For the CPU version we will use hpc-sdk and SpectrumMPI which are a good combination for the OpenPower machines of Marconi100.
The FFTW library is also required. The environment is setup using the following modules. 

~~~~~{.bash}
module purge
module load hpc-sdk/2020--binary spectrum_mpi/10.3.1--binary fftw/3.3.8--spectrum_mpi--10.3.1--binary  
~~~~~

------------------------------------------------------------------------

Configure QE with the following option, that will select nvfortran compilers from the hpc-sdk package and SpectrumMPI

~~~~~{.bash}
./configure  MPIF90=mpipgifort
~~~~~

------------------------------------------------------------------------

1. **...check that relevant libraries have been detected**, namely on this system, blas, lapack from hpc-sdk and fftw3:

~~~~~{.bash}
    The following libraries have been found:
       BLAS_LIBS=-lblas 
       LAPACK_LIBS=-L/cineca/prod/opt/compilers/hpc-sdk/2020/binary/Linux_ppc64le/2020/profilers/Nsight_Systems/host-linux-ppc64le -llapack -lblas 
       FFT_LIBS= -lfftw3 
~~~~~

*Note:* we did not enable OpenMP in this case since we will be dealing with small input files.

------------------------------------------------------------------------

We will only benchmark `pw.x`. Let's compile it with the command

    make -j pw

Now enjoy an espresso while you wait 3 minutes or so.

------------------------------------------------------------------------

Check that your installation works by running in parallel a quick random test from the test-suite

    mpirun -np 2 PW/src/pw.x   -inp test-suite/pw_dft/dft1.in

and check "JOB DONE".

