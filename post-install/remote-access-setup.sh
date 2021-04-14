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

# let's make the ssh-key that will be used to connect to HCP
mkdir -p $pathtokey
hcpkey="$pathtokey/id_rsa_hcp"
ssh-keygen -t rsa -f $hcpkey

#
# 1. let's make a ssh alias that will link the "hcp" with the actual HCP computer
#
# 2. this way all the users will only use "hcp" alias, irrespectively of the actual supercomputer used.
# 
cat <<EOF >> $HOME/.ssh/config
Host hcp
 HostName $host 
 User $user
 IdentityFile $hcpkey
EOF

echo "
BEWARE: you will have to input your password twice
" 

scp $hcpkey.pub hcp:~/
ssh -t hcp 'cat $HOME/id_rsa_hcp.pub >> $HOME/.ssh/authorized_keys ; rm $HOME/id_rsa_hcp.pub'


echo "
Please access the HCP cluster by typing: 

ssh hcp
"
