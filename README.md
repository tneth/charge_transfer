# charge_transfer

## Usage

With selected host and guest molecules (host.mol2 and guest.mol2 files), run TLeap on leap.src (this needs gaff.dat and frcmod.mecn) to obtain the Amber parameter file (file.prmtop) and starting geometry (file.inpcrd). 

Create working directory by copying the template/ directory, e.g. cp -r template/ 01/. 

Run sample script to minimise, followed by heating to 1000K for a random time-interval in the range [10, 30] ps, and cool back to 300K over a 100 ps interval. 

Examine the final geometry 03_Prod.rst7, and check how many host atoms are within an eight Angstrom radius of the guest molecule with nat_within_8A.sh (needs select.tcl). Prefer the guest molecule to be fully surrounded by host molecules, i.e. not near the edge of the box. The reason for this is that later quantum chemistry calculations will not take into account periodic boundary conditions. Run sample script again if guest is away from the centre of the box. 

To simulate the charge transfer state in the guest molecule, a new parameter file is created (ct.prmtop) using new charges obtained from a 'Constrained' DFT calculation. Run replace_amber-charges.sh to create ct.prmtop. 

Then run the run_ct script to propagate the molecular dynamics for 100 ns using the new ct.prmtop file. The starting geometry is defined by 03_Prod.rst7.

Once completed, quantum chemical snapshots are taken every N time-intervals to properly examine the charge transfer states as a function of time. 
