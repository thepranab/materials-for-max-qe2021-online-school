# PURPOSE OF THE EXERCISE:
## Convergence pw.x calculations of a simple bulk system (Silicon bulk)
-----------------------------------------------------------------------

Exercise consists of several examples, the first two being the
convergence tests for cutoff energy (ecutwfc) and k-points.

Convergence tests are typically performed by making a series of
calculations and to this end shell-scripts are utilized, e.g., see
the shell-script: `ex1.ecutwfc.classic/ecutwfc.sh`

Instead of shell-scripts one can also use PWTK scripts, which are
*simpler/cleaner*. PWTK (pwtk.quantum-espresso.org) stands for PWscf
ToolKit and is a Tcl-scripting interface for PWscf set of programs
contained in the Quantum-ESPRESSO.

To see the difference between traditional Unix shell-scripts and PWTK
scripts, compare, e.g.,
`ex1.ecutwfc.classic/ecutwfc.sh`  vs  `ex1.ecutwfc/ecutwfc.pwtk`


**Description of examples:**

* `ex1.ecutwfc.classic/` -- convergence tests for cutoff energy
                            (ecutwfc) via traditional Unix shell
                            script

* `ex1.ecutwfc/` -- similar as above but using the PWTK script instead

* `ex2.kpoints/` -- k-points (K_POINTS) convergence tests 

* `ex3.alat/` -- search of lattice parameter of Si bulk
                 (alat = A LATtice parameter)

* `ex4.bands/` -- how to calculate band structure (spaghetti plot)


