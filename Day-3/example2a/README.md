PURPOSE OF THE EXERCISE 
How to calculate the phonon frequencies of the polar semiconductor AlAs at the Gamma point.

Steps to perform:

#1) Run the SCF ground-state calculation

mpirun -np 2 pw.x < pw.AlAs.in > pw.AlAs.out

#2) Run the phonon calculation at Gamma

mpirun -np 2 ph.x < ph.AlAs.in > ph.AlAs.out

#3) Impose the acoustic sum rule at the Gamma point and add the non-analitic LO-TO splitting

mpirun -np 2 dynmat.x < dynmat.AlAs.in > dynmat.AlAs.out
