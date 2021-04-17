# PURPOSE OF THE EXERCISE:
## search of A-lattice parameter (celldm(1)) via PWTK script
----------------------------------------------------------

**Steps to perform:**

1. Read the `alat.pwtk` script and try to understand it. Please **edit the
   file** and **set the requested variables** before running it.
   
   (N.B.: **alat** stands for **A lat**tice parameter)
     
2. To run the example, execute:

       pwtk alat.pwtk
   
   This script runs a series of `pw.x` calculations. Then it executes
   `ev.x` to obtain the lattice parameter and bulk modulus via Murnaghan
   equation-of-state.
