#!/bin/bash 

#
# a small script to install the required packages for QE-2021 school (user
# requires elevated privilages, i.e., sudo)
#

SUDO=${SUDO:-sudo}
APT=${APT:-apt-get}
DPKG=${DPKG:-dpkg}
dir=`dirname $0`
cd $dir
installdir=$(pwd)
# update sources list and preferences 

# autologin
$SUDO $APT update
$SUDO $APT install \
      virtualbox-guest-utils virtualbox-guest-x11 \
      ssh sshpass openconnect rsync \
      make gfortran gcc quantum-espresso xcrysden \
      libblas-dev libfftw3-dev liblapack-dev openmpi-common libopenmpi-dev \
      tcllib tk iwidgets4 bwidget \
      vim emacs gnuplot imagemagick mencoder bc\
      gperiodic caja-open-terminal python3-setuptools git \
      python3-dev python3-pip python3-numpy

$SUDO $APT purge libreoffice* gimp* 
$SUDO $APT autoremove
$SUDO $APT clean

pwgui=PWgui-6.7
pwtk=pwtk-1.0.4
qemodes=QE-modes-6.7
analisi=analisi_0.2.1-1
# input link to exercises gitlab here
exercises="https://gitlab.com/QEF/materials-for-max-qe2021-online-school.git"

# debian package for AIMD exercise 

if [ ! -f $analisi ]; then
    echo "analisi package is missing ... "
else 
    $SUDO $DPKG -i $analisi.deb
fi

tmp_pkgs=$qemodes.tar.gz
opt_pkgs="$pwgui.tgz $pwtk.tar.gz" 

# DO NOT TOUCH

$SUDO mkdir -p /opt/bin

$SUDO cp ./ev.x /usr/bin/
$SUDO cp ./sissa-openconnect /opt/bin/
$SUDO cp ./kill-openconnect  /opt/bin/

function tar_open() {
    if test $# -ne 2; then
        echo "Usage: $0 package_list where"
        exit 1
    fi
    pkgs=$1
    where=$2
    for pkg in $pkgs
    do 
        if [ ! -f $pkg ]; then 
            echo "Package $pkg is missing ..."
            exit 1
        else
            $SUDO tar zxvf $pkg -C $where
        fi
    done
}

tar_open "$opt_pkgs"  /opt
tar_open "$tmp_pkgs"  /tmp

# POST-PROCESSING

# QE-emacs-modes
(
    cd /tmp/$qemodes
    ./install.sh
    cp qe-modes.emacs $HOME/.emacs
)
# configure emacs
cat <<EOF >> $HOME/.emacs
(setq inhibit-splash-screen t) 
(add-to-list 'auto-mode-alist '("\\\\.xcrysden\\\\'" . tcl-mode))

;; Enable install of MELPA packages, view witk M-x list-packages
;; required for installation of gnuplot mode
(require 'package) 
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))) 
(package-initialize)

EOF

# configure vim for pwtk ... 
cat <<EOF > $HOME/.vimrc
syntax on
filetype on 
au BufNewFile,BufRead *.pwtk set filetype=tcl

EOF

# make symlinks to /opt/bin/

(
    cd /opt/bin/
    
    $SUDO ln -s /opt/$pwgui/pwgui .
    $SUDO ln -s /opt/$pwtk/pwtk   .
)

# pwtk configuration
mkdir -p $HOME/.pwtk
cp $installdir/pwtk.tcl $HOME/.pwtk/

# xcrysden customization
mkdir -p $HOME/.xcrysden
cp $installdir/custom-definitions $HOME/.xcrysden

# append the required PATH to .bashrc

if test "x$(echo $PATH | grep /opt/bin)" == "x"; then
    echo 'export PATH=/opt/bin/:$PATH' >> $HOME/.bashrc
else
    echo "PATH already changed; skipping" 
fi

# define ESPRESSO environmental variables 
if test "x$(cat $HOME/.bashrc | grep ESPRESSO_TMPDIR)" == "x"; then
    echo 'export ESPRESSO_TMPDIR=/tmp' >> $HOME/.bashrc
else
    echo "ESPRESSO_TMPDIR already defined; skipping" 
fi

if test "x$(cat $HOME/.bashrc | grep ESPRESSO_PSEUDO)" == "x"; then
    echo 'export ESPRESSO_PSEUDO=$HOME/QE-2021/pseudo' >> $HOME/.bashrc
else
    echo "ESPRESSO_PSEUDO already defined; skipping" 
fi

# define remote HPC aliases environmental variables
if test "x$(grep post-install/hpc.rc $HOME/.bashrc)" == "x"; then
    echo '
# source HPC functions and aliases
if test -f $HOME/QE-2021/post-install/hpc.rc; then
   # N.B. hpc.rc is a link to one of arnes.rc, ictp.rc, or sissa.rc
   . $HOME/QE-2021/post-install/hpc.rc
fi
' >> $HOME/.bashrc
else
    echo "post-install/hpc.rc already sources from ~/.bashrc"
fi

# fix for firefox add-on so it can open *md files
touch $HOME/.mime.types
if test "x$(cat $HOME/.mime.types | grep markdown)" == "x"; then
    echo 'text/plain      md markdown' > $HOME/.mime.types
else
    echo ".mime.types already created and modified" 
fi
#
if test "x$(cat $HOME/.config/mimeapps.list | grep markdown)" == "x"; then
    cat <<EOF > $HOME/.config/mimeapps.list
[Default Applications]
text/markdown=firefox-esr.desktop
text/plain=emacs.desktop

[Added Associations]
text/markdown=firefox-esr.desktop;
text/plain=emacs.desktop;
EOF
else
    echo "default apps already set in mimeapps.list, skipping ... " 
fi

# install ovito
(
    cd /tmp
    wget https://www.ovito.org/download/master/ovito-basic-3.4.4-x86_64.tar.xz
    tar Jxvf ovito-basic-3.4.4-x86_64.tar.xz -C /opt
    rm -f ovito-basic-3.4.4-x86_64.tar.xz
    $SUDO ln -s /opt/ovito-basic-3.4.4-x86_64/bin/ovito /opt/bin/ovito
)

#
# clone exercises git repository 
#
git clone $exercises $HOME/QE-2021

# make Day-X links
for i in {1..10}; do
    ln -s  $HOME/QE-2021/Day-$i  $HOME/Desktop/Day-$i
done
