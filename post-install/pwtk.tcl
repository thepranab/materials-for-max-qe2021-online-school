# ------------------------------------------------------------------------
# 
# pwtk == PWscf's ToolKit
#
# This is a main configuration file for Pwtk. It contains some custom
# definitions, such as the PWscf executables and alike.
#
# ------------------------------------------------------------------------


#
# HOW TO RUN QUANTUM ESPRESSO EXECUTABLES ...
# 
# They are run as: prefix bin_dir/program postfix

prefix  ""
postfix ""

# default directories ...

outdir_prefix /tmp
wfcdir_prefix /tmp

# directory with pseudo-potentials

pseudo_dir $env(HOME)/QE-2019/pseudo

#
# some xcrysden and XSF relates stuff
#

set PWI2XSF [auto_execok pwi2xsf]
set PWO2XSF [auto_execok pwo2xsf]

