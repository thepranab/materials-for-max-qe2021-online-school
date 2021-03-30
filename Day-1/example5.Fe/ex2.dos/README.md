# PURPOSE OF THE EXERCISE:
## How to calculate and plot total DOS and DOS projected to s- and d-orbitals (PDOS)
---------------------------------------------------------------

**Steps to perform:*

1. Read the `dos.pwtk` script and try to understand it. Please insert
   the proper value of *ecutwfc* and *ecutrho* variables as determined
   in the previous `ex1.ecut` example.

2. To run the example, execute:

       pwtk dos.pwtk

3. Set the correct Fermi energy (variable `Efermi`) in the `plot.gp`
   script. To this end, look into `pw.Fe.nscf.out` file and search for
   line containing the text `the Fermi energy is`. For this
   purpose, you can also use the `grep` command, i.e.:
   
       grep 'Fermi energy' pw.Fe.nscf.out
      
4. Replot the DOS, i.e., execute:
     
       gnuplot plot.gp
