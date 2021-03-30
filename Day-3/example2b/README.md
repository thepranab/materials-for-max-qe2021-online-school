PURPOSE OF THE EXERCISE 
How to calculate the phonon dispersion of the polar semiconductor AlAs.

Steps to perform:

#1) Run the SCF ground-state calculation

mpirun -np 2 pw.x < pw.AlAs.in > pw.AlAs.out

#2) Run the phonon calculation on a uniform grid of q-points

mpirun -np 2 ph.x < ph.AlAs.in > ph.AlAs.out

#3) Fourrier transform the Interatomic Force Constants from a uniform grid of q-points to real space: C(q) => C(R)

mpirun -np 2 q2r.x < q2r.AlAs.in > q2r.AlAs.out

#4) Calculate frequencies omega(q') at generic q' points using Interatomic Force Constants C(R)

mpirun -np 2 matdyn.x < matdyn.AlAs.in > matdyn.AlAs.out

#5) Plot the phonon dispersion of silicon 

plotband.x < plotband.AlAs.in > plotband.AlAs.out

gnuplot plot_dispersion.gp

atril phonon_dispersion.eps 
