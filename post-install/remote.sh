NSC_HOST=nsc
sbatch_options="--nodes=1 --ntasks=8 --ntasks-per-node=8 --mem-per-cpu=2048M --output slurm-%j.log --reservation=qe2019"

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
USAGE:  remote_mpirun program [options] inputfile

where: 
   program  ... name of QE program (pw.x, ph.x, pp.x, ...)
   options  ... various program's options (aka PARA_POSTFIX), including the -inp option 
   inputfile .. name of inputfile


Example:   remote_mpirun pw.x -nk 2 -inp pw.si.scf.in

This is equivalent to:   pw.x -nk 2 -inp pw.si.scf.in > pw.si.scf.out
but it runs on the NSC cluster (in parallel mode).
"
        return 1
    fi

    input=`lastarg $@`
    #prog_opts=${@%$input}

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
mpirun -np 8 $@ > $output 2>&1
EOF
    nsc_mkcwd
    rsync_to_nsc $input $script.sh

    echo "
------------------------------------------------------------------------
Submitting to NSC cluster via sbatch:  

   mpirun -np 8 $@ > $output 2>&1
------------------------------------------------------------------------
"   
    ssh -x -n -f $NSC_HOST "cd $HERE; sbatch $sbatch_options $script.sh > $script.log 2>&1"
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
input files to NSC cluster, say, via \"rsync_to_nsc\"


Example:   remote_sbatch job.sh

This is equivalent to:   sbatch job.sh
but it is submitted to the NSC cluster.
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

    nsc_mkcwd
    rsync_to_nsc $script

    echo "
------------------------------------------------------------------------
Submitting to NSC cluster:  

   sbatch $sbatch_options $script > $log
------------------------------------------------------------------------
"
    ssh -x -n -f $NSC_HOST "cd $HERE; sbatch $sbatch_options $script > $log 2>&1"
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
but it runs on the NSC cluster.
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

    echo "SLURM {
$(cat $input)
}" > $script

    nsc_mkcwd
    rsync_to_nsc $input $script

    echo "
------------------------------------------------------------------------
Submitting to NSC cluster:  

   pwtk $input > $log
------------------------------------------------------------------------
"
    ssh -x -n -f $NSC_HOST "cd $HERE; pwtk $script > $log 2>&1"
    rm -f $script
}

nsc() {
    HERE="~${PWD#$HOME}"
    ssh -t $NSC_HOST "cd $HERE; bash";
}

nsc_mkcwd() {
    # Usage: nsc_mkcwd
    HERE="~${PWD#$HOME}"
    if test x$HERE != x; then
        ssh $NSC_HOST "mkdir -p $HERE"
    fi
}

scp_to_nsc() {
    # Usage: scp_to_nsc files
    # Purpose: will copy file to crysden:$(pwd)/file
    nsc_mkcwd
    HERE="~${PWD#$HOME}"
    scp $@ $NSC_HOST:$HERE
}
rsync_to_nsc() {
    # Usage: rsync_to_nsc files	
    # Purpose: will rsync files to crysden:$(pwd)/file
    nsc_mkcwd   
    HERE="~${PWD#$HOME}"
    rsync -avu $@ $NSC_HOST:$HERE
}

scp_from_nsc() {
    # Usage: scp_from_nsc file
    # Purpose: will copy file from crysden:$(pwd)/file to here
    HERE="~${PWD#$HOME}"    
    scp $NSC_HOST:$HERE/$1 .
}
rsync_from_nsc() {
    # Usage: rsync_from_nsc file
    # Purpose: will rsync file from crysden:$(pwd)/file to here
    HERE="~${PWD#$HOME}"
    rsync -avu $NSC_HOST:$HERE/$1 .
}
