# Exercise 1

## Compare the ferromagnetic and  paramagnetic ground states for Fe(bcc)

_In this part of the exercise you will  compare the total energies for  non-magnetic and ferromagnetic (collinear) Fe  bcc ground states at different lattice constants._  

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
  * go to non-magnetic directory and run job.sh and repeat the same steps as above.
* Now you can collect in a plot the results of these calculation. _E.g._ using gnuplot.
  * working in `Day-7/exercise1.magnetic_vs_paramagnetic/` open `gnuplot` program and type the command:

  `p "magnetic/ev.out" u 1:2 w lp lw 2 pt 7 ps 2 t "Magnetic", "non_magnetic/ev.out" u 1:2 w lp lw 2 pt 7 ps 2 t "ParaMag"`



* The paramagnetic solution has higher energy with respect to the spin-polarized
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

* non_magnetic alatt= 2.713  A       i.e. 5.1267 a.u
* magnetic alatt=     2.702  A       i.e. 5.1070 a.u.  

and perform  a Density of states calculation in both cases.


* cd to `non_magnetic/conv`. Here are prepared the input files for your next calculation:

  * `fe.scf.in` the input file for the self consistent calculation at the optimized constant.
    * The file is set for   alat=5.2127 a.u.
    * We have set  `nspin=2` with `starting_magnetization=0.0`. This make the program start a spin polarized calculation with a spin-symmetric starting configuration that ends up to paramagnetic ground state.
    * The k-point mesh has been made denser (14 14 14) for more accurate properties at equilibrium volume:
  * run the calculation:

  `pw.x < fe.scf.in > fe.scf.out`

  * Then we perform  a non-self consistent run using the `fe.nscf.in` input file.  
    * We have set `occupations=tetrahedra_opt` this is costless because we are doing an scf calculation and is useful to pass this option to `dos.x` and `projwfc.x` programs later.
    * We have increase the k-point mesh to 20 20 20. This is feasible for nscf calculations and produce a better quality DOS and pDOS.
  `pw.x < fe.nscf.in >> fe.nscf.out`

* Now we can evaluate the total dos by using the `dos.x` application. The input `fe.dos.in` selects the energy region between 5 and 25 eV in order to consider only the d bands of Fe.  Type the command:
`dos.x < fe.dos.in >  fe.dos.out`

* It produces the file:   `fe.dos` the header indicates the format of the file plus the value of the Fermi Energy.

`#  E (eV)   dosup(E)     dosdw(E)   Int dos(E) EFermi = 21.345 eV`

* The DOS being produced with `nspin=2` has the DOS for both spin channels but we may verify that as the solution is symmetric for the 2 channels they are equal.  We can plot the 2 DOS to verify.  
  * Start  `gnuplot` and type the commands:
  1. `gnuplot> set parametric`
  1. `gnuplot> Ef=21.345`
  1. `p "fe.dos" u 1:2 w l lw 4 t "Majority", "fe.dos" u 1:3 w l lw 4 t "Minority", Ef,3.0  w i lw 4    t "Fermi Energy"`

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
      1. `p "fe.dos" u 1:2 w l lw 4 t "Majority", "fe.dos" u 1:3 w l lw 4 t "Minority", Ef,3.0  w i lw 4    t "Fermi Energy"`
* The the energy peaks are now shifted with respect to each other by the so-called exchange splitting that favors the magnetic solution.


## Local  dos for the magnetic solution: insights into the exchange splitting.

_We want now to verify that exchange splitting affects the bands deriving from the partially filled d shell of Fe._
We will project the  bands affected by the exchange splitting into the atomic wavefunctions corresponding to the valence atomic  states included in the pseudopotential file `3S 4S 3P 4P 3D`
To do this we will use  the program `projwfc.x`, in `./magnetic/conv` is already present the needed input file `fe.pdos.in`.

* run the program with using the `fe.pdos.in` input file:

`projwfc.x < fe.pdos.in >> fe.pdos.out`

* The program produces a projection file for each of the atomic states.
`'fe.pdos_atm#1(Fe)_wfc#1(s)'  'fe.pdos_atm#1(Fe)_wfc#3(p)'  'fe.pdos_atm#1(Fe)_wfc#5(d)' 'fe.pdos_atm#1(Fe)_wfc#2(s)'  'fe.pdos_atm#1(Fe)_wfc#4(p)'`

* Inspecting the pdos files you will find that the projected DOS are small for all the atomic states except the d.

* We can plot the projected the DOS into d-states of Fe, using the file: fe.pdos_atm#1(Fe)_wfc#5(d). The header illustrates the format of the file:
`# E (eV)  ldosup(E)  ldosdw(E) pdosup(E)  pdosdw(E)  pdosup(E)  pdosdw(E)  pdosup(E)  pdosdw(E)  pdosup(E)  pdosdw(E)  pdosup(E)  pdosdw(E)`
The second and third column are the total of up and down channels. The other columns contain the projection on individual d orbitals. In the order:
`dz2_up dz2_dwn dzx_up dzx_dwn dzy_up dzy_dwn dx2-y2_up dx2-y2_dwn dxy_up dxy_dwn`

* Plot the total pDOS for each channel and consider the energy difference corresponding to the peaks, this represents an estimation  of the exchange splitting. In gnuplot type the usual commands:
  1. `set param`
  1. `Ef=20.044`
  1.  `p "fe.pdos_atm#1(Fe)_wfc#5(d)" u 1:2 w l lw 4 t "d bands Majority", "fe.pdos_atm#1(Fe)_wfc#5(d)" u 1:3 w l lw 4 t "d bands Minority", Ef,3 w i lw 4 t "Ef"`

---------------------------------------------------------------------------------------------
