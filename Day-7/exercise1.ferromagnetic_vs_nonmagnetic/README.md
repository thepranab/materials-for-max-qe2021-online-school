# Exercise 1

## Compare the ferromagnetic and  non-magnetic ground states for Fe(bcc)

_In this part of the exercise you will  compare the total energies for  non-magnetic and ferromagnetic (collinear) Fe(bcc) ground states at different lattice constants._  

* Task 1: perform a scan of the lattice constant for the magnetic solution:
  * go to magnetic directory and run `job.sh` script.
    The script defines a loop over the lattice constants using the command line :
    `pw.x < fe.scf.$latt.in  >>fe.scf.$latt.out`

    and computes the ground state energies for different lattice constants.
    The script then collects the results in the file `energies.dat`.
  * Fit the optimized lattice constant using `ev.x`:
    * enter the command  `ev.x` and answer to the prompts as shown below  
    * `Lattice parameter or Volume are in (au, Ang) >` choose `au` because lattice constants are in atomic units
    * `Enter type of bravais lattice (fcc, bcc, sc, noncubic) >`  we are studying bcc phase of Fe so choose bcc
    * `1=birch1, 2=birch2, 3=keane, 4=murnaghan >`  choose 4  for murnaghan
    * `Input file >`  `energies.dat`  this is the file where computed energie are collected
    * `Output file >` any name _e.g._ `ev.out`
* Task 2: perform a scan of the lattice constant for the non magnetic solution:
  * go to non-magnetic directory and run `job.sh` and repeat the same steps as in Task 1
* Now you can collect the results of these calculations in a plot. You may use `gnuplot`.
  * working in `Day-7/exercise1.magnetic_vs_nonmagnetic/` open `gnuplot` program and type the command:

  `p "magnetic/ev.out" u 1:2 w lp lw 2 pt 7 ps 2 t "Magnetic", "non_magnetic/ev.out" u 1:2 w lp lw 2 pt 7 ps 2 t "ParaMag"`



* The non-magnetic solution has higher energy with respect to the spin-polarized
  solution. Furthermore, the equilibrium lattice constant for the ferromagnetic solution
  is larger than the non-magnetic solution.

  * Comment: the ferromagnetic solution favors volume expansion. why?

## Total dos for non_magnetic and magnetic solution: the exchange splitting.

We  now  focus on ferromagnetic and nonmagnetic solutions at their  optimized lattice constants :
You can retreave the values from your the headers of the `ev.out`  files, _e.g.:_

```txt

# equation of state: murnaghan.        chisq =   0.8353D-07
# a0 =  5.1969 a.u., k0 = 2463 kbar, dk0 =  5.91 d2k0 =  0.000 emin = -254.23756
# a0 =  2.75007 Ang, k0 = 246.3 GPa,  V0 =    70.18 (a.u.)^3,  V0 =   10.40 A^3

```

You should have found:

* non_magnetic alatt= 2.702  A       i.e. 5.107 a.u
* magnetic alatt=     2.75  A       i.e.  5.197 a.u.  

and perform  a Density of states calculation in both cases.


* cd to `non_magnetic/conv`. Here are prepared the input files for your next calculation:

  * `fe.scf.in` the input file for the self consistent calculation at the optimized constant.
    * The file is set for   alat=5.107 a.u.
    * We perform a calculation with  `nspin=2` like for the magnetic calculation. We set  `starting_magnetization=0.0` so that the  initial configuration of the 2 spin channels is symmetric. 
    Such symmetry is conserved during the self consistency loop and the calculation will  thus  converge to the non-magnetic ground state.
    * The k-point mesh has been made denser (14 14 14) for more accurate properties at equilibrium volume:
  * run the calculation:

      `pw.x < fe.scf.in > fe.scf.out`

  * We then run a non-self consistent calculation using the `fe.nscf.in` input file.   
    * We have set `occupations='tetrahedra_opt'`.  In case of a nscf calculation the specified `occupations` type  does not affect the result, but  this option controls the integration mode used by `dos.x` and `projwfc.x` in the following steps.
    * We increase the k-point mesh to 20 20 20. This is feasible for nscf calculations and produce a better quality DOS and pDOS.
  `pw.x < fe.nscf.in >> fe.nscf.out`

