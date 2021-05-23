#!/bin/bash

cd $HOME

tmpdirs=$(find . | egrep tmp$)

for dir in $tmpdirs
do
    (
        cd $dir
        echo "deleting large scratch files in $dir ..."
        files1=$(find . | egrep '(wfc|psi.|lanczos.|dwf|mwf|dvpsi.)[0-9]+')
        files2=$(find . | egrep save | egrep dat$)
        files="$files1 $files2"
        if test "x$files" != x; then
            rm -f $files
        fi
    )
done
