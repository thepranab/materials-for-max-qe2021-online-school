# Bands of a (collinear) ferromagnet Ni case. 
_In this example, we show how to calculate the band structure of 
ferromagnetic Nickel in the collinear framework._  


* Spin Density case: 
  * `> cd Ni_spindensity`
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

first one is gnuplot or xmgrace type data array files. second one is post script file.

-------------------------------------------------
5. Repeat the step 3 and 4 for the spin-down band
------------------------------------------------
"""
$ bands.x -in ni.band_PP.spindown.in > ni.band_PP.spindown.out

$ plotband.x 
     Input file > ni.spindown.band_data
Reading   10 bands at     81 k-points
Range:    5.7810   47.6380eV  Emin, Emax > 5.7480, 25 
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   0.0000
high-symmetry point: -1.0000 0.0000 0.0000   x coordinate   1.0000
high-symmetry point: -1.0000 0.5000 0.0000   x coordinate   1.5000
high-symmetry point: -0.7500 0.7500 0.0000   x coordinate   1.8536
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   2.9142
high-symmetry point: -0.5000 0.5000 0.5000   x coordinate   3.7802
output file (gnuplot/xmgr) > ni.spindown.xmgr
bands in gnuplot/xmgr format written to file ni.spindown.xmgr                                                                                                                                                                                                                                                
output file (ps) > ni.spindown.ps
Efermi > 15.5758 
deltaE, reference E (for tics) 2.0 15.5758 
bands in PostScript format written to file ni.spindown.ps

--------------------------------------------------------
--------------------------------------------------------
Summary: 
pw.x: scf calculation for ground state; < ni.scf.in
pw.x: nscf calculation for band structure; <ni.band.in 
bands.x : post-process for each spin channel ; <ni.band_PP.spinup.in 




