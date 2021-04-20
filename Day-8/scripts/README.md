# useful scripts needed to elaborate/visualize the trajectory

## VMD visualization

`cp2lammpstrj.py` is used to convert the cp format to the lammps format, that can be visualized by VMD:

```
./cp2lammpstrj.py input_trajectory_prefix -n 24 --minimal --not-ordered -t 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 -o outfile
```
the long sequence of 0 and 1 are the type of the atoms, in the same order of the trajectory. `-n` indicates the number of atoms.
then `vmd outfile.lammpstrj` will open the file
