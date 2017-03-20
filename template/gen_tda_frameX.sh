#!/bin/bash
# Creates guest-host Gaussian input file tda.com from: 
# $1, the prmtop file
# $2, the mdcrd file
# $3, frame number (integer)

python mdcrd2Guest+Host8A_frameX.py $1 $2 $3

./create_tda_input.sh

