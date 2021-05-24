# Tips and tricks
------------------------------------------------------------------------

## Basic Linux commands - how to navigate in the terminal

For basic Linux commands, see [Linux Command Line Cheat Sheet](https://cheatography.com/davechild/cheat-sheets/linux-command-line/).

**Some useful programs:**
* PDF viewer:  `atril`
* text editor: `emacs`
* simple text editor: `pluma`
* file browser: `caja`
* text-based calculator in the terminal: `bc -l` (type Ctrl-D
  to exit)

------------------------------------------------------------------------

## Basic git usage

To get the most recent version of the excercises from the QE-2021
school gitlab repository, execute in the terminal from any exercise
folder or subfolder:

    git pull

Note that from Day-2 on, the `git pull` may fail due to changed files
from the preceding day(s). In this case:

    git stash 
    git pull

To recover your local changes to files execute:

    git stash apply

------------------------------------------------------------------------

For addition documentation on the git usage, see [Git Cheat
Sheet](https://cheatography.com/samcollett/cheat-sheets/git/).

------------------------------------------------------------------------

## Cleaning Quantum ESPRESSO temporary files

Large Quantum ESPRESSO temporary files (i.e. those written to
*outdir* directories) can be deleted with aid of the following script:

      ~/QE-2021/post-install/clean-outdir.sh
    
Beware that automatic deletion of files is dangerous, hence use this
script **at your own risk**. This script can be utilized both in the
virtual-machine as well as in the HPC cluster (but prior to running
this script, you should execute `git stash; git pull; git stash apply`
on the HPC cluster).
