Installing the Quantum ESPRESSO distribution
============================================

How to get the distribution, how to install it, i.e. produce the
executables; what you need for a succesful installation, and what to do
if the installation is NOT successful! Updated September 2019

---

## Requirements for Quantum ESPRESSO installation

Things that you MUST have on your machine:

-   Unix, or a Unix-like environment (a shell and the Make utility): Mac
    OS-X ok, Windows with `cygwin` or with the recent `Linux subsystem`
    ok
-   a working fortran compiler compliant with the F2003 standard
    (any not-too-old `gfortran` compiler will do the job)
-   a working C compiler (`gcc` is ok)

All hardware is supported, as long as it has what is listed above, BUT:
in order to exploit GPU's, you need to compile the GPU-enabled version
of QE. In order to run in parallel, you MUST have at least one of the
following:

-   working MPI (Message-passing Interface): parallel compiler (`mpif90`
    or similar scripts), MPI libraries, run-time environment (`mpirun`
    or similar launchers)
-   OpenMP-capable compiler and autothreading mathematical libraries
    (for multi-core CPUs)

Apart from MPI libraries, Quantum ESPRESSO is self-contained, but for
real-life usage, you will need to have on your machine:

-   Fast mathematical libraries
-   For parallel execution: fast interprocess communication hardware

---

## Basic Installation

1.  Choose and create a directory where to install Quantum ESPRESSO. It
    should be on a file system that
    -   is local to the PC you are using: sometimes the home directory
        in a PC cluster is accessed via the network (NFS). Moving large
        amount of data via the network MUST BE AVOIDED.
    -   has enough disk space and a large enough disk quota: sometimes
        the home directory is small, or has a quota enforced. The
        compiled complete distribution may take in the order of 1 Gb.

2.  Download in the chosen directory the package q-e-qe-XYZ.tar.gz
    (XYZ=version number).\
    The suffix `.gz` means _compressed by gzip_ (a free utility found on
    most Unix machines).\
    The suffix `.tar` means _archived by tar_ (the standard Unix command
    for archiving and retrieving files) .
3.  Uncompress and unpackage the file:

                tar -zxvf q-e-qe-XYZ.tar.gz
            

    On some machines the `-` is not needed, or the `z` flag (meaning
    _uncompress files compressed by gzip_) is not supported. If so:

                gunzip q-e-qe-XYZ.tar.gz
                tar -xvf q-e-qe-XYZ.tar
            

    A directory `q-e-qe-XYZ/` will be created, containing many files and
    other directories. .

4.  Execute initialization steps, if needed. For instance, in order to
    enable the usage of Intel compiler and MKL libraries, you should set
    a number of variables; for parallel execution, you should have a
    parallel compiler in your path. How to do this *depends on the
    specific machine*. Sometimes one has to use the command `module`, as
    in the following example:

                 module load intel/18.0
                 module load mkl/18.0
                 

5.  Enter the `q-e-qe-XYZ/` directory and execute `./configure`:

                cd q-e-qe-XYZ/
                ./configure
                

    `configure` is a wrapper, calling the `install/configure` script,
    that tries to guess your machine and to choose compilation and
    linking options accordingly (`install/configure` is generated from
    `install/configure.ac` using the complex but well-known Unix
    utility `autoconf`). The result of `configure` is a file called
    `make.inc` containing the compilation and linking options. You may
    want to have a look at it to verify what `configure` thinks about
    your system. Several options to `configure` may (and sometimes,
    have to) be specified (see below).

    -   If you get a message _architecture xxx not recognized_, specify
        option `ARCH=...`, such as e.g. (for a BlueGene machine):

                    ./configure ARCH=ppc64-bg
                    

    -   If `configure` selects a compiler you don't like (or one that
        doesn't like Quantum ESPRESSO) specify option `MPIF90=...` (also
        for serial case), e.g.:

                    ./configure MPIF90=gfortran
                    

    If everything is fine you should get a bunch of (mostly obscure
    and irrelevant) messages but no error. Read the last lines: you may
    need to understand them if something goes wrong at compilation
    stage, or if you need to boost performances.\
    NOTE: if you have a parallel compilation script like `mpif90` in you
    path, `configure` will choose it. With OpenMPI, you can use
    environment variable OMPI\_FC to select the compiler used by the
    `mpif90` script. Use

                ./configure --disable-parallel
                

    to produce a serial executable. Use

                ./configure --enable-openmp 
                

    to produce a parallel executable with OpenMP enabled.

