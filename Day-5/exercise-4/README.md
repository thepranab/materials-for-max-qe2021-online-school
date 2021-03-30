# Collect GPU details

In this exercise we find out the relevant details of the GPU(s)
installed on the cluster used in this hands-on.

First remember to go back to the computer node and source `node_preparation.sh`:

    # From percolator.ijs.si
    ssh nsc-fp001
    cd ~ && source QE-2019/Day-5/prepare_node.sh && cd -


There are two tools that are quite effective in gathering information on the GPUs 
installed on the system: `deviceQuery` and `nvidia-smi`.

Check that both are available. If `deviceQuery` is missing,
you will have to compile it from source. It can be found here:

    wget https://github.com/NVIDIA/cuda-samples/archive/master.zip
    unzip master.zip
    cd cuda-samples-master

For detailed compilation instructions check the README file.
On our system, the code can be compiled with:

    cd Samples/deviceQuery
    CUDA_PATH=/usr SMS="30 35 37 50 52 60 61 70" make

As a rule, in order to collect information, you first need to access
the compute node you want to use
with an interactive job. You can do this with the following command:

    # Run me!
    srun --time=00:10:00 -N 1 --ntasks-per-node=1 --gres=gpu:1 --reservation=qe2019 --pty /bin/bash
    
Once the interactive job starts, run and check the output of:

    # Run me!
    ./deviceQuery

You should see something like this:

     1	Device 0: "Tesla K40m"
     2	  CUDA Driver Version / Runtime Version          10.2 / 9.2
     3	  CUDA Capability Major/Minor version number:    3.5
     4	  Total amount of global memory:                 11441 MBytes (11996954624 bytes)
     5	  (15) Multiprocessors, (192) CUDA Cores/MP:     2880 CUDA Cores
     6	  GPU Max Clock rate:                            745 MHz (0.75 GHz)
     7	  Memory Clock rate:                             3004 Mhz
     8	  Memory Bus Width:                              384-bit
     9	  L2 Cache Size:                                 1572864 bytes
    10	  Maximum Texture Dimension Size (x,y,z)         1D=(65536), 2D=(65536, 65536), 3D=(4096, 4096, 4096)
    11	  Maximum Layered 1D Texture Size, (num) layers  1D=(16384), 2048 layers
    12	  Maximum Layered 2D Texture Size, (num) layers  2D=(16384, 16384), 2048 layers
    13	  Total amount of constant memory:               65536 bytes
    14	  Total amount of shared memory per block:       49152 bytes
    15	  Total number of registers available per block: 65536
    16	  Warp size:                                     32
    17	  Maximum number of threads per multiprocessor:  2048
    18	  Maximum number of threads per block:           1024
    19	  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
    20	  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
    21	  Maximum memory pitch:                          2147483647 bytes
    22	  Texture alignment:                             512 bytes
    23	  Concurrent copy and kernel execution:          Yes with 2 copy engine(s)
    24	  Run time limit on kernels:                     No
    25	  Integrated GPU sharing Host Memory:            No
    26	  Support host page-locked memory mapping:       Yes
    27	  Alignment requirement for Surfaces:            Yes
    28	  Device has ECC support:                        Enabled
    29	  Device supports Unified Addressing (UVA):      Yes
    30	  Device supports Compute Preemption:            No
    31	  Supports Cooperative Kernel Launch:            No
    32	  Supports MultiDevice Co-op Kernel Launch:      No
    33	  Device PCI Domain ID / Bus ID / location ID:   0 / 2 / 0
    34	  Compute Mode:
    35	     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >


You can basically ignore everything from these lines except for:

* line 2, that specifies the currently loaded version of the **Driver** and the **CUDA Runtime** currently used;
* line 3, that tells you the the **compute capabilities** of the card;
* line 4, which reports the amount of memory per device;
* line 34 and 35: this informs us that the same device can be used by multiple processes.

Notice that, if you run this command after submitting the job reported above,
you will only see a single GPU device. Replacing `--gres=gpu:1` with `--gres=gpu:2`
will allow `./deviceQuery` to report on both the devices installed on each node.

Try recompiling the code with a different CUDA version. You can find available
ones with `module av cuda`

    # From the same directory, i.e. ~/QE-2019/Day-5/exercise-4/cuda-samples-master/Samples/deviceQuery
    make clean
    module load <SETME>
    CUDA_PATH=$CUDA_HOME SMS="30 35 37 50 52 60 61 70" make


Finally, the second tool, `nvidia-smi`, can be seen as the `top` command for GPUs.
It gives a snapshot of the GPUs power consumption and memory usage and
reports GPU usage by each running process.
Run it on a GPU enabled compute node with


    #Run me!
    nvidia-smi -l 1
