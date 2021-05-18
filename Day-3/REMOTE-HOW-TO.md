# How to run calculations remotely on the HPC cluster

Some examples take too long on a laptop computer, hence they will be
run remotely on the HPC cluster, which up to Day-8 is either
hpc-login1.arnes.si, frontend1.hpc.sissa.it, or argo.ictp.it.

## Specifics

Those of you who were allocated to:
- **Arnes cluster** (hpc-login1.arnes.si): do not read output files on
  the cluster (or download them from the cluster), while calculation
  is running. This will likely lead to file corruption. Instead check
  the status of calculation with either `remote_squeue` from the
  virtual-machine or `squeue -u $USER` on the cluster and only when
  the calculation is completed read or download the files.

- **SISSA cluster** (frontend1.hpc.sissa.it): activate
  virtual-private-network (VPN) at the beginning of each hands-on
  session with:

        sissa-openconnect
      
  Beware that *openconnect* will hang if it is already running. If this
  happens, then (1) kill it with `kill-openconnect`, (2) restart the
  network as described [here](../post-install/docs/restart-network.md), 
  and (3) execute again `sissa-openconnect`.

  The slurm reservation name in SISSA needs to be updated each during each 
  session and in the afternoon after 14:00. To update the reservation name 
  simply type the command:

       update_sissa_reservation_name

  Then close the terminal and open a new one. The command has to be executed
  after you have activated the VPN.  

- **ICTP cluster** (argo.ictp.it): there are no specifics.


## Conventional way to run remotely (usually not used during the school)
The conventional way to run calculations remotely is to:

1. Copy the need files to remote computer via `scp` or `rsync`.
2. Log to the remote computer via `ssh`.
3. Create a batch shell-script.
4. Submit the script to batch queuing system (e.g. Slurm).

**BUT** to avoid the above four-steps and to make remote running as easy
as possible, **read the section below**, where it is explained how to
run remotely with a single command!

## Convenience commands for remote running during the QE-2021 school

Several utility commands have been implemented specifically for the
QE-2021 school to aid at submitting jobs to HPC cluster (hence they
are non-standard). These are:

* **`remote_mpirun`** -- this is like `mpirun`, but it automatically
  submits the calculation to a queuing system on the "hpc" HPC
  system. 
  
  For example, a `pw.x` calculation can be submitted as:
  
        remote_mpirun pw.x -in pw.file.in
		
  where `pw.file.in` is the name of the `pw.x` input file. 
  
  **BEWARE:** 
  1. stdin/stdout redirection does not work for `remote_mpirun`, hence
  you must use the `-in` (or `-inp`) option (i.e., do note use the `<`
  redirection operator).

  2. You do not need to specify the number of processors, because
  default is set to 20 processors.
  
  3. The number of processors can be requested via the `NPROC`
     variable as, e.g.:
     
          NPROC=8 remote_mpirun pw.x -in pw.file.in


* **`remote_pwtk`** -- this automatically submits the PWTK
  script to queuing system on the "hpc" HPC system. Example:
  
        remote_pwtk script.pwtk
	
  where `script.pwtk` is the name of the PWTK script.  The number
  of processors (default is `NPROC=20`) can be requested via the
  `NPROC` variable as, e.g.:

        NPROC=8 remote_pwtk script.pwtk


* **`remote_sbatch`** -- automatically submits the Unix-shell
  script to queuing system on the "hpc"  HPC system. Example:

        remote_sbatch script.sh
		
  where `script.sh` is the name of the Unix-shell script. The number
  of processors, different from default is requested via the
  `NPROC` variable (see above).

## Few other utility commands for "remote" usage

* **`hpc`** -- this makes `ssh` to "hpc" HPC login node, such that the
  user will be located in the same directory as used locally

* **`remote_squeue`** -- displays user's jobs in Slurm queue on the
  "hpc" cluster (i.e. executes `squeue -u $USER` remotely)
  
* **`rsync_to_hpc`** -- copies specified files to the "hpc"
  cluster to the same directory as is currently
  used locally. Example:

        rsync_to_hpc '*.in'

  This will copy all `*.in` files from local directory to the
  same directory on the "hpc" cluster.

* **`rsync_from_hpc`** -- download the specified file from the
  "hpc" cluster from the same directory as is
  currently used locally. Example:

        rsync_from_hpc '*.out'
		
  This will copy all `*.out` files from the "hpc" cluster.
