
set A [atomselect top "all"]
set B [atomselect top " same residue as within 8 of residue 0"]
set num_all [$A num]
set num_radius [$B num]
# print values
puts "Total atoms: $num_all"
puts "Atoms within 8 Angstroms of Residue 0: $num_radius"
