# Advanced QE-GPU

A few other tricks can be used to further reduce the time to solution.

## GPU oversubscription

While the rule of thumb for the GPU version of QE is 1 MPI process per GPU, 
depending on the input you may benefit from *oversubscribing* 
the GPU with multiple MPI processes per GPU card.

Try to run the previous CuO input with 2 MPI processes per GPU and 
4 MPI processes per GPU. Can you observe improvements?

## CUDA-Aware MPI

The general scheme for MPI communication in QE is the following:

![mpi with gpu](gpu-mpi.jpg)

(taken from [CUDA Application Design and Development](https://doi.org/10.1016/B978-0-12-388426-8.00010-0))

The data are first moved to the host memory, than sent through the NIC by
an MPI call, received on the other end and finally copied to the GPU memory
of the destination node.

On some systems this has a sizable impact on the performance of data communication and, whenever possible, 
a better communication strategy that can exploit direct GPU to GPU channels (like NVlink) 
can be setup by recent versions of OpenMPI.

The following command can be used to check whether the OpenMPI version installed on your system 
support sending and receiving data residing on the GPU memory:

    module load <WHAT?>
    ompi_info --parsable -l 9 --all | grep mpi_built_with_cuda_support:value

if the answer is:

    mca:mpi:base:param:mpi_built_with_cuda_support:value:true

you can try to enable this feature in QE-GPU. 
At the time of writing this is still an *experimental feature* that can be activated
by adding the flag

    -D__GPU_MPI

after the line containing `-D__MPI`.

*Recompile the code* (`make clean && make -j pw`) and run the Si255Ge input of the previous exercise.
Do you find any speedup? Where and why?
