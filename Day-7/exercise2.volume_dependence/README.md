# Magnetic moment under pressure.
_In previous example, we learned how to compare a non-magnetic calculation with respect to the magnetic-collinear one.
Now we focus on Ferromagnetic Iron, bcc , GGA. and see how the lattice constant affects the magnetic moment of the system.
We will see that the magnetic moment progressively reduces by decreasing the lattice constant.
We will then see that this is related to  how the exchange splitting changes under pressure._


OPERATIVELY

* cd `Fe-bcc`

* Task1: As in exercise 1 perform  a scan of lattice constants and using `ev.x` compute the optimized lattice constant using the script `task1.sh`

* Task2: The script `task1.sh` extracts also the estimated magnetic moment of the Fe atom at each lattice constant and collects them in the `magmom.dat` file. Looking at it you will see that the magnetic moment decreases at smaller volumes.
  * you will see that the magnetic moment decreases by decreasing the lattice constant: why?

* Task3 magnetic moment vs volume vs exchange splitting. We can have a look at the  the exchange splitting as a function of the moment by evaluating the pdos at selected lattice constants as we did in exercise 1
  * choose alat: 4.5 , 5.0, 5.4 and evaluate the pdos, estimate the exchange splitting.