* Now we can evaluate the DOS with the program  `dos.x`. 
The input `fe.dos.in` selects the energy region between 5 and 25 eV in order to consider only the _3d_ bands.  Type the command:
`dos.x < fe.dos.in >  fe.dos.out`

* `dos.x` produces the file: `fe.dos` the header indicates the format of the file plus the value of the Fermi Energy.

`#  E (eV)   dosup(E)     dosdw(E)   Int dos(E) EFermi = 21.345 eV`

* Being produced with `nspin=2` the file contains the DOS for the two spin channels. In  this case the 2 channels are equal because the solution is symmetric.  We can plot the spin-up and spin-down DOS.  
  * Start  `gnuplot` and type the commands:
  1. `gnuplot> set parametric`
  1. `gnuplot> Ef=21.345`
  1. `p "fe.dos" u 1:2 w l lw 4 t "Majority", "fe.dos" u 1:(-$3) w l lw 4 t "Minority", Ef,t w i lw 4    t "Fermi Energy"`

* Now repeat the above steps for the magnetic case:

  * go to  `../magnetic/conv` directory
  * check the lattice constant in `fe.scf.in` and `fe.nscf.in` are those indicated in `magnetic/ev.out`
  * ... and do as above:
    1. `pw.x < fe.scf.in > fe.scf.out`
    1. `pw.x < fe.nscf.in > fe.nscf.out`
    1. `dos.x < fe.dos.in > fe.dos.out`
    * for plotting with gnuplot:
      1. `gnuplot> set parametric`
      1. `gnuplot> Ef=20.044`
      1. `p "fe.dos" u 1:2 w l lw 4 t "Majority", "fe.dos" u 1:(-$3) w l lw 4 t "Minority", Ef,t  w i lw 4    t "Fermi Energy"`
* The two spin channels are now splitted with the majority DOS that  shifts below the Fermi level and the minority DOS has now one peak over the Fermi level. 


## Local  dos for the magnetic solution: insights into the exchange splitting.

_We now verify that the  exchange splitting is indeed related to  the partially filled 3d shell of Fe._
Using `projwfc.x` we project the states affected by the exchange splitting into the atomic wavefunctions corresponding to the valence atomic  states of the Fe pseudopotential: `3S 4S 3P 4P 3D`
To do this we use the input file `fe.dos.in` contained in the  `./magnetic/conv` directory.

* run the program with using the `fe.pdos.in` input file:

`projwfc.x < fe.pdos.in >> fe.pdos.out`

* The program produces a projection file for each of the atomic states.
  1. `'fe.pdos_atm#1(Fe)_wfc#1(s)'  --> 3s
  4. 'fe.pdos_atm#1(Fe)_wfc#2(s)'   --> 4s
  2. 'fe.pdos_atm#1(Fe)_wfc#3(p)'   --> 3p 
  5. 'fe.pdos_atm#1(Fe)_wfc#4(p)'`  --> 4p
  3. 'fe.pdos_atm#1(Fe)_wfc#5(d)'   -->  3d

* Inspecting the pdos files you will find that the projected DOS are small for all the atomic states except the _3d_. 

* We can plot the projected the DOS into d-states of Fe, using the file: fe.pdos_atm#1(Fe)_wfc#5(d). The header illustrates the format of the file:
`# E (eV)  ldosup(E)  ldosdw(E) pdosup(E)  pdosdw(E)  pdosup(E)  pdosdw(E)  pdosup(E)  pdosdw(E)  pdosup(E)  pdosdw(E)  pdosup(E)  pdosdw(E)`
The second and third column are the total of up and down channels. The other columns contain the projection on individual d orbitals. In the order:
`dz2_up dz2_dwn dzx_up dzx_dwn dzy_up dzy_dwn dx2-y2_up dx2-y2_dwn dxy_up dxy_dwn`

* Plot the total pDOS for each channel and consider the energy difference corresponding to the peaks, this represents an estimation  of the exchange splitting. In gnuplot type the usual commands:
  1. `set param`
  1. `Ef=20.044`
  1.  `p "fe.pdos_atm#1(Fe)_wfc#5(d)" u 1:2 w l lw 4 t "d bands Majority", "fe.pdos_atm#1(Fe)_wfc#5(d)" u 1:(-$3) w l lw 4 t "d bands Minority", Ef,3 w i lw 4 t "Ef"`

---------------------------------------------------------------------------------------------
