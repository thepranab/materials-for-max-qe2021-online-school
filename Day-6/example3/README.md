PURPOSE OF THE EXERCISE 
How to calculate the phonon dispersion of 2D hexagonal Boron Nitride.

Steps to perform:

#1) Run the SCF ground-state calculation

mpirun -np 2 pw.x < pw.bn.in > pw.bn.out

#2) Run the phonon calculation on a uniform grid of q-points

mpirun -np 2 ph.x < ph.bn.in > ph.bn.out

#3) Fourrier transform the Interatomic Force Constants from a uniform grid of q-points to real space: C(q) => C(R)

mpirun -np 2 q2r.x < q2r.bn.in > q2r.bn.out

#4) Calculate frequencies omega(q') at generic q' points using Interatomic Force Constants C(R)

mpirun -np 2 matdyn.x < matdyn.bn.in > matdyn.bn.out

#5) Plot the phonon dispersion of silicon 

plotband.x < plotband.bn.in > plotband.bn.out

gnuplot plot_dispersion.gp

atril phonon_dispersion.eps 
