# charge_transfer

## Important files

To start off the following files can be used to generate the Amber parameter file and starting MD geometry "restart file":

-host.mol2	(host mol2 file, contains geometry and charges)
-guest.mol2	(guest mol2 file, containes geometry and charges)
-leap.src	(configuration file to edit the host and guest, size of box and other parameters)
-gaff.dat	(General Amber Force Field file)

The Amber parameter file and restart file:

-file.prmtop
-file.rst7

To create a new parameter file for the charge transfer state:

-replace_amber-charges.sh

## Usage

### Ground state

With selected host and guest molecules (host.mol2 and guest.mol2 files), run TLeap on leap.src (requires gaff.dat and frcmod.mecn) to obtain the Amber parameter file (file.prmtop) and starting geometry (file.rst7). NB! Make sure the guest.mol2 charges match the ground state PBE0 charges in qchem/gs.out.  

	tleap -f leap.src

Save the ground state parameter file to a new file to keep it safe, e.g.

	cp file.prmtop gs.prmtop

Examine the starting geometry, it is desirable to have at least 2 layers of guest molecules surrouding the host molecule. If there is, continue to the next step; if not, edit the value of the solvatebox command in the 'leap.src' file and rerun tleap. 

Create working directory by copying the template/ directory, e.g., 

	cp -r template/ 01/
	cd 01/

Run 'sample' script to minimise, followed by heating to 1000 K for a random time-interval in the range [10, 30] ps, and cool back to 300 K over a 200 ps interval. 

	./sample 

Examine the final geometry 03_Prod.rst7, and check how many host atoms are within an eight Angstrom radius of the guest molecule with 'nat_within_8A.sh' (requires VMD script, select.tcl),

	./nat_within_8A.sh

The guest molecule must be fully surrounded by host molecules, i.e. not near the edge of the box. The reason for this is that later quantum chemistry calculations will not take into account the periodic boundary conditions. Run sample script again if the guest is too near the edge of the box. 

### Charge transfer state

To simulate the charge transfer state in the guest molecule, a new parameter file is created (ct.prmtop) using new charges obtained from a 'Constrained' DFT calculation (qchem/ct.out). Go into the main directory and run 'replace_amber-charges.sh' to create ct.prmtop (this has already been done so you can skip this step),  

	./replace_amber-charges.sh

Compare the ground state and the charge transfer state parameter files to be certain the new charges are present,

	diff gs.prmtop ct.prmtop 

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
