# Exercise 3

_Compare the magnetic properties of three different transition metals Fe(bcc), Co(hcp), and Ni(fcc)_


*  We first (re)compute magnetic properties of Fe(bcc):
  * go inside the Fe directory:
    * go in the `Fe` directory:
    * run an SCF calculation:

          pw.x < fe.scf.in > fe.scf.out

     * extract **total magnetization** from `fe.scf.out`. At the end of the calculation the resulting total magnetization is reported in the file. It is actually printed at each step of the SCF cycle. To extract the  final value from the output you may use a comandlike:

           grep "total magnetization" fe.scf.out | tail -1 
     
          In this case you should obtain: 

               total magnetization       =     2.25 Bohr mag/cell


* check also the **magnetization per ionic site**. An estimate of the magnetic moment of each ion in the cell is printed in the outputf file. The estimate  is done integrating the magnetization inside a sphere centered at each site; the integration radii are  chosen so as  to avoid overlapping regions. These quantities may be useful but must always be taken with caution. 
  
       grep -A 1 "Magnetic moment" fe.scf.out  | grep "atom:    1"
  you will get something like this:

```

     atom:    1    charge:   14.4110    magn:    2.3030    constr:    0.0000
```

* run a non-SCF calculation with finer k-grid than SCF calculation for DOS:
                 pw.x < fe.nscf.in > fe.nscf.out



* compute  DOS and PDOS:
               dos.x < fe.dos.in > fe.dos.out
               projwfc.x < fe.pdos.in > fe.pdos.out

* Magnetic properties of ions from Lowdin charges:
  * `projwfc.x` computes  the Lowdin charges for each ion and prints them at the end of the output file. 
  * The last lines of  `fe.pdos.out` contains the summary of Lowdin charges:
  ```
     Lowdin Charges: 

     Atom #   1: total charge =  15.2736, s =  2.2874, p =  6.3712, d =  6.6150, 
                 spin up      =   8.7490, s =  1.1339, 
                 spin up      =   8.7490, p =  3.1223, pz=  1.0408, px=  1.0408, py=  1.0408, 
                 spin up      =   8.7490, d =  4.4929, dz2=  0.9444, dxz=  0.8680, dyz=  0.8680, dx2-y2=  0.9444, dxy=  0.8680, 
                 spin down    =   6.5246, s =  1.1535, 
                 spin down    =   6.5246, p =  3.2489, pz=  1.0830, px=  1.0830, py=  1.0830, 
                 spin down    =   6.5246, d =  2.1221, dz2=  0.3018, dxz=  0.5062, dyz=  0.5062, dx2-y2=  0.3018, dxy=  0.5062, 
                 polarization =   2.2245, s = -0.0197, p = -0.1266, d =  2.3707, 
     Spilling Parameter:   0.0454

  ```
  * The `polarization`  line gives us the information about the magnetization of the ion: 
    * the net magnetic moment is of 2.225 Bohr magnetons. 
    * the magnetic moment is mostly due to the _3d_ states with minor and opposite in sign contribution from the other atomic states. 

    

* We can obtain information about the magnetization of the ions also from the  PDOS graph. 
  * Use the `sumpdos.x` application to extract the total projected DOS on
  Fe _3d_ bands.

       sumpdos.x  'fe.pdos_atm#1(Fe)_wfc#5(d)' > fe.3d.dat

  * Use the  short python script  to integrate the total  PDOS:
           
          python3  integral.py fe.3d.dat

  The script produces a file `fe.3d.dat.int` with 4 columns for energy, integrals up to energy  of the up and down pDOS, integral of PDOS_up - PDOS_dw. The last column provides an estimate of the magnetization. 

  From the header of `fe.dos` we see that the Fermi energy is at `17.8 eV`. Looking in `fe.3d.dat.int` we find:
  ``` 
     #   energy  |   int up pdos    |  int down pdos   |   polarization
     .
     .
     .
       17.800       4.51751506e+00     2.12895871e+00      2.38855635e+00
  ```

  

  



*  Repeat these procedures for Co and Ni. In the case of `Co` take into account that you have two ions in the simulation cell !!!

         pw.x < co.scf.in > co.scf.out
         pw.x < co.nscf.in > co.nscf.out
         dos.x < co.dos.in > co.dos.out
         projwfc.x < co.pdos.in > co.pdos.out
         sumpdos.x co.pdos_atm#1(Co)_wfc#3(d)  co.pdos_atm#2(Co))wfc#3(d)> co.3d.dat


         pw.x < ni.scf.in > ni.scf.out
         pw.x < ni.nscf.in > ni.nscf.out
         dos.x < ni.dos.in > ni.dos.out
         projwfc.x < ni.pdos.in > ni.pdos.out
         sumpdos.x ni.pdos_atm#1\(Ni\)_wfc#3\(d\) > ni.3d.dat

*  Summarize your results _e.g._

  * total magnetization (SCF) Bohr magn/cell
    * Fe    2.25 
    * Co    3.34  (2 atoms per cell)
    * Ni    0.65 
  * position of 3d pdos majoriy peak  w.r.t. Fermi Energy (eV)
    * Fe  -0.91 
    * Co  -0.88
    * Ni  -0.70
  * position of the 3d pdos minority peak w.r.t Fermi Energy (eV)
    * Fe      +2.00 
    * Co      +1.24
    * Ni      +0.15
  * Exch. splittings  (eV)
    * Fe  2.91
    * Co  2.12 
    * Ni  0.85 
  * ion magnetization by Lowdin charges (`projwfc.x` output) in Bohr magn. 
    * Fe
        ```
        polarization =   2.2245, s = -0.0197, p = -0.1266, d =  2.3707
        ```
     * Co
       ```
       polarization =   1.6457, s = -0.0196, p = -0.1288, d =  1.7941
       ```
     * Ni
       ```
       polarization =   0.6457, s = -0.0089, p = -0.0658, d =  0.7204
       ```
