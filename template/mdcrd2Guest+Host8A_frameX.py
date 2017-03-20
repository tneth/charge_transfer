# from MDAnalysis import *
import MDAnalysis
import sys

topology_file   = str(sys.argv[1])
trajectory_file = str(sys.argv[2])
universe = MDAnalysis.Universe(topology_file, trajectory_file)
frame_number = int(sys.argv[3])

c = 0  # begin counter

n_atoms  = universe.trajectory.n_atoms
print('Number of atoms: ' + str(n_atoms))
n_frames = universe.trajectory.n_frames
print('Number of frames: ' + str(n_frames))

fname = open('host.charges','w')

# Write XYZ files from random frame 
for ts in universe.trajectory:
   c += 1  # count
   if c == frame_number:  
      # write host.xyz file using residues 8.0 Angstroms away from resnum 1 (the guest)
      universe.selectAtoms("byres (around 8.0 resnum 1)").write("host.xyz")
      charges = universe.selectAtoms("byres (around 8.0 resnum 1)").charges
      for item in charges:
         fname.write("%s\n" % item) 
      universe.selectAtoms("byres (resnum 1)").write("guest.xyz")

fname.close()
