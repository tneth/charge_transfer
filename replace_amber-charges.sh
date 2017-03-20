#!/bin/bash
# Replaces old charges from file.prmtop with new amber charges (amber.charges)
# outputs ct.prmtop (file.prmtop is unchanged)

a=$(grep -n "%FLAG CHARGE" gs.prmtop) 
a=${a%:*}					# line number containing string1
b=$(grep -n "%FLAG ATOMIC_NUMBER" gs.prmtop)
b=${b%:*}					# line number containing string2

# store all original amber charges in array,
A=($(head -n $b gs.prmtop | tail -n +$a | head -n -1 | tail -n +3))

cp gs.prmtop ct.prmtop			# make new prmtop file

i=0					# start counter
while read p; do
echo "old: ${A[$i]} new: $p"		# print old and new amber charges to screen (for debugging)
sed -i -e "s/${A[$i]}/$p/g" ct.prmtop	# replace old charges with new amber charges in ct.prmtop
i=$(echo $i+1 | bc) 			# bash count by +1
done < qchem/amber.charges		# while loop reads new charges from this file
