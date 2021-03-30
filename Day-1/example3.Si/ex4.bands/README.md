# PURPOSE OF THE EXERCISE:
## how to calculate band structure (spaghetti plot)
---------------------------------------------------

**Steps to perform:**

1. Read the `bands.pwtk` script and try to understand it. Please **edit
   the file** and **set the requested variables** before running it.

2. To run the example, execute:

       pwtk bands.pwtk

3. Set the correct Fermi energy (variable `Efermi`) in the `plot.gp`
   script. To this end, look into `pw.Si.scf.out` file and search for
   line containing the text `highest occupied level (ev):`. For this
   purpose, you can also use the `grep` command, i.e.:
   
       grep 'highest occupied level' pw.Si.scf.out
      
4. Replot the bands structure, i.e., execute:
     
       gnuplot plot.gp


