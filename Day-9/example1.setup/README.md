# Exercise 1: preparing QE

We will first prepare an HPC ready installation of QE. This exercise will show how to compile QE and check for relevant libraries in the context of standard and accelerated systems.

------------------------------------------------------------------------

## CPU version

Download the last release, extract it and rename it with the commands below:

~~~~~{.bash}
wget https://gitlab.com/QEF/q-e/-/archive/qe-6.7MaX-Release/q-e-qe-6.7MaX-Release.tar.bz2
tar xjf q-e-qe-6.7MaX-Release.tar.bz2
mv q-e-qe-6.7MaX-Release qe-cpu
cd qe-cpu
~~~~~


*Note:* for the copy-paste friendly version, open the `README.md` file in each directory. Alternatively you can [click here](https://gitlab.com/QEF/q-e/-/releases) to jump to the web-page with QE releases.


------------------------------------------------------------------------


For the CPU version we will use hpc-sdk and SpectrumMPI which are a good combination on OpenPower machines.
The FFTW library is also required. The environment is setup using the following modules. 

~~~~~{.bash}
module purge
module load hpc-sdk/2020--binary spectrum_mpi/10.3.1--binary fftw/3.3.8--spectrum_mpi--10.3.1--binary  
~~~~~

------------------------------------------------------------------------

Configure QE with the following option, that will select PGI compilers (now rebranded hpc-sdk) and SpectrumMPI

~~~~~{.bash}
./configure  CC=pgcc F77=pgf90 FC=pgf90 F90=pgf90 MPIF90=mpipgifort
~~~~~

------------------------------------------------------------------------

1. **...check that relevant libraries have been detected**, namely on this system, blas, lapack from hpc-sdk and fftw3:

~~~~~{.bash}
    The following libraries have been found:
       BLAS_LIBS=-lblas 
       LAPACK_LIBS=-L/cineca/prod/opt/compilers/hpc-sdk/2020/binary/Linux_ppc64le/2020/profilers/Nsight_Systems/host-linux-ppc64le -llapack -lblas 
       FFT_LIBS= -lfftw3 
~~~~~

*Note:* we did not enable OpenMP in this case since we will be dealing with small input file.
If you plan to run large simulations or you happen to run with accelerators, OpenMP is important and we will indeed enable it in the next section.

------------------------------------------------------------------------

We will only benchmark `pw.x`. Let's compile it with the command

    make -j pw

Now enjoy tea or coffe while you wait 3 minutes or so.

------------------------------------------------------------------------

## GPU version

Now go back to the folder of example1 and download the last release of the GPU accelerated version of QE

~~~~~{.bash}
wget https://gitlab.com/QEF/q-e-gpu/-/archive/qe-gpu-6.7/q-e-gpu-qe-gpu-6.7.tar.bz2
tar xjf q-e-gpu-qe-gpu-6.7.tar.bz2
mv q-e-gpu-qe-gpu-6.7 qe-gpu
cd qe-gpu
~~~~~

*Note:* for the copy-paste friendly version, open the `README.md` file in each directory. Alternatively you can [click here](https://gitlab.com/QEF/q-e-gpu/-/releases) to jump to the web-page with QE-GPU releases.

---

For the GPU version you _must_ use the HPC-SDK which provides a CUDA Fortran compiler. The other libraries remain the same,
except for cuda

~~~~~{.bash}
    module purge
    module load    hpc-sdk/2020--binary    spectrum_mpi/10.3.1--binary   fftw/3.3.8--spectrum_mpi--10.3.1--binary  cuda/11.0
~~~~~

Configure with

~~~~~{.bash}
    ./configure CC=pgcc F77=pgf90 FC=pgf90 F90=pgf90 MPIF90=mpipgifort --enable-openmp --with-cuda=$CUDA_HOME --with-cuda-runtime=11.0 --with-cuda-cc=70 
~~~~~

------------------------------------------------------------------------

1. ...**check that relevant libraries have been detected**, DFLAGS show that *CUDA, CUSOLVER and MPI* will be activated:

~~~~~{.bash}
    setting DFLAGS... -D__PGI -D__CUDA -D__USE_CUSOLVER -D__FFTW -D__MPI
    [...]
    The following libraries have been found:
      BLAS_LIBS=-lblas 
      LAPACK_LIBS=-L/cineca/prod/opt/compilers/hpc-sdk/2020/ binary/Linux_ppc64le/2020/profilers/Nsight_Systems/ host-linux-ppc64le -llapack -lblas 
      FFT_LIBS=
~~~~~

You'll notice that the code is using the internal version of FFTW (`-D__FFTW` instead of `-D__FFTW3`).
This is not an issue in this case since 99% of the FFTs will be performed on the GPU with optimized CUDA libraries.

------------------------------------------------------------------------


Compile again the code

    make -j pw

Congratulations, now you have both a "standard" and an "accelerated" version of `pw.x` to be used in the following exercises.







