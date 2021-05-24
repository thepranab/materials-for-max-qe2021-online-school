#!/bin/bash

PREF=h2o

cp2lammpstrj.py -n 24 --minimal --not-ordered -t 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 -o "$PREF" "$PREF"
for T in pos vel cel evp
do
if [ "$T" == "evp" ]
then
    head -n 1 "$PREF.$T" > "$PREF.last.$T"
else
    echo -n '' > $PREF.last.$T
fi
tail -n +$(egrep -n '^ +6110 +' "$PREF.$T" | tail -n 1 | sed 's/^\([0-9]*\).*/\1/g') $PREF.$T >> $PREF.last.$T
done
cp2analisi.py "$PREF.last" "$PREF" 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1
analisi -i "${PREF}.bin" -q -B 2 > msd 2> /dev/null
analisi -i "${PREF}.bin" -F 0.0 10.0 -g 100 -S 1 > gofr 2> /dev/null
