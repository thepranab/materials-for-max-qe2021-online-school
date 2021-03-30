# Compile QE-GPU

The accelerated version of QE is written in CUDA Fortran. 
This extension of the Fortran programming language is fully implemented only by the PGI Compilers.
These are available on most clusters and can be freely downloaded from the PGI website.

## Preparing the environment

The IJS system configuration requires to compile codes on a compute node.
If you haven't done it already, you can reach a compute node with:

    ssh nsc-fp001

Once logged in, run:

    cd ~ && source QE-2019/Day-5/prepare_node.sh && cd -

## GPU accelerated QE

The accelerated version of QE requires PGI compilers and a set of libraries provided by the CUDA Toolkit.
In order to proceed, 

* load the *OpenMPI* library that wraps **PGI compilers** (find it!) and check that mpif90 points to pgf90. To this aim, `mpif90 --version` will do.
* check that the CUDA Toolkit is available in the modules and has been loaded.

The GPU version also strongly benefits from linking to the MKL library
thus, when possible, use it.

> **Question**: what are the modules that you need to load on the IJS cluster❓ [Answer](#A1)

## Downloading

You can obtain the last version of the code here: gitlab.com/QEF/q-e-gpu.

In this tutorial we will use the development version since it includes some
important updates required to correctly configure the code against the
latest PGI compilers' release.

You can get it with:

    # Run it!
    wget https://gitlab.com/QEF/q-e-gpu/-/archive/gpu-develop/q-e-gpu-gpu-develop.tar.gz
    tar xzf q-e-gpu-gpu-develop.tar.gz
    cd q-e-gpu-gpu-develop


## Configuring QE-GPU

A few important notes about the accelerated version of the code:

1. QE-GPU *requires* OpenMP.
2. You will have to specify where the CUDA Runtime is installed and its version and, in addition, the compute capabilities of the card that you plan to use. **Cards with different compute capabilities from the one specified at compile time will not execute the code correctly**. In addition you may run into wired error, be warned!
3. It is advisable to disable the parallel eigenvalue solver (this may change in the near future).

All these requirements can be translated into this configure line:

    ./configure --with-cuda=XX --with-cuda-runtime=Y.y --with-cuda-cc=ZZ --enable-openmp --with-scalapack=no 

where `XX` is the location of the CUDA Toolkit (in HPC environments it is
generally $CUDA_HOME), `Y.y` is the version of the CUDA Toolkit (`Y` and `y` are the two numbers identifying major and minor release, e.g. 9.0)  and `ZZ` is the compute capability of the card.

> **Question**: what is the correct value of ZZ command for the K40 and the V100 cards❓ [Answer](#A2)

Note that a helper script is also available in the `dev-tools` directory and can be used like this: `python get_device_props.py` but you must run it on the target compute node.


Notice that sometimes the configure script may pick up the wrong Fortran compiler
if more than one is available. This is the case for the nodes used in this
hands-on so the PGI compilers must be specified manually and the configure command
becomes:

     ./configure FC=pgf90 CC=pgcc MPIF90=mpif90 --enable-parallel --enable-openmp --with-cuda-cc=ZZ --with-cuda-runtime=YY --with-cuda=$SET_ME --with-scalapack=no

> **Question**: replace `YY`, `SET_ME` and `ZZ` with the appropriate values. Use `module show CUDA/10.1.105` to check the path where CUDA is installed. ❓ [Answer](#A3)

Once the configure script finishes, you should get something similar to this output:

    setting DFLAGS... -D__CUDA -D__PGI -D__DFTI -D__MPI
    setting IFLAGS... -I$(TOPDIR)/include -I$(TOPDIR)/FoX/finclude -I$(TOPDIR)/S3DE/iotk/include/ -I/home/griduser0002/intel/mkl/include
    configure: creating ./config.status
    config.status: creating install/make_lapack.inc
    config.status: creating include/configure.h
    config.status: creating make.inc
    config.status: creating configure.msg
    config.status: creating install/make_wannier90.inc
    config.status: creating include/c_defs.h
    --------------------------------------------------------------------
    ESPRESSO can take advantage of several optimized numerical libraries
    (essl, fftw, mkl...).  This configure script attempts to find them,
    but may fail if they have been installed in non-standard locations.
    If a required library is not found, the local copy will be compiled.
    
    The following libraries have been found:
      BLAS_LIBS=-L/possibly/a/path/to/mkl/lib/intel64_lin -lmkl_intel_lp64  -lmkl_core -lmkl_intel_thread
      LAPACK_LIBS=
      FFT_LIBS=
      
      
    
    Please check if this is what you expect.
    
    If any libraries are missing, you may specify a list of directories
    to search and retry, as follows:
      ./configure LIBDIRS="list of directories, separated by spaces"
    
    Parallel environment detected successfully.\
    Configured for compilation of parallel executables.
    
    For more info, read the ESPRESSO User's Guide (Doc/users-guide.tex).
    --------------------------------------------------------------------
    configure: success


Final comment: depending on the version of PGI you may see `mkl_intel_thread`
or `mkl_pgi_thread` in the `BLAS_LIBS` variable.


## Compilation

Only the `pw.x` is available for the time being. You compile it in the usual way:

    # Run me!
    make -j pw

## Answers

<a name="A1"></a> **Answer 1**: a good choice is

     module load OpenMPI/3.1.3-PGI-19.4 MKL/mkl_2019.4.243 CUDA/10.1.105

<a name="A2"></a> **Answer 2**: 

The NVIDIA V100 cards have compute capability 7.0, thus ZZ=70, for the NVIDIA Tesla K40: ZZ=35.

<a name="A3"></a> **Answer 3**: The cuda runtime is 10.1, the compute capabilities are 35, the path where CUDA resides is set by the module as the `CUDA_HOME` variables, thus: `--with-cuda-cc=35 --with-cuda-runtime=10.1 --with-cuda=$CUDA_HOME`.
