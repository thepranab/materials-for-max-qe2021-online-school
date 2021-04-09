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
	
	    rsync_from_nsc .
		
But wait some time before doing that; give the remote computer
some time to make the calculation.

The resulting potential-energy-surface can be visualized as:

       gnuplot plot2D.gp
       
       
### "Tabulation" of all pw.x output files

The above PWTK run (i.e., `pwtk scan.pwtk`) produced 25 different pw.x
output files. One can automatically "tabulate" the structures from all
those `pw.x` output files with PWTK. In particular, PWTK has a
`::pwtk::pwo::tabulateStructs` command, which automatically plots
(that is, prints to PNG file) structures from the supplied pw.x output
files and arranges them into a table as a LaTeX document. An example
of how to achieve this is provided by the `tabulate.pwtk` script. 

Read the `tabulate.pwtk` script and try to understand it. To run the
tabulate example, execute:
     
       pwtk tabulate.pwtk
       
This will generate the `tabulate.tex` LaTeX file. To compile it into a
PDF file, execute:

       pdflatex tabulate.tex
       
The produced PDF file can be visualized as:

       atril tabulate.pdf



