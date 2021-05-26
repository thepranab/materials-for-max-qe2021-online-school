# Topics of Day-9 hands-on session

Parallel execution on CPUs and GPUs. Covered topics are:

* compilation of QE for CPU and CPU architectures,
* optimise CPU only runs,
* basic description of GPU acceleration,
* efficiently run on GPU-accelerated systems.

------------------------------------------------------------------------

**Nota bene:** this set of exercises will be performed on Marconi100, the HPC system installed at CINECA.

Please login on the cluster with the credentials you have been provided: 

~~~~~{.bash}
ssh USER@login01-ext.m100.cineca.it  
~~~~~

Due to the particular configuration of this cluster, it is convenient to work in the directory $CINECA_SCRATCH.

Whenever you want to go to the $CINECA_SCRATCH just type 

~~~~~{.bash}
cd $CINECA_SCRATCH  
~~~~~

---

**Exercise 1:** preparing QE (CPU version) 

    cd exercise1.CPU-setup/

**Exercise 2:** optimize CPU execution 

    cd exercise2.CPU-tests/  

**Exercise 3:** (very) basic concepts about GPUs 

    cd exercise3.GPU-intro/ 

**Exercise 4:** preparing QE (GPU version) 

    cd exercise4.GPU-setup/  

**Exercise 5:** running with GPUs 

    cd exercise5.GPU-tests/  
