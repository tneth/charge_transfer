#!/bin/bash

for d in {01..20}; do
    for j in 1 {10..1000..10} ; do
       grep -m 1 "Singlet-?Sym" $d/frame$j.log >> tmp.dat
       #echo $d/frame$j.log
    done
    awk '{ print $5 }' tmp.dat > $d.tmp
    rm tmp.dat
done

paste -d' ' *.tmp > s1.dat 

rm *.tmp

