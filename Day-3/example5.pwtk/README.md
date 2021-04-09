# PURPOSE OF THE EXERCISE:
## To explore various capabilities of PWTK and to learn a bit more about it
---------------------------------------------------------------------------

This exercise consists from three examples, in particular:

* `ex1.eos/` -- how to use EOS utility of PWTK to calculate EOS of Rh bulk

* `ex2.O@Al111/` -- how to run many calculations with a relatively
                    simple PWTK script; it calculates a 2D potential
                    energy surface of lateral positions of O @ Al(111).
                    It is also shown how one can automatically
                    tabulate calculated structures with PWTK.
                    
* `ex3.CO@Rh100/` -- a more elaborate PWTK example that shows how to
                     glue together various calculations. In particular,
                     it analyzes the bonding of CO molecule on Rh(100).


**REMARK:** all three examples imports the `./common.pwtk` file, which
specifies the most common set of input data that is used by all
examples, i.e., list of pseudo-potentials, energy cutoffs,
smearing, ...


**BEWARE:** the cutoffs and convergence thresholds and other parameters are
very lousy as to speed-up calculations.
