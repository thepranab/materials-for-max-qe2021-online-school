# PURPOSE OF THE EXERCISE:
## How to run many calculations with a relatively simple PWTK script
--------------------------------------------------------------------

The subject of this example is the calculation of a 2D potential
energy scan of lateral positions of O @ Al(111). It introduces the
PWTK's concept of input-data stacking (i.e. `input_pushpop { ... }`).

For further explanation, see the comments within the PWTK `scan.pwtk`
script. 

**BEWARE** this example takes quite long, hence run the calculation
remotely, i.e.:

        remote_pwtk scan.pwtk
        
To download the calculated output files, use:
	
	    rsync_from_hpc .
		
But wait some time before doing that; give the remote computer
some time to make the calculation.

The resulting potential-energy-surface can be visualized as:

       gnuplot plot2D.gp
       
       
### "Tabulation" of all pw.x output files

The above PWTK run (i.e., `pwtk scan.pwtk`) produces 25 different pw.x
output files. The structures from all these `pw.x` outputs can be
automatically "tabulated" with PWTK. In particular, PWTK has a
`::pwtk::pwo::tabulateStructs` command, which automatically plots
(i.e., prints to PNG file) structures from the supplied `pw.x` output
files and arranges them into a table as a LaTeX document. An example
of how to achieve this is provided by the `tabulate.pwtk` script.

Read the `tabulate.pwtk` script and try to understand it. To run the
tabulate example, execute:
     
       pwtk tabulate.pwtk
       
This will generate the `tabulate.tex` file. This LaTeX file can be
compiled into PDF file with LaTeX, i.e.:

       pdflatex tabulate.tex
       
**But beware** that current Virtual Machine does not have LaTeX
installed. If you want to install LaTeX, you can execute in the
terminal `sudo apt install texlive`. Instead the corresponding
pre-compiled PDF file is provided in `reference/tabulate.pdf`.
This file can be visualized as:

       atril reference/tabulate.pdf



