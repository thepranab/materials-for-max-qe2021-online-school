#!/bin/bash

#
# make ssh configure file for user ... 
#
userinput() {
    echo "
Please input your $1:"
    read reply 
    echo -n "The $1 is \"$reply\". Is this correct [y|n] : "
    read answer
    if test "$answer" != "y"; then
	echo "The reply $reply was wrong, exiting ..."
	exit 1 
    fi
} 

# query for username & hostname/login-node
userinput username
user=$reply
userinput hostname 
host=$reply


# define where key is stored here (default $HOME/.ssh/)
pathtokey="$HOME/.ssh"

echo "
Generating ssh-key in $pathtokey

(BEWARE: leave the passphrase empty)
"

# let's make the ssh-key that will be used to connect to HPC
mkdir -p $pathtokey
hpckey="$pathtokey/id_rsa_hpc"
ssh-keygen -t rsa -f $hpckey

#
# 1. let's make a ssh alias that will link the "hpc" with the actual HPC computer
#
# 2. this way all the users will only use "hpc" alias, irrespectively of the actual supercomputer used.
# 
cat <<EOF >> $HOME/.ssh/config
Host hpc
 HostName $host 
 User $user
 IdentityFile $hpckey
EOF

echo "
BEWARE: you will have to input your password twice
" 

scp $hpckey.pub hpc:~/
ssh -t hpc 'cat $HOME/id_rsa_hpc.pub >> $HOME/.ssh/authorized_keys ; rm $HOME/id_rsa_hpc.pub'


echo "
Please access the HPC cluster by typing: 

ssh hpc
"
