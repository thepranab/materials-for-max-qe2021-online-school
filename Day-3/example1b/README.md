PURPOSE OF THE EXERCISE 
How to calculate the phonon dispersion of silicon.

Steps to perform:

#1) Run the SCF ground-state calculation

mpirun -np 2 pw.x < pw.Si.in > pw.Si.out

#2) Run the phonon calculation on a uniform grid of q-points

mpirun -np 2 ph.x < ph.Si.in > ph.Si.out

#3) Fourrier transform the Interatomic Force Constants from a uniform grid of q-points to real space: C(q) => C(R)

mpirun -np 2 q2r.x < q2r.Si.in > q2r.Si.out

#4) Calculate frequencies omega(q') at generic q' points using Interatomic Force Constants C(R)

mpirun -np 2 matdyn.x < matdyn.Si.in > matdyn.Si.out

#5) Plot the phonon dispersion of silicon 

plotband.x < plotband.Si.in > plotband.Si.out

gnuplot plot_dispersion.gp

atril phonon_dispersion.eps 
