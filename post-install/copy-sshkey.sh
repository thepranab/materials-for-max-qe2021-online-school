#!/bin/bash

# PURPOSE:
# if by some reason remote-access-setup.sh, this is a simple script
# that tries to copy the ssh-key to hpc

# BEWARE: hcpkey should be the same as in remote-access-setup.sh
hpckey="$HOME/.ssh/id_rsa_hpc"

sshpass -f ~/.ssh/passwd scp $hpckey.pub hpc:
echo "
... wait for 5 seconds ...
"
sleep 5
sshpass -f ~/.ssh/passwd ssh -t hpc 'cat $HOME/id_rsa_hpc.pub >> $HOME/.ssh/authorized_keys ; rm $HOME/id_rsa_hpc.pub'
