#!/bin/bash

# This script contains some commands to setup fp nodes @ IJS

export http_proxy=http://www-proxy.ijs.si:8080
export https_proxy=http://www-proxy.ijs.si:8080

unalias sbatch

echo "====> Your scratch dir is: $ESPRESSO_TMPDIR"
