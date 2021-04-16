# PURPOSE OF THE EXERCISE:
## Calculation of the projected density of states (PDOS) of FeO using DFT and DFT+U
------------------------------------------------------------------------------------

### Steps to perform:

1. **Standard DFT case**

   Perform a SCF calculation using pw.x :          `pw.x < pw.FeO.scf.in > pw.FeO.scf.out`

   Perform a NSCF calculation using pw.x :         `pw.x < pw.FeO.nscf.in > pw.FeO.nscf.out`

   Perform a calculation of PDOS using projwfc.x : `projwfc.x < projwfc.FeO.in > projwfc.FeO.out` 

   Plot PDOS using the script for gnuplot:         `gnuplot plot_pdos.gp`

2. **DFT+U case**

   Modify input files pw.FeO.scf.in and pw.FeO.nscf.in by setting the
   following:

   `Hubbard_U(1) = 4.6`

   `Hubbard_U(2) = 4.6`

   Here, Hubbard_U(1) and Hubbard_U(2) are the Hubbard parameters 
   for Fe1-3d and Fe2-3d states (in eV).
   The value of U = 4.6 eV was chosen for demonstration purposes;
   Hubbard U can be computed ab initio (see PRB 98, 085127 (2018); PRB 103, 045141 (2021)).

   Repeat all steps as in 1), and determine the PDOS in the DFT+U case.
   
   Note: change the value of the Fermi energy in "plot_pdos.gnu",
   you can find the value of the Fermi energy at the end of the file pw.FeO.nscf.out.
   Note that the Fermi energy must be converged with respect to the k points sampling:
   therefore, here use the Fermi energy computed in the NSCF calculation which
   is more accurate because the k-mesh is denser than in the SCF calculation. 

3. **Calculation of Hubbard U** 

   Modify the input file pw.FeO.scf.in by setting back the following:

   `Hubbard_U(1) = 1.d-8`
 
   `Hubbard_U(1) = 1.d-8`

   Clean the temporary directory:                      `rm -rf tmp/*`

   Perform a SCF calculation using pw.x :              `pw.x < pw.FeO.scf.in > pw.FeO.scf.out`

   Perform a linear-response calculation using hp.x :  `hp.x < hp.FeO.in > hp.FeO.out`

