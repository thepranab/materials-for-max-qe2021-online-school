# Exercise 4: preparing QE (GPU version)

We will now prepare a GPU installation of QE. 

------------------------------------------------------------------------

Let's go to the exercise4 folder in your $CINECA_SCRATCH directory

~~~~~{.bash}
cd $CINECA_SCRATCH  
cd Day-9/exercise4.GPU-setup/           
~~~~~

------------------------------------------------------------------------

Download the last release of the GPU accelerated version of QE, extract it and rename it with the commands below:

~~~~~{.bash}
wget https://gitlab.com/QEF/q-e-gpu/-/archive/qe-gpu-6.7/q-e-gpu-qe-gpu-6.7.tar.bz2
tar xjf q-e-gpu-qe-gpu-6.7.tar.bz2
mv q-e-gpu-qe-gpu-6.7 qe-gpu
cd qe-gpu
~~~~~

*Note:* for the copy-paste friendly version, open the `README.md` file in each directory. Alternatively you can [click here](https://gitlab.com/QEF/q-e-gpu/-/releases) to jump to the web-page with QE-GPU releases.

---

For the GPU version you _must_ load the cuda module together with the HPC-SDK package. The other libraries remain the same.

~~~~~{.bash}
    module purge
    module load    hpc-sdk/2020--binary    spectrum_mpi/10.3.1--binary   fftw/3.3.8--spectrum_mpi--10.3.1--binary  cuda/11.0
~~~~~

You must also specify the cuda version when launching the configure script

~~~~~{.bash}
    ./configure MPIF90=mpipgifort --enable-openmp --with-cuda=$CUDA_HOME --with-cuda-runtime=11.0 --with-cuda-cc=70 
~~~~~

*Note:* in the next QE releases, it will be sufficient to load only hpc-sdk, and not also cuda, in order to run and compile QE. 
*Note:* Please note that in this case we also enabled OpenMP, which is useful when running large simulations. 

------------------------------------------------------------------------

1. ...**check that relevant libraries have been detected**, DFLAGS show that *CUDA, CUSOLVER and MPI* will be activated:

~~~~~{.bash}
    setting DFLAGS... -D__PGI -D__CUDA -D__USE_CUSOLVER -D__FFTW -D__MPI
    [...]
    The following libraries have been found:
      BLAS_LIBS=-lblas 
      LAPACK_LIBS=-L/cineca/prod/opt/compilers/hpc-sdk/2020/binary/Linux_ppc64le/2020/profilers/Nsight_Systems/host-linux-ppc64le -llapack -lblas 
      FFT_LIBS=
~~~~~

You'll notice that FFT_LIBS field is now empty because the code is using the internal version of FFTW, rather than FFTW3 (`-D__FFTW` instead of `-D__FFTW3`).
This is not an issue in this case since 99% of the FFTs will be performed on the GPU with optimized CUDA libraries (cuFFT).

------------------------------------------------------------------------


Compile again the code

    make -j4 pw

Congratulations, now you have both a "standard" and an "accelerated" version of `pw.x` to be used in the following exercises.

------------------------------------------------------------------------

Check that your installation works by running in parallel a quick random test from the test-suite

    mpirun -np 2 PW/src/pw.x   -inp test-suite/pw_dft/dft1.in

You should find this error:

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     Error in routine readpp (2):
     file /m100/home/usertrain/a08trd1e/espresso/pseudo/Si.pz-vbc.UPF not found
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

because it cannot find the pseudopotential, but it is fine because it means that the installation was successfully done.

------------------------------------------------------------------------

