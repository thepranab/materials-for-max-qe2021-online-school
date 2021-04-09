# PURPOSE OF THE EXERCISE:
## How to calculate EOS (equation-of-state) of a cubic system using the EOS utility of PWTK
--------------------------------------------------------------------

In this example we calculate the EOS (euqation-of-state) of Rh
bulk using the EOS utility of PWTK. To run the example, execute:

     pwtk eos.Rh-bulk.pwtk > eos.Rh-bulk.log &

Read the resulting `eos.Rh-bulk.log` file, it is instructive. In
addition to this log file the EOS final results are also written to
file `eos.Rh-bulk.RESULTS`.

Notice from the results, how much more sensitive is the bulk-modulus
to the sampling of data-points than the lattice-parameter and
equilibrium total energy. Do you know why?


