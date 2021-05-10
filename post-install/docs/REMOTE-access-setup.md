# Setup of remote access to HPC clusters

For more CPU intensive hands-on from Day-3 to Day-8, each QE-2021
participant has access to one particular HPC facility (either Arnes,
ICTP, or SISSA cluster), whereas on Day-9 participants will use HPC
facility in CINECA and on Day-10 hands-on will be run on AiiDAlab
kubernetes cluster.

To setup the remote access (for hands-on from Day-3 to Day-8), execute
the following script

     ~/QE-2021/post-install/remote-access-setup.sh
     
and carefully read the instructions. You need to enter your login
details that you received (i.e., *username*, *hostname*, and
*password*). 

If for some reason the `~/QE-2021/post-install/remote-access-setup.sh`
script fails to setup remote access, read below the manual instructions
for how to setup remote access.

## Manual instructions to setup remote access

If for some reason the `~/QE-2021/post-install/remote-access-setup.sh`
script fails to setup remote access, here is the description of what
is needed to setup the remote access. 

1. Generate ssk-key with `ssh-keygen`. Check if the
   `~/.ssh/id_rsa_hpc` file already exists; if so it was
   created by `remote-access-setup.sh` script. Otherwise:

        ssh-keygen -t rsa -f ~/.ssh/id_rsa_hpc
   
   
   
2. Create ssh alias named `hpc`. To this end create the file
   `~/.ssh/config` with the following content:
   
        Host hpc
          HostName <hostname>
          User     <username>
          IdentityFile /home/user/.ssh/id_rsa
          
   where `<hostname>` stands for the actual hostname (either
   `hpc-login1.arnes.si`, `argo.ictp.it`, or `frontend1.hpc.sissa.it`)
   and `<username>` for the actual username (use the login accounts that
   you received).

3. Copy the generated public ssh-key `/home/user/.ssh/id_rsa.pub` to the
   HPC cluster. This step is specific and depends on which HPC cluster
   is used, in particular:
   
   - **Arnes users:** those of you who are allocated to Arnes cluster
   (`hpc-login1.arnes.si`) should copy the generated public ssh-key
   `/home/user/.ssh/id_rsa.pub` to https://fido.sling.si online form
   (do not forget to press the "Save" button on the online-form.
   
   - **ICTP users:** those of you who are allocated to ICTP cluster
   (`argo.ictp.it`) should copy the generated public ssh-key
   `/home/user/.ssh/id_rsa.pub` to `argo.ictp.it` computer and append
   it there to the `~/.ssh/authorized_keys` file.
   
   - **SISSA users:** those of you who are allocated to SISSA cluster
   (`frontend1.hpc.sissa.it`) need to activate VPN to connect to the
   cluster and to this end, two scripts are provided: (1)
   `sissa-openconnect` activates the VPN and (2) `kill-openconnect`
   closes the VPN. Once VPN is activated copy the generated public ssh-key
   `/home/user/.ssh/id_rsa.pub` to `frontend1.hpc.sissa.it` computer and append
   it there to the `~/.ssh/authorized_keys` file.
