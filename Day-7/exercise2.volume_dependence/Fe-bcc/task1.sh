#!/bin/sh
export OMP_NUM_THREADS=1
export PW=pw.x
if test -e magmom.dat
then
	mv magmom.dat magmom.dat_old
fi 
if test -e energies.dat
then 
	mv energies.dat energies.dat_old
fi
if test -e magnetization.dat
then
	mv magnetization.dat magnetization.dat_old
fi
for latt in 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.39 5.5 5.6 5.7 5.8 5.9 6.0; do 
echo 'running ' $latt
cat >fe.scf.$latt.in <<EOF 
 &control
    calculation='scf'
    restart_mode='from_scratch',
    !pseudo_dir = '~/QE-2021/pseudo', ! uncomment if ESPRESSO_PSEUDO variable is unset
    outdir='./tempdir/'
    prefix='fe'
 /
 &system
    ibrav = 3, celldm(1) =$latt, nat= 1, ntyp= 1,
    nspin = 2,  starting_magnetization(1)=0.7,
    ecutwfc = 70, ecutrho = 850.0,
    occupations='smearing', smearing='marzari-vanderbilt', degauss=0.02
 /
 &electrons
    diagonalization='david'
    conv_thr = 1.0e-8
    mixing_beta = 0.7
 /
ATOMIC_SPECIES
 Fe 55.845 Fe.pbe-spn-rrkjus_psl.0.2.1.UPF 
ATOMIC_POSITIONS alat
 Fe 0.0 0.0 0.0
K_POINTS AUTOMATIC 
 10 10 10 1 1 1  
EOF

mpirun -np 2 $PW  -nk 2 -i  fe.scf.$latt.in  >fe.scf.$latt.out  
echo $latt 'done'
echo $latt `grep ! fe.scf.$latt.out | awk '{print "   "$5}'` >> energies.dat 
#echo $latt `grep Magnetic\ moment -A 1 fe.scf.$latt.out | grep atom\ \ \ 1 | awk '{print "   "$7}'` >> magmom.dat
echo $latt `grep total\ magnetization fe.scf.$latt.out | tail -1 | awk '{print "   "$4}'` >> magnetization.dat 
done 
