# PURPOSE OF THE EXERCISE:
## To show a real (more elaborate) PWTK example of how to glue together various calculations
--------------------------------------------------------------------

The subject of this example is the analysis of bonding of the CO
molecule on the Rh(100) surface by means of various techniques, such
as charge-density difference (DIFDEN), density-of-states projected
(PDOS) to atomic orbitals, density-of-states projected to molecular
orbitals (MOPDOS), and ILDOS (integrated-local density of states). The
analysis reveals the charge-donation from the CO sigma HOMO orbital to
the metal states and the back-donation of charge from the metal states
into the CO pi* LUMO orbital.


**Description of PWTK scripts.**

* `common-data.pwtk` -- input data common to all calculations

* `run-all.pwtk` -- master PWTK script that imports other PWTK scripts
                    and performs all the calculations
		  
* `relax.pwtk` -- script for relaxing the CO-Rh(100) structure

* `difden.pwtk` -- script for calculating charge-density difference

* `ildos.pwtk` -- script for calculation of ILDOSes

* `pdos.pwtk` -- script for calculating PDOS to atomic orbitals, MOPDOS
                 to molecular-orbitals of CO, and plots of
                 molecular-orbitals (psi^2) of CO (**BEWARE**: this is a
                 more elaborate script)

For further explanation of what each script does, see the comments
within the PWTK scripts. To run the whole example locally, execute:

       pwtk run-all.pwtk >& run-all.log &

**Beware** that this example takes a while! **Hence, run it remotely
instead**, i.e.:

       NPROC=8 pwtk run-all.pwtk
 
Note that this example will not run on more than 8 processors (which
is why `NPROC=8` is used), because one among calculations is the
calculation of isolated CO molecule, which is a very small system.

After calculations are finished, download the calculated files from
the HPC cluster to the local host (virtual machine) as:


       rsync_from_hpc . 
       
Beware that the size of all files is large! You do not need locally
the `*.pp` files, hence perhaps you can download only the
*needed* files (`*.in`, `*.out`, `*.xsf`, `*pdos*`).

------------------------------------------------------------------------

### RESULTS can be visualized as follows:


1. To see PDOS and MOPDOS of CO-Rh(100):

        gnuplot moproj.gp

   Prior to plotting PDOS & MOPDOS, you may set the Fermi energy in
   the `moproj.gp` file to the correct value (i.e. `Ef=...`). Fermi
   energy can be obtained as:
   
        grep Fermi pw.CO-Rh100.nscf.out
   
3. Molecular orbitals of CO are written to `psi2.CO_K*_B*.xsf`
   files. You can visualize each of them as, e.g.:

        xcrysden -r 0 --xsf psi2.CO_K001_B005.xsf

   All molecular-orbitals can be automatically visualized as:

        ./plot-psi2.sh


4. ILDOSes are written to files: `ildos_*.xsf`. You can visualize each
   of them as, e.g.:

        xcrysden -r 2 --xsf ildos_-3.05_-2.95.xsf

   All ILDOSes can be automatically visualized as:

        ./plot-ildos.sh


5. Charge-density difference is written to file: `difden.CO-Rh100.xsf`.
   It can be visualized as:

        xcrysden -r 2 --xsf difden.CO-Rh100.xsf
