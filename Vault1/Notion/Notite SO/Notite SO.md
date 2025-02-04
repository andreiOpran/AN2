  

  

---

  

# ==1 - Introduction==

  

  

---

  

  

- User ←→ application programs ←→ ==OS== ←→ hardware
- For learning about ==OS==, you first need to know about: ==**hardware arhitecture**== (CPU, MEM, I/O devices, storage)
- 2 perspectives:
    - user view: from this POV, goal is to ==maximize the work and ease of use==
    - system view: from ths POV, we focus on ==resource utilization==
- OS =
    - resource allocator
    - control program = manages execution to prevent errors (concerned with operation and control of I/O devices)
- OS =
    - everything the vendor ship when you order the OS
    - program that is running at all times → ==Kernel==
    - ==Kernel== + ==system programs== (associated with OS but not part of the Kernel) + ==application programs==
- Mobile OS → not only Kernel but they have ==middleware== too (software framework for application developers, that support DBs, multimedia and graphics)
- For our purpose, OS = ==kernel== + ==middleware== that ease application development + ==system programs== ==aid managing the system while it is running==
- Common ==bus== ==connects components and shared memory==

![[image.png]]

  

- Each ==controller== is in charge of a specific type of device. A device controller has a local buffer and registers, and it moves data between the peripheral device and the local buffer.
- OS has ==device driver== for each device connected. It understands the device controller and provides a uniform interface (device → OS).
- I/O operation → ==controller== transfers data to local buffer → when the transfer is done, it informs the ==device driver== via an ==interrupt==.
- ==Hardware== may trigger an ==interrupt== by sending a signal to the ==CPU== via ==system bus==.
- ==CPU interrupted== → stops what it is doing and ==transfers execution== to fixed location → fixed location contains a starting adress for the ==service routine== → ==completion== of the routine → the ==CPU resumes==

  

![[image 1.png]]

  

- ==Frequent interrupts== → table of pointers to interrupt routines to provide necessary speed → ==interrupt vector==
- ==Before servicing== the interrupt → save state information of initial program (the ==interrupt-handler== does that) → ==after servicing== load the the return address into the program counter
- CPU has a wire called ==interrupt-request line== that the CPU senses after executing every instruction → ==controller== sends signal on the line → CPU reads interrupt number and jumps to the ==interrupt-handler routine== via ==interrupt vector==.

  

![[image 2.png]]

  

- CPUs have 2 interrupt request lines:
    
    - ==Nonmaskable interrupt== → for events like unrecoverable memory errors
    - ==Maskable interrupt== → turned of by CPU before execution of critical instructions (used by device controllers)
    
      
    
    ![[image 3.png]]
    
    0-31 unmaskable; 32-255 maskable
    
      
    
- Computers have more devices (hence interrupt handlers) than they have address elements in an interrupt vector → problem → solution: ==interrupt chaining== → each element in the interrupt vector points to a ==list of interrupt handlers==
- First program to run → bootstrap program which loads the OS → loaded from ==electrically erasable programmable read-only memory== (EEPFROM)
- RAM (implemented in semiconductor tech named dynamic random-access memory AKA ==DRAM==) = ==volatile==
- Von Neumann architecture:
    - ==Fetch instruction== from memory and store in ==instruction register==
    - ==Decode== and ==execute== instruction
    - ==Resulted stored back== in the memory
        - Memory unit only sees ==stream of memory addresses==
- We would want all programs to be in main memory, but it’s too ==small and volatile== so we developed ==secondary storage== (==HDD==, NVM (non-volatile storage) ==devices==)
    - Most programs are ==held in secondary storage== and ==loaded into main memory==

  

![[image 4.png]]

Top 4 lvl = ==semi-conductor memory==

  

- ==Terminology==:
    - Volatile storage = memory
    - Nonvolatile storage = NVS, divided in:
        - Mechanical (HDD)
        - Electrical (FRAM, NRAM, SSD) = NVM
- Interrupt-driven I/O can produce high overhead → we introduce ==DMA (direct memory access)==
    - ==DMA== = ==device controller== transfers blocks of data ==directly== to/from the device to ==main memory==

![[image 5.png]]

  

- The ==core== executes instructions and registers for storing data
- ==Multiprocessor systems== → the processors share the computer bus and sometimes the clock, memory and peripheral devices
- Speed-up ratio with N processors ≠ N
- ==Symmetric multiprocessing (SMP)== → each CPU processor performs all task
    - ==Each== CPU has its own ==registers== & ==private/local cache==
    - ==All== processors ==share physical memory== over the system bus
    - N processes can run if there are N CPUs

  

![[image 6.png]]

  

- ==Multiprocessor== includes multicore systems → multiple cores on a single chip
- Multiprocessor ==better== than multiple single-core chips
    - on-chip communication ==faster== than between-chip communication
- ==Dual-core== with two cores per processor chip
    - Each core has its own ==register set== and ==L1 cache==
    - ==L2 cache== is local to the chip and it is ==shared== by the two cores

  

![[image 7.png]]

  

- Defintions:
    - ==CPU== - hardware that executes instructions
    - ==Processor== - physical chip that contains ≥1 CPUs
    - ==Core== - basic computation unit of CPU
    - ==Multicore== - multiple computing cores on the same CPU
    - ==Multiprocessor== - multiple processors
- Adding many CPUs ==does not scale well== (contention for the system bus becomes bottleneck) → introduce ==shared system interconnect== so that all CPUs share one physical adress space
    - ==Non-uniform memory access== (==NUMA==)
    - ==Drawback== → ==incresed latency== when a CPU must access remote memory across system interconnect

  

![[image 8.png]]