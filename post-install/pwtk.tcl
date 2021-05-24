# ------------------------------------------------------------------------
# 
# pwtk == PWscf's ToolKit
#
# This is a main configuration file for Pwtk. It contains some custom
# definitions, e.g., directories and how to run QE executables ...
#
# ------------------------------------------------------------------------

# get the number of available processors
set np [exec nproc]
while { [catch {exec mpirun -n $np echo yes}] } {
    set np [expr { $np > 2 ? $np / 2 : 1 }]
}

#
# HOW TO RUN QUANTUM ESPRESSO EXECUTABLES ...
# 
# They are run as: prefix bin_dir/program postfix

if { $np > 1 } {
    prefix mpirun -n $np
}
#postfix ""

# default directories ...

outdir /tmp
outdir_prefix /tmp
#wfcdir /tmp

# directory with pseudo-potentials

pseudo_dir $env(HOME)/QE-2021/pseudo

#
# some xcrysden and XSF relates stuff
#

set PWI2XSF [auto_execok pwi2xsf]
set PWO2XSF [auto_execok pwo2xsf]

