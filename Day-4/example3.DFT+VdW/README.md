# PURPOSE OF THE EXERCISE:
## DFT study of graphite using Van der Waals functionals
------------------------------------------------------------------------------------

**Steps to perform:**

   Perform a variable-cell optimization : `pw.x < pw.graphite.vc-relax.in > pw.graphite.vc-relax.out`

   Study different cases:
   1. `input_dft = 'vdw-DF'`    @PBE pseudo (non-local)
   2. `input_dft = 'vdw-DF2'`   @PBE pseudo (non-local)
   3. `input_dft = 'rVV10'`     @PBE pseudo (non-local)
   4. `vdw_corr  = 'DFT-D'`     @PBE pseudo (semi-empirical) 
   5. `vdw_corr  = 'DFT-D3'`    @PBE pseudo (semi-empirical)
   6.  Normal PBE calculation   @PBE pseudo
   7.  Normal LDA calculation   @LDA pseudo

   Compare the optimized inter-layer distances with the experimental value of 3.336 A. 


