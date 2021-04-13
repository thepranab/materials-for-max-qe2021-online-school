# Day-3 :
---------

### Topics of Day-3 hands-on session

- Structure optimizations
- NEB: transition states of elementary chemical reactions
- Automating the workflow with PWTK

---

**Exercise 1:** structural optimization (`calculation = 'relax'`);
	            atomic positions only

    cd example1.relax/


**Exercise 2:** structural optimization (`calculation = 'vc-relax'`);
                atomic positions and unitcell

    cd example2.vc-relax/


**Exercise 3:** transition states of elementary chemical reactions

    cd example3.neb/


**Exercise 4:** automating the workflow with PWTK

    cd example4.pwtk/

### How to run calculations remotely on the HPC cluster

Some examples take too long on a laptop computer, hence they will be
run remotely on the HPC cluster. Several utility commands have been
implemented specially for the QE-2021 school to aid at submitting jobs
to HPC cluster.

For specific info on remote running, see file [REMOTE-HOW-TO.md](./REMOTE-HOW-TO.md)
