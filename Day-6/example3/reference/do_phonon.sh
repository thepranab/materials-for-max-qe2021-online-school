#!/bin/sh

mpirun -np 8 pw.x < pw.bn.in > pw.bn.out
mpirun -np 8 ph.x < ph.bn.in > ph.bn.out
mpirun -np 8 q2r.x < q2r.bn.in > q2r.bn.out
mpirun -np 8 matdyn.x < matdyn.bn.in > matdyn.bn.out
mpirun -np 1 plotband.x < plotband.bn.in > plotband.bn.out
