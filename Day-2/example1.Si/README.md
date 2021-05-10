# PURPOSE OF THE EXERCISE:
## Convergence pw.x calculations of a simple bulk system (Silicon bulk)
-----------------------------------------------------------------------

Exercise consists of several examples, the first two being the
convergence tests for the cutoff energy (`ecutwfc`) and k-points.

Convergence tests are typically performed by making a series of
calculations with aid of shell-scripts, e.g., see
the shell-script: `ex1.ecutwfc.classic/ecutwfc.sh`

Instead of shell-scripts one can also use [PWTK](http://pwtk.ijs.si/)
scripts, which are simpler/cleaner. [PWTK](http://pwtk.ijs.si/) stands
for *PWscf ToolKit*; it is a Tcl-scripting interface for
[Quantum-ESPRESSO](https://www.quantum-espresso.org/).

To see the difference between traditional Unix shell-scripts and PWTK
scripts, compare `ex1.ecutwfc.classic/ecutwfc.sh` vs
`ex1.ecutwfc/ecutwfc.pwtk`

**Logic of examples:** convergence tests for Si bulk consist of the
following steps: 
1. converge the basis-set 
2. converge the k-points 
3. with converged basis-set and k-points calculate lattice-parameter
   of Si bulk
4. with converged basis-set, k-points, and lattice parameter, 
   calculate band structure of Si bulk.

**Description of examples:**

* `ex1.ecutwfc.classic/` -- convergence tests for cutoff energy
                            (`ecutwfc`) via traditional Unix shell
                            script

* `ex1.ecutwfc/` -- similar as above but using the PWTK script instead

* `ex2.kpoints/` --  convergence tests for k-points (`K_POINTS`)

* `ex3.alat/` -- search of lattice parameter of Si bulk
                 (**alat** = ***a* lat**tice parameter)

* `ex4.bands/` -- how to calculate band structure (spaghetti plot)


