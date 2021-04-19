#Exercise 3

_In this example, we will compare the magnetic properties of metalic Fe(bcc), Co(hcp), and Ni(fcc)
at their ground states._  

*  First, let's calculate the Fe as an example. Run a SCF calculation of Fe:
                   pw.x < fe.scf.in > fe.scf.out

* grep  the spin magnetic moment from fe.scf.out file:
       grep -A 1 "Magnetic moment" fe.scf.out  | grep "atom:    1"
  you will get something like this:

```

     atom:    1    charge:    6.4903    magn:    2.2475    constr:    0.0000
```

* run a non-SCF calculation with finer k-grid than SCF calculation for DOS:
                 pw.x < fe.nscf.in > fe.nscf.out



* we can obtain DOS and PDOS:
               dos.x < fe.dos.in > fe.dos.out
               projwfc.x < fe.pdos.in > fe.pdos.out
* Read  the Fermi Energy from first line of `fe.dos`

* From the PDOS graph, estimate the occupation of spin-up and spin-down electrons.
  We can use the `sumpdos.x` application to extract the total projected DOS on
  Fe 3d bands.
       sumpdos.x  fe.pdos_atm#1(Fe)_wfc#5(d) > fe.3d.dat

Then  we use a  short python script  to integrate the total  PDOS up to the Fermi level:
         python  integral.py fe.3d.dat

*  Repeat these procedures for Co and Ni

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

*  Compare the  magnetic properties of Fe,Co, Ni.
   1. extract magnetic moments per atom from the scf output:
            Fe: 2.3030 mu_B
            Co: 1.753  mu_B X 2
            Ni: 0.6953 mu_B
   2. energy levels of the peaks of spin up/down from the plots w.r.t. Ef
             Fe:  -0.91 eV / +1.94 eV  --->  Delta_Fe= 2.85 eV;  
             Co: -0.83 eV / +1.28 eV   ---> Delta_Co= 2.1 eV;
             Ni: -0.712 eV / 0.11 eV   ---> Delta_Ni= 0.82 eV;
   3. occupation of the spin up/down
              Fe: 4.7238 / 2.3891-->  m_Fe=2.3347 (only d states);  
              Co: 4.8529 / 3.2338-->  m_Co=1.6191 eV (only d states);
              Ni: 4.7955 / 4.2356---> m_Ni=0.5599 eV (only d states)

_Note that (3) values do not take into account the polarization of s-states which are included in (1)_
