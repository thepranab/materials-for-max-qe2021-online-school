PURPOSE OF THE EXERCISE 
How to calculate the phonon frequencies of silicon at the Gamma point.

Steps to perform:

#1) Run the SCF ground-state calculation

mpirun -np 2 pw.x < pw.Si.in > pw.Si.out

#2) Run the phonon calculation

mpirun -np 2 ph.x < ph.Si.in > ph.Si.out

#3) Impose the acoustic sum rule at the Gamma point

mpirun -np 2 dynmat.x < dynmat.Si.in > dynmat.Si.out
