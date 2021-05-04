# Magnetic moment under pressure.
_In the previous exercise, we  compared the magnetic and non-magnetic solutions for Fe(bcc). In this second exercise we  see how the exchange splitting and the magnetic moment are reduced when the material is compressed._

_In this exercise  we will use the PBE functional so as to have a  more realistic value for the lattice constant at vanishing pressure._

OPERATIVELY

* cd `Fe-bcc`

* Task1: As in exercise 1 perform  a scan of lattice constants and using `ev.x` compute the optimized lattice constant using the script `task1.sh`

* Task2: The script `task1.sh` extracts also the values of the total magnetization at  each lattice constant and collects them in the `magnetization.dat` file. Looking at it you will see that the magnetization  decreases at smaller volumes: why?

* Task3 magnetic moment vs volume vs exchange splitting. We can have a look at the  the exchange splitting as a function of the moment by evaluating the pdos at selected lattice constants as we did in exercise 1
  * choose alat: 4.5 , 5.0, 5.4 and evaluate the pdos, estimate the exchange splitting.
