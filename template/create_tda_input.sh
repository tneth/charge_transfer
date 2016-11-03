#!/bin/bash

cat template.com > tda.com
tail -n +3 guest.xyz >> tda.com
tail -n +3 host.xyz > 1.tmp
paste 1.tmp host.charges > 2.tmp
awk '{print $2 " " $3 " " $4 " " $5}' 2.tmp >> tda.com
rm 1.tmp 2.tmp

