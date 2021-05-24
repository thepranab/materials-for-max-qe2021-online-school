# PURPOSE OF THE EXERCISE:
## Explore various smearing schemes, i.e., how-to-smear (variable "smearing") and how-much-to-smear (variable "degauss")
--------------------------------------------------------------

**Steps to perform:**

1. Read the `degauss.pwtk` script and try to understand it

2. To run the example, execute:

       pwtk degauss.pwtk

3. *OPTIONAL:* Edit the `degauss.pwtk` script and add a few more extra
   values of `degauss` (say, 0.15 and 0.2). In order not to rerun the
   calculations that were already done, turn the `restart` mode
   on. These are the steps to perform:
     
      1. edit `degauss.pwtk` script as follows:
         1. uncomment `#restart true` line
         2. add 0.15 and 0.2 to line `foreach degauss {0.003 0.01 0.03 0.1} {`
      2. run `degauss.pwtk` script again: `pwtk degauss.pwtk`
