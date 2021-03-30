#!/bin/bash 

#
# a script to install the required packages for QE-2019 school (user
# requires elevated privilages, i.e., sudo)
#

SUDO=${SUDO:-sudo}
APT=${APT:-apt-get}

dir=`dirname $0`
cd $dir
installdir=$(pwd)

$SUDO $APT update
$SUDO $APT install \
      ssh rsync make gfortran gcc quantum-espresso \
      libblas-dev libfftw3-dev liblapack-dev openmpi-common \
      tcllib tk libtogl2 itk3 iwidgets4 bwidget libgl2ps1.4 \
      vim emacs gnuplot grace octave imagemagick mencoder bc\
      openbabel bkchem gperiodic caja-open-terminal texlive python3-setuptools git graphviz \
      git python2.7-dev python3-dev python-pip virtualenv postgresql postgresql-server-dev-all postgresql-client rabbitmq-server 

xc=xcrysden-1.6.0-bin-shared
pwgui=PWgui-6.4.1
pwtk=pwtk-1.0.0
qemodes=QE-modes-6.4.1

# input link to exercises gitlab here
exercises="https://gitlab.com/QEF/material-for-ljubljana-qe-summer-school.git"

tmp_pkgs=$qemodes.tar.gz
opt_pkgs="$pwgui.tgz $pwtk.tar.gz $xc.tar.gz" 
# DO NOT TOUCH

$SUDO mkdir -p /opt/bin

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
    
    $SUDO ln -s /opt/$xc/xcrysden .
    $SUDO ln -s /opt/$xc/util/ptable .
    $SUDO ln -s /opt/$xc/util/unitconv .
    $SUDO ln -s /opt/$xc/scripting/pwi2xsf.sh pwi2xsf
    $SUDO ln -s /opt/$xc/scripting/pwo2xsf.sh pwo2xsf

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
    echo 'export ESPRESSO_PSEUDO=$HOME/QE-2019/pseudo' >> $HOME/.bashrc
else
    echo "ESPRESSO_PSEUDO already defined; skipping" 
fi

# define remote NSC aliases environmental variables
cp $installdir/remote.sh $HOME/.bash_nsc
if test "x$(grep bash_nsc $HOME/.bashrc)" == "x"; then
    echo '
# source NSC functions and aliases
. $HOME/.bash_nsc
' >> $HOME/.bashrc
else
    echo "~/.bash_nsc already sources from ~/.bashrc"
fi

# fix for firefox add-on so it can open *md files
touch $HOME/.mime.types
if test "x$(cat $HOME/.mime.types | grep markdown)" == "x"; then
    echo 'text/plain      md markdown' > $HOME/.mime.types
else
    echo ".mime.types already created and modified" 
fi

#
# clone exercises git repository 
#
git clone $exercises $HOME/QE-2019

for i in {1..5}; do
    ln -s  $HOME/QE-2019/Day-$i  $HOME/Desktop/Day-$i
done
