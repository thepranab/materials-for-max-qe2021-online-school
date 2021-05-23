#!/bin/sh
export PW=pw.x 
export OMP_NUM_THREADS=1
if test -e energies.dat 
then
	mv energies.dat energies.dat_old
fi 
for latt in 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 ; do 
echo "running" $latt 
cat >fe.scf.$latt.in <<EOF 
 &control
    calculation='scf'
    restart_mode='from_scratch',
    !pseudo_dir = '~/pseudo/',
    !outdir='./tempdir/'
    prefix='fe'
 /
 &system
    ibrav = 3, celldm(1) =$latt, nat= 1, ntyp= 1,
    nspin = 1,  
    ecutwfc = 70.0, ecutrho = 850.0,
    occupations='smearing', smearing='marzari-vanderbilt', degauss=0.02
 /
 &electrons
    diagonalization='david'
    conv_thr = 1.0e-8
    mixing_beta = 0.7
 /
ATOMIC_SPECIES
 Fe 55.845 Fe.pz-spn-rrkjus_psl.0.2.1.UPF 
ATOMIC_POSITIONS alat
 Fe 0.0 0.0 0.0
K_POINTS AUTOMATIC 
 10 10 10 1 1 1  
EOF

mpirun -np $NPROC $PW  < fe.scf.$latt.in -nk 2  >  fe.scf.$latt.out  
echo $latt `grep ! fe.scf.$latt.out | awk '{print $5}'` >> energies.dat 
echo $latt "done" 
done 
