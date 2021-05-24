# Implementation of commands for running calculations remotely on the HPC cluster

For usage of the "remote" set of commands, see file [REMOTE-HOW-TO.md](./REMOTE-HOW-TO.md).

The "remote" commands are implemented as follows:
* **`hpc`** is an ssh alias defined in `~/.ssh/config`. It is created
   during the remote access setup performed by
   `~/QE-2021/post-install/remote-access-setup.sh` script and points
   to one of the three HPC clusters used in the QE-2021 school:
   `hpc-login1.arnes.si`, `argo.ictp.it`, or
   `frontend1.hpc.sissa.it`.

* The **`remote_mpirun`**, **`remote_pwtk`**, **`remote_sbatch`** as
  well as **`rsync_to_hpc`** and **`rsync_from_hpc`** are actually
  shell-functions, defined in `~/QE-2021/post-install/remote.sh`.
  
* The number of processors requested to the Slurm batch queuing system
  is set via `NPROC` environmental variable (default is `NPROC=20`).
  
* The specific options passed to `sbatch` are defined via the
  `sbatch_options` variable. 

The above specifics are loaded from the `~/.bashrc` profile by
sourcing the `~/QE-2021/post-install/hpc.rc` file, which is a sym-link
to one of `~/QE-2021/post-install/arnes.rc`,
`~/QE-2021/post-install/ictp.rc`, or `~/QE-2021/post-install/sissa.rc`
file, depending on which HPC computer was setup for use.
  
If you want to run remotely by changing the default settings, you can do it via, e.g.:

    sbatch_options="--option1=value1 --option2=value2 ..."  NPROC=value  remote_mpirun pw.x -in inputfile.in
  
