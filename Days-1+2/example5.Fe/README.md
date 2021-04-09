# PURPOSE OF THE EXERCISE:
## How to calculate magnetic system (Iron bulk) and how to properly deal with ultrasoft pseudopotentials
---------------------------------------------------------------------
First try to see the difference between the inputs for ferromagnetic and anti-ferromagnetic iron:

    diff pw.fe_fm.scf.in pw.fe_afm.scf.in
Run the two scf calculations:

    pw.x < pw.fe_fm.scf.in > pw.fe_fm.scf.out
    pw.x < pw.fe_afm.scf.in > pw.fe_afm.scf.out

Analyze the output and pay attention to the value of "total/absolute magnetization" for the two cases.   

The exercise consists of two further examples:

* `ex1.ecut/` -- convergence tests specific for ultrasoft
                 pseudopotentials.  Explore the influence of *dual*
                 parameter (i.e., *dual = ecutrho/ecutwfc*). Notice
                 that default *dual* of 4 is not sufficient for
                 ultrasoft pseudopotentials.


* `ex2.dos/` -- plot total DOS and DOS projected to s- and d-orbitals (PDOS)