6.  Compile the packages you need. Let us start from PWscf:

            make [-j N] pw 
                

    (\[\] is optional: `-j N` executes `make` in parallel on N
    processors to speed up compilation) `make` is another complex but
    standard unix utility that compiles what is needed in the proper
    order (for instance: in Fortran, you need to compile modules before
    programs that use them). The configuration files
    (Makefiles, dependencies) for `make` are contained n the
    distribution. If everything goes well, executables will appear in
    `bin/`:

            ls bin/*.x
                

7.  Not-so-quick test (for `pw.x` executable only) to verify that things
    look good:

            cd test-suite
                make run-tests-pw-parallel
                

    on a parallel machine, or, on a serial one,

                make run-tests-pw-serial
                

8.  Compile other packages. `make` with no argument yields a list of
    targets, i.e., packages to be compiled. If you want to compile
    everything:

            make [-j N] all 
                

    Some additional packages (notably, W90) that are not contained in
    the QE tarball will be download from the net. **Beware:** this will
    work *only* if you have direct access to the internet, and working
    `wget` or `curl` commands. If not, you will need to download the
    required packages into the `archive/` directory. Then you can do
    `make` again. .

---

## Requirements for installation of a FAST executable

Most of the CPU time in a typical run is spent in:

-   Fast Fourier Transform
-   matrix-matrix and matrix-vector multiplications
-   solution of linear systems, diagonalizations

Quantum ESPRESSO provides a copy of the following libraries:
-   BLAS (Basic Linear Algebra Subroutines):
    <http://www.netlib.org/blas>
-   LAPACK (Linear Algebra Package): <http://www.netlib.org/lapack>
-   FFTW (Fast Fourier-Transform package): <http://www.fftw.org>

but if you want a fast executable, you need machine-optimized BLAS, LAPACK,
FFT libraries; in parallel execution, ScaLAPACK, and if possible, ELPA.

### BLAS, LAPACK

The `configure` script can recognize and use MKL Intel libraries. If you
have no access to fast mathematical libraries, you may try the ATLAS
(Automatically Tuned Linear Algebra Subroutines) library:
[http://math-atlas.sourceforge.net](http://math-atlas.sourceforge.net/)

### FFT

Quantum ESPRESSO can use FFTs from MKL (DFTI) instead of FFTW: You may
want to check for the presence of preprocessing options `-D` in the
definition of DFLAGS in file `make.inc`. If no optimized FFT library is
available, the external FFTW v.3 library will be used if available;
otherwise, the built-in FFTW library contained in the distribution will
be used (its performances are quite good).

### ScaLAPACK

`configure` by default tries to compile support for ScaLAPACK (check for
`-D\_\_SCALAPACK` in DFLAGS, file `make.inc`). For machines with recent
Intel MKL libraries, you may need to specify

         ./configure --with-scalapack=intelmpi
         
or

         ./configure --with-scalapack=openmpi
         
depending upon whether you are linking Intel version of MPI or OpenMPI.

---

## Problematic cases

Most installation problems falls into one of the following categories:

1.  Fortran compiler not installed or not working
    -   buy a commercial compiler: Intel or PGI (the latter can be
        freely downloaded, the former used to be free for personal usage
        but it is no longer).
    -   install or download the GNU `gfortran` compiler (recent versions
        work quite well)

2.  Fortran compiler unable to compile Quantum ESPRESSO: _internal
    compiler error_ or some other strange errors occur. Possible
    solutions:
    -   upgrade to the latest available compiler version, or install the
        patches provided by the vendor (if any)
    -   install and try a different compiler
    -   try to figure out what to do: sometimes lowering the
        optimization level of a specific routine, or splitting a routine
        into pieces, or simply moving around some lines, will do the job

3.  `configure` unable to locate some external libraries you know are
    there. Possible solutions:
    -   bug your system manager until he/she sets up properly the
        libraries, or puts them in a sane location
    -   manually provide the correct location of libraries (you will
        have to use `configure` options, or to edit file `make.inc`)

4.  On parallel machines, `mpif90` doesn't work, or the linker doesn't
    find all that is needed, or the executable yields strange errors.
    Possible solutions:
    -   verify that you are using the correct combination of MPI
        compiler script (`mpif90`), libraries, run-time environment
    -   bug your system manager until he/she sets up properly a working
        combination of compiler, libraries and run-time environment

    In all cases mentioned above, see also the documentation on:
    <http://www.quantum-espresso.org>

When everything else fails...

-   ...read the manual and the documentation in directories Doc/ and
    \*/Doc/
-   search the users' mailing list (follow the link in the "Contacts"
    section of [www.quantum-espresso.org](www.quantum-espresso.org))
-   post to the users' mailing list (subscribe by following the link in
    the Contacts section of
    [www.quantum-espresso.org](www.quantum-espresso.org))

