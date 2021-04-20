#!/bin/bash

set -e


for f in ../water8*
do
   mpirun -np 12 ~/qe-thermalcurrents/bin/cp.x -in $f | tee $f.out
done
