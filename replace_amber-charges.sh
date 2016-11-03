#!/bin/bash
# Replaces old charges from file.prmtop with new amber charges (amber.charges)
# outputs ct.prmtop (file.prmtop is unchanged)

cp file.prmtop ct.prmtop		# make new prmtop file

python yank.py ct.prmtop "%FLAG CHARGE" "%FLAG ATOMIC_NUMBER"	# grab charges from prmtop file
tail -n +2 output.tmp > output2.tmp	# remove 1st line of file
A=($(cat output2.tmp))			# read array from file
rm output.tmp output2.tmp		# remove temporary file

i=0					# start counter
while read p; do
echo ${A[$i]}				# print new amber charges to screen (for debugging)
sed -i -e "s/${A[$i]}/$p/g" ct.prmtop	# replace old charges with new amber charges in ct.prmtop
i=$(echo $i+1 | bc) 			# bash count by +1
done < qchem/amber.charges		# while loop reads new charges from this file
