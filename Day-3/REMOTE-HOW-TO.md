# How to run calculations remotely on the HPC cluster

Some examples take too long on a laptop computer, hence they will be
run remotely on the HPC cluster. Several utility commands have been
implemented specially for the QE-2021 school to aid at submitting jobs
to HPC cluster. These are:

* `remote_mpirun` -- this is like `mpirun`, but it automatically
  submits the calculation to a queuing system on the "nsc" HPC
  system. 
  
  For example, a `pw.x` calculation can be submitted as:
  
        remote_mpirun pw.x -inp pw.file.in
		
  where `pw.file.in` is the name of the `pw.x` input file. **BEWARE:**
  stdin/stdout redirection does not work for `remote_mpirun`,
  hence you must use `-inp` option (i.e., do note use `<`
  redirection operator). You do not need to specify the number of
  processors, because the default is set to `-np 8`.


* `remote_pwtk` -- this automatically submits the PWTK
  script to queuing system on the "nsc" HPC system. Example:
  
        remote_pwtk script.pwtk
	
  where `script.pwtk` is the name of the PWTK script.


* `remote_sbatch` -- automatically submits the Unix-shell
  script to queuing system on the "nsc"  HPC system. Example:

        remote_sbatch script.sh
		
  where `script.sh` is the name of the Unix-shell script.
  
#### Few other utility commands for "remote" usage

* `nsc` -- this makes `ssh` to "nsc" HPC login node
  (percolator.ijs.si), such that the user will be located in the same
  directory as used locally

* `rsync_to_nsc` -- copies specified files to the "nsc"
  cluster (percolator.ijs.si) to the same directory as is currently
  used locally. Example:

        rsync_to_nsc '*.in'

  This will copy all `*.in` files from local directory to the
  same directory on the "nsc" cluster.

* `rsync_from_nsc` -- download the specified file from the
  "nsc" cluster (percolator.ijs.si) from the same directory as is
  currently used locally. Example:

        rsync_from_nsc '*.out'
		
  This will copy all `*.out` files from the "nsc" cluster.


