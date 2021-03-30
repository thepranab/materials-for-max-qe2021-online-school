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

userinput username
user=$reply
# either:
#userinput hostname 
#host=$reply
# or:
host=percolator.ijs.si


# define where key is stored here (default $HOME/.ssh/)
pathtokey="$HOME/.ssh"

echo "
Generating ssh-key in $pathtokey

(BEWARE: leave the passphrase empty)
"

mkdir -p $pathtokey
nsckey="$pathtokey/id_rsa_nsc"
ssh-keygen -t rsa -b 4096 -m PEM -f $nsckey

cat <<EOF > $HOME/.ssh/config
Host nsc
 HostName $host 
 User $user
 IdentityFile $nsckey
EOF

echo "
BEWARE: you will have to input your password twice
" 

scp $nsckey.pub nsc:~/
ssh -t nsc 'cat $HOME/id_rsa_nsc.pub >> $HOME/.ssh/authorized_keys ; rm $HOME/id_rsa_nsc.pub'


echo "
Please access the NSC cluster by typing: 

ssh nsc
"
