# Setting up

We will first prepare an HPC ready installation of QE.


## CPU version

Download the last release, extract it and rename it with the commands below:

    wget https://gitlab.com/QEF/q-e/-/archive/qe-6.7MaX-Release/q-e-qe-6.7MaX-Release.tar.bz2
    tar xjf q-e-qe-6.7MaX-Release.tar.bz2
    mv q-e-qe-6.7MaX-Release qe-cpu
    cd qe-cpu

For the CPU version we will use hpc-sdk and SpectrumMPI which are a good combination on OpenPower machines.
The FFTW library is also required. The environment is setup using the following modules. 

    module purge
    module load hpc-sdk/2020--binary spectrum_mpi/10.3.1--binary fftw/3.3.8--spectrum_mpi--10.3.1--binary  


Configure QE with

     ./configure  CC=pgcc F77=pgf90 FC=pgf90 F90=pgf90 MPIF90=mpipgifort

1. **...check that relevant libraries have been detected**, namely on this system, blas, lapack from hpc-sdk and fftw3:


    The following libraries have been found:
       BLAS_LIBS=-lblas 
       LAPACK_LIBS=-L/cineca/prod/opt/compilers/hpc-sdk/2020/binary/Linux_ppc64le/2020/profilers/Nsight_Systems/host-linux-ppc64le -llapack -lblas 
       FFT_LIBS= -lfftw3 

Note: we did not enable OpenMP in this case since we will be dealing with small input file.
If you plan to run large simulations or you happen to run with accelerators, OpenMP is important and we will indeed enable it in the next section.


We will only need `pw.x` so we compile it with the command

    make -j pw


## GPU version

Now go back to the folder of example1 and download the last release of the GPU accelerated version of QE

    wget https://gitlab.com/QEF/q-e-gpu/-/archive/qe-gpu-6.7/q-e-gpu-qe-gpu-6.7.tar.bz2
    tar xjf q-e-gpu-qe-gpu-6.7.tar.bz2
    mv q-e-gpu-qe-gpu-6.7 qe-gpu
    cd qe-gpu


For the GPU version you must use the HPC-SDK which provides a CUDA Fortran compiler. The other libraries remain the same,
except for cuda

    module purge
    module load    hpc-sdk/2020--binary    spectrum_mpi/10.3.1--binary   fftw/3.3.8--spectrum_mpi--10.3.1--binary  cuda/11.0


Configure with

    ./configure CC=pgcc F77=pgf90 FC=pgf90 F90=pgf90 MPIF90=mpipgifort --enable-openmp --with-cuda=$CUDA_HOME --with-cuda-runtime=11.0 --with-cuda-cc=70 

1. ...**check that relevant libraries have been detected**, DFLAGS show that *CUDA, CUSOLVER and MPI* will be activated:
```
    setting DFLAGS... -D__PGI -D__CUDA -D__USE_CUSOLVER -D__FFTW -D__MPI
    [...]
    The following libraries have been found:
      BLAS_LIBS=-lblas 
      LAPACK_LIBS=-L/cineca/prod/opt/compilers/hpc-sdk/2020/binary/Linux_ppc64le/2020/profilers/Nsight_Systems/host-linux-ppc64le -llapack -lblas 
      FFT_LIBS=
```

You'll notice that the code is using the internal version of FFTW (`-D__FFTW` instead of `-D__FFTW3`).
This is not an issue in this case since 99% of the FFTs will be performed on the GPU with optimized CUDA libraries.

Compile again the code

    make -j pw


Congratulations, now you have both a "standard" and an "accelerated" version of `pw.x` to be used in the following exercises.






