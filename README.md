# charge_transfer

## Usage

With selected host and guest molecules (host.mol2 and guest.mol2 files), run TLeap on leap.src (this needs gaff.dat and frcmod.mecn) to obtain the Amber parameter file (file.prmtop) and starting geometry (file.rst7). 

	tleap -f leap.src

Examine the starting geometry, it is desirable to have 2 layers of guest molecules surrouding the host molecule, no more no less. If there is, continue to the next step; if not, edit the value of the solvatebox command in the 'leap.src' file and rerun tleap. 

Create working directory by copying the template/ directory, e.g., 

	cp -r template/ 01/
	cd 01/

Run 'sample' script to minimise, followed by heating to 1000 K for a random time-interval in the range [10, 30] ps, and cool back to 300 K over a 200 ps interval. 

	./sample 

Examine the final geometry 03_Prod.rst7, and check how many host atoms are within an eight Angstrom radius of the guest molecule with 'nat_within_8A.sh' (requires VMD script, select.tcl),

	./nat_within_8A.sh

The guest molecule must be fully surrounded by host molecules, i.e. not near the edge of the box. The reason for this is that later quantum chemistry calculations will not take into account the periodic boundary conditions. Run sample script again if the guest is too near the edge of the box. 

To simulate the charge transfer state in the guest molecule, a new parameter file is created (ct.prmtop) using new charges obtained from a 'Constrained' DFT calculation (files are in qchem folder). Go into the main directory and run 'replace_amber-charges.sh' to create ct.prmtop (this has already been done so you can skip this step),  

	./replace_amber-charges.sh

Then back in the working folder, run the 'run_ct' script to propagate the molecular dynamics for 100 ns (5 days with 32 threads...) using the new ct.prmtop file. The starting geometry is defined by 03_Prod.rst7.

	./run_ct

The progress of the run can be monitored with tail on the mdinfo file,

	tail -f 04_ct.mdinfo

Once completed, quantum chemical (TDDFT) snapshots should be taken every N time-intervals to properly examine the charge transfer states as a function of time.

## Dependencies

python 2.7, and MDAnalysis python libraries

Amber14 Molecular Dynamics package

QChem Quantum Chemistry package, version 4.3

Visual Molecular Dynamics (VMD)

## To Do

Describe how to perform the TDDFT calculations...
