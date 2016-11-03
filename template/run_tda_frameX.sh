#!/bin/bash

python mdcrd2Guest+Host8A_frameX.py ct.prmtop 04_ct.mdcrd $1

./create_tda_input.sh
nohup g09 < tda.com > frame$1.log &

