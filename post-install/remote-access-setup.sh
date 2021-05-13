#!/bin/bash

#
# make ssh configure file for user ... 
#
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


ssh_alias() {    
    # 1. let's make a ssh alias that will link the "hpc" with the actual HPC computer
    #
    # 2. this way all the users will only use "hpc" alias,
    #    irrespectively of the actual supercomputer used.
    
    cat >> $HOME/.ssh/config <<EOF 
Host hpc
 HostName $host 
 User $user
 IdentityFile $hpckey
EOF
}
 
arnes=$(echo $host | grep arnes.si)
ictp=$(echo $host | grep ictp.it)
sissa=$(echo $host | grep sissa.it)

hpc_link() {
    # make a link to hpc.rc
    ln -sf $HOME/QE-2021/post-install/$1 $HOME/QE-2021/post-install/hpc.rc
}
username() {
    echo $user > ~/.ssh/user
    chmod 600 ~/.ssh/user
}
passwd() {
    userinput password
    passwd=$reply
    echo $passwd > ~/.ssh/passwd
    chmod 600 ~/.ssh/passwd
}
copy_sshkey() {
    sshpass -f ~/.ssh/passwd scp $hpckey.pub hpc:
    sshpass -f ~/.ssh/passwd ssh -t hpc 'cat $HOME/id_rsa_hpc.pub >> $HOME/.ssh/authorized_keys ; rm $HOME/id_rsa_hpc.pub'

    echo "
Please access the HPC cluster by typing: 

ssh hpc
"
}


if test "x$ictp" != "x"; then
    #
    # ICTP
    #
    ssh_alias
    hpc_link ictp.rc
    passwd
    copy_sshkey

elif test "x$sissa" != "x"; then
    #
    # SISSA
    #
    ssh_alias
    hpc_link sissa.rc 
    username
    passwd    
    ./sissa-openconnect
    sleep 2; echo "... please wait a bit ..."; sleep 2
    copy_sshkey
    
elif test "x$arnes" != "x"; then
    #
    # ARNES
    #
    ssh_alias
    hpc_link arnes.rc
    
    #
    # peculiarity for the ***.arnes.si HPC cluster
    #
    clear
    echo "
*** IMPORTANT ***

To complete the remote-access setup for $host, 
the just generated key:

   $hpckey.pub

needs to be input into the online-form that will open in the firefox
automatically.

Press <Enter> to continue ..."
    read ans

    echo "
The $hpckey.pub to copy-paste is:

`cat $hpckey.pub`

To login to the on-line form use the \"username\" and \"password\"
that you received. Do not forget to click the \"Save\" button on the
online-form.

BEWARE: it takes a while before the ssh-key propagates to the HPC cluster!


Press <enter> to continue with the firefox"
    read ans

    firefox https://fido.sling.si

    echo "
After the ssh-key was successfully entered to https://fido.sling.si, wait
for a while and then try to access the HPC cluster by typing: 

ssh hpc
"
else
    #
    # unsupported HPC
    #
    echo "
WARNING: It seems that you mistyped the name of the HPC computer.

Please retry and execute $0 again.
"
    exit 1
fi

echo "
For this setup to take the full effect, it is recommended to close
this terminal window and open a new one.
"
