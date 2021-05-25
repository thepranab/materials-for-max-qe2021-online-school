# Bands of a (collinear) magnetic Ni case. 
_In this example, we show how to calculate the band structure of 
ferromagnetic Nickel in the collinear framework._  


* Collinear spin case: 
  * `> cd Ni_collinear`
  * self-consistent calculation for Nickel
               `pw.x < ni.scf.in > ni.scf.out ` 

  * non-self-consistent calculation. In the file ni.band.in note:
    *  the change in the &control namelist:  `calculation='bands'`
    *  the Kpoints setting, we specify the high symmetry points and lines in K-space for the band structure
    * crystal_b: Used for band-structure plots; 
    * k-points are in units of  2 pi/a; in crystal coordinates
    * 6 is the number of high symmetry points 
          ```  
          K_POINTS crystal_b  
          6
            0.000  0.000  0.000  20  !gamma
            0.500  0.500  0.500  10  !L
            0.500  0.250  0.750  10  !W
            0.500  0.000  0.500  10  !X
            0.000  0.000  0.000  20  !gamma
            0.375  0.375  0.750  1   !K
          ```
          
  


 * plot the band structure for spin-up.
   * Edit the file: ni.band_PP.spinup.in
       ```
       &BANDS
       
           outdir='./tempdir/',
           prefix='ni',
           filband='ni.spinup.band_data',---> name of file to store output data for the bands; 
           spin_component = 1, ---> spin component up
       /
       ``` 
   * run the calculation using bands.x:
     `bands.x <ni.band_PP.spinup.in > ni.band_PP.spinup.out` 

     * The run gives the following output files:
       * `ni.spinup.band_data` : energy levels of each k-component
       * `ni.spinup.band_data.gnu` : gnuplot style band data array
       * `ni.spinup.band_data.rap` : irreducible representations information (see also 'ni.band_PP.spinup.out' file)


  * the output of `bands.x` provides the range of band plot (absolute level, not relative to the Fermi level) and the coordinates
    of high symmetry points. 
"""
Range:    5.7480   47.5720eV  Emin, Emax > 5.7480, 25           
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   0.0000
high-symmetry point: -1.0000 0.0000 0.0000   x coordinate   1.0000
high-symmetry point: -1.0000 0.5000 0.0000   x coordinate   1.5000
high-symmetry point: -0.7500 0.7500 0.0000   x coordinate   1.8536
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   2.9142
high-symmetry point: -0.5000 0.5000 0.5000   x coordinate   3.7802
"""


  * Repeat the same steps for for the minority channel

          $ bands.x -in ni.band_PP.spindown.in > ni.band_PP.spindown.out

  * Use gnuplot and the script `bands_colinear.gp` to plot the bands
         gnuplot> load "bands_colinear.gp"


* Plot the Ni bands in the noncollinear case:
  * `cd Ni_noncollinear` 
  * run the collinear scf  calculation for Ni in this directory:
        `pw.x < ni.scf.in > ni.scf.out`
  * run the non-collinear nscf calculation for the bands
    * `spin=2` has been replaced with `noncolinear=.true.` 
         `pw.x < ni.bands.in > ni.bands.out` 
  * run `bands.x` for the noncollinear case: 
    * `spin_component` has been removed and we add `lsigma(3)=.true.` that istructs the program to compute the 
       expectation value for the z component of the spin operator for each eigenfunction and save all values in 
       the file `ni.noncolin.data.3`. All values in this case are either 1/2 or -1/2 as expected. 
    * the program `plot_noncolin_bands.f90` reads this values and writes them together with the band structure in the file  `my_bands.data`.
       * compile the program: 
                  gfortran -o plot_noncolin_bands.x plot_noncolin_bands.f90 
       * copy `ni.noncolin.data.3` to `ni.noncolin.data.s` 
       * run the program
                 ./plot_noncolin_bands.x ni.noncolin.data  
    * use gnuplot and the script `bands_noncollin.gp` to plot the bands in this case. 
      * start `gnuplot and type the command:
                gnuplot> load "bands_noncollin.gp"  

