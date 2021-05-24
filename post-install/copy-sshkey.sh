#!/bin/bash

# PURPOSE:
# if by some reason remote-access-setup.sh, this is a simple script
# that tries to copy the ssh-key to hpc

# BEWARE: hcpkey should be the same as in remote-access-setup.sh
hpckey="$HOME/.ssh/id_rsa_hpc"

userinput() {
    echo "
Please input your $1:"
    read reply
    
    echo -n "
The $1 is \"$reply\". Is this correct [y|n] : "
    read answer

    if test "$answer" != "y"; then
	#echo "The reply $reply was wrong, exiting ..."
	#exit 1
        echo "Retrying ..."
        userinput $1
    fi
}
passwd() {
    userinput "HPC password"
    passwd=$reply
    echo $passwd > ~/.ssh/passwd
    chmod 600 ~/.ssh/passwd
}

# check if ~/.ssh/passwd exists
if test ! -f ~/.ssh/passwd; then
    # let's create it
    passwd
fi

sshpass -f ~/.ssh/passwd scp $hpckey.pub hpc:
sleep 1
sshpass -f ~/.ssh/passwd ssh -t hpc 'cat $HOME/id_rsa_hpc.pub >> $HOME/.ssh/authorized_keys ; rm $HOME/id_rsa_hpc.pub'
