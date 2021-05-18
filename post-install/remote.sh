NPROC=${NPROC:-20}
HPC_HOST=${HPC_HOST:-hpc}
sbatch_options=${sbatch_options:-"--nodes=1 --ntasks=\$NPROC --ntasks-per-node=\$NPROC"}

lastarg() {
    # get the last argument
    for last; do true; done; echo $last;
}

#------------------------------------------------------------------------
# PURPOSE: run "mpirun" remotely on HPC cluster
#          (also copies input file there if needed (via rsync))
#------------------------------------------------------------------------
remote_mpirun() {
    if test $# -lt 2; then
        echo "
USAGE:  remote_mpirun program [options] -inp inputfile

where: 
   program   ... name of QE program (pw.x, ph.x, pp.x, ...)
   options   ... various program's options (aka PARA_POSTFIX)
   -inp      ... mandatory option (its specifies that the input file follows)
   inputfile ... name of inputfile


Example:   remote_mpirun pw.x -nk 2 -inp pw.si.scf.in

This is equivalent to:   pw.x -nk 2 -inp pw.si.scf.in > pw.si.scf.out
but it runs on the HPC cluster (in parallel mode).
"
        return 1
    fi

    input=`lastarg $@`

    if test ! -f $input; then
        echo "
Input file \"$input\" does not exist, 
error while executing: remote_mpirun $@

Did you use \"<\" stdin redirection operator? Use -inp instead.
"
        return 1
    fi

    head=${input%.in}
    output=$head.out
    script=submit.$head
    HERE="~${PWD#$HOME}"
    
    cat > $script.sh <<EOF
#!/bin/sh
mpirun -np $NPROC $@ > $output 2>&1
EOF
    hpc_mkcwd
    rsync_to_hpc $input $script.sh

    echo "
------------------------------------------------------------------------
Submitting to HPC cluster via sbatch:  

   mpirun -np $NPROC $@ > $output 2>&1
------------------------------------------------------------------------
"
    opts=$(eval echo $sbatch_options)
    ssh -x -n -f $HPC_HOST "cd $HERE; echo $opts > checkfile"
    ssh -x -n -f $HPC_HOST "cd $HERE; sbatch $opts $script.sh > $script.log 2>&1"
}


#------------------------------------------------------------------------
# PURPOSE: submit a batch script to HPC cluster
#
#          * a batch script can be a plain shell-script without any
#            batch-queuing options (i.e. "#SBATCH --option ..." lines are not needed)
#          * also copies a script there if needed (via rsync)
#------------------------------------------------------------------------
remote_sbatch() {
    if test $# -ne 1; then
        echo "
USAGE:  remote_sbatch file.sh

where: 
   file.sh ... name of shell-script 

BEWARE: before running this command you need to transfer all needed
input files to HPC cluster, say, via \"rsync_to_hpc\"


Example:   remote_sbatch job.sh

This is equivalent to:   sbatch job.sh
but it is submitted to the HPC cluster.
"   
        return 1
    fi

    if test ! -f $1; then
        echo "
Shell script \"$1\" does not exist, 
error while executing: remote_sbatch $@
"     
        return 1
    fi

    script=$1
    log=${script%.sh}.log
    HERE="~${PWD#$HOME}"

    hpc_mkcwd
    rsync_to_hpc $script

    opts=$(eval echo $sbatch_options)
    echo "
------------------------------------------------------------------------
Submitting to HPC cluster:  

   sbatch $opts $script > $log
------------------------------------------------------------------------
"
    ssh -x -n -f $HPC_HOST "cd $HERE; sbatch $opts $script > $log 2>&1"
}


#------------------------------------------------------------------------
# PURPOSE: submit "pwtk" script to queuing system to HPC cluster
#          (also copies input file there if needed (via rsync))
#------------------------------------------------------------------------
remote_pwtk() {
    if test $# -ne 1; then
        echo "
USAGE:  remote_pwtk file.pwtk

where: 
   file.pwtk ... name of PWTK script


Example:   remote_pwtk run.pwk

This is equivalent to:   pwtk run.pwtk
but it runs on the HPC cluster.
"   
        return 1
    fi

    if test ! -f $1; then
        echo "
PWTK script \"$1\" does not exist, 
error while executing: remote_pwtk $@
"     
        return 1
    fi

    input=$1
    log=${input%.pwtk}.log
    script=submit.$input
    HERE="~${PWD#$HOME}"

    opts=$(eval echo $sbatch_options)
    
    echo "
SLURM $opts {
prefix mpirun -np $NPROC
import $input
}" > $script

    hpc_mkcwd
    rsync_to_hpc $input $script

    echo "
------------------------------------------------------------------------
Submitting to HPC cluster (requested number of processors = $NPROC):  

   pwtk $input > $log
------------------------------------------------------------------------
"
    ssh -x -n -f $HPC_HOST "cd $HERE; pwtk $script > $log 2>&1"
    rm -f $script
}

#------------------------------------------------------------------------
# PURPOSE: execute "squeue -u $USER" on the HPC cluster
#------------------------------------------------------------------------
remote_squeue () {
    ssh -x -n -f $HPC_HOST "echo; squeue -u \$USER"
}


hpc() {
    HERE="~${PWD#$HOME}"
    ssh -t $HPC_HOST "cd $HERE; bash";
}

hpc_mkcwd() {
    # Usage: hpc_mkcwd
    HERE="~${PWD#$HOME}"
    if test x$HERE != x; then
        ssh $HPC_HOST "mkdir -p $HERE"
    fi
}

scp_to_hpc() {
    # Usage: scp_to_hpc files
    # Purpose: will copy file to crysden:$(pwd)/file
    hpc_mkcwd
    HERE="~${PWD#$HOME}"
    scp $@ $HPC_HOST:$HERE
}
rsync_to_hpc() {
    # Usage: rsync_to_hpc files	
    # Purpose: will rsync files to crysden:$(pwd)/file
    hpc_mkcwd   
    HERE="~${PWD#$HOME}"
    rsync -avu $@ $HPC_HOST:$HERE
}

scp_from_hpc() {
    # Usage: scp_from_hpc file
    # Purpose: will copy file from crysden:$(pwd)/file to here
    HERE="~${PWD#$HOME}"    
    scp $HPC_HOST:$HERE/$1 .
}
rsync_from_hpc() {
    # Usage: rsync_from_hpc file
    # Purpose: will rsync file from crysden:$(pwd)/file to here
    HERE="~${PWD#$HOME}"
    rsync -avu $HPC_HOST:$HERE/$1 .
}

update_sissa_reservation_name(){
SLURM_RESERVATION=`ssh -x -n -f $HPC_HOST 'echo $SLURM_RESERVATION'`
cat > ~/sissa_slurm_reservation << EOF
$SLURM_RESERVATION
EOF
}
