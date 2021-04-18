# Exercise 1

## System preparation

The configuration of the IJS cluster requires, as a first step, to move to a
compute node. This can be done for example with:

    # From percolator.ijs.si
    ssh nsc-fp001

Update the hands-on repository and source the environment

    cd QE-2019/
    git pull
    cd Day-5
    # Update environment and report scratch space path
    source prepare_node.sh

The command `cd ~ && source QE-2019/Day-5/prepare_node.sh && cd -` has to be
executed at each login on `nsc-fp001`

---

# Information on the environment

In order to compile an optimized version of QE you need:

* a library for linear algebra
* a library for FFT
* (possibly) a parallel eigenvalue solver
* (possibly) an optimized compiler

Let's find these requirements in the system used for this hands-on.

Information about the module environment can be obtained using:

    # Run me!
    module av

This will allow you to find the compilers, the libraries, etc.

You should obtain an output similar to this one:

    $ module av
    
    --------------------------------------------------------------------------------------------------- /cvmfs/sling.si/modules/el7/modules/all ---------------------------------------------------------------------------------------------------
       Autoconf/2.69-GCCcore-5.4.0             FFTW/3.3.7-gompi-2018a                                 OpenMPI/3.1.1-gcccuda-2018b                        flex/2.6.0                             libtool/2.4.6-GCCcore-6.4.0
       Autoconf/2.69-GCCcore-6.4.0             FFTW/3.3.8-gompi-2018b                      (D)        OpenMPI/3.1.3-PGI-19.4                             flex/2.6.3                             libtool/2.4.6-GCCcore-7.3.0
       Autoconf/2.69-GCCcore-7.3.0             GCC/4.8.5                                              OpenMPI/4.0.0-GCC-8.2.0-2.31.1              (D)    flex/2.6.4-GCCcore-6.4.0               libtool/2.4.6-GCCcore-8.2.0      (D)
    [...]
    

The command

    # Run me!
    module load xxx

can be used to prepare the environment (replace xxx with the appropriate module names).
We will target a conventional *Intel-based x86 64-bit platform* in this tutorial.
For such systems, in general, one should proceed as follows:

1. load Intel compilers' module; if not available, look for GNU compilers;
2. load Intel's MPI module; if not available, look for OpenMPI;
3. load the MKL library; if not available, look for OpenBLAS or GoToBlas and Scalapack libraries.

The command

    module show xxx

can be used to check how each module modifies the environment by adding
binaries to the `PATH` or by adding additional environment variables.
This is also a good way to verify where the applications and the
libraries actually reside. Try for example: `module show mpi/openmpi-x86_64`.

The aim of this first (very short) exercise is to identify the best options
you have on this cluster. 

> **Question**: Can you list the modules that you will have to load *before* running the `configure` command of QE❓ [Answer](#A1)

---

<a name="A1"></a> **Answer 1**: multiple options are possible. For example, you may have chosen to load 
`ScaLAPACK/2.0.2-gompi-2018b-OpenBLAS-0.3.1` that silently loads also OpenMPI and BLAS 
libraries. Another (better) option is to use the last version of Intel's MKL library,
by loading the module `mkl_2019.4.243`. An implementation of MPI is, however, still required.

Here we will instead use OpenMPI from this module
     
    $ module load mpi/openmpi-x86_64

since it provides the most recent version of this library and wraps gfortran v9.1,
and the BLAS, LAPACK and ScaLAPACK implementation from the MKL library,
that you should have already loaded with the command:

    $ module load MKL/mkl_2019.4.243
