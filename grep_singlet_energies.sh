#!/bin/bash

for d in */ ; do
    # echo "$d"
    grep -m 1 "Singlet-?Sym" $d/*.log >> tmp.dat
done

awk '{ print $6 }' tmp.dat > singlet_energies.dat
rm tmp.dat

