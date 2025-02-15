
- In a system with a single CPU core, only one process can run at a time. Others must wait until the CPU’s core is free and can be rescheduled. 
- The objective of multiprogramming is to have some process running at all times, to maximize CPU utilization. 
- The idea is relatively simple. A process is executed <span style="color:rgb(112, 48, 160)">until it must wait</span>, typically for the completion of some <span style="color:rgb(112, 48, 160)">I/O request</span>. In a simple computer system, the CPU then just sits idle. All this waiting time is <span style="color:rgb(112, 48, 160)">wasted</span>; no useful work is accomplished. 
- With multiprogramming, we try to use this time productively. Several processes are<span style="color:rgb(112, 48, 160)"> kept in memory at one time</span>. When one process has to <span style="color:rgb(112, 48, 160)">wait</span>, the operating system takes the CPU away from that process and <span style="color:rgb(112, 48, 160)">gives the CPU to another process</span>. This pattern continues. Every time one process has to <span style="color:rgb(112, 48, 160)">wait</span>, <span style="color:rgb(112, 48, 160)">another process can</span> <span style="color:rgb(112, 48, 160)">take over</span> use of the CPU. 
	- On a <span style="color:rgb(112, 48, 160)">multicore</span> system, this concept of keeping the CPU busy is <span style="color:rgb(112, 48, 160)">extended to all processing cores</span> on the system.

- [[CPU Scheduler]]
- [[CPU Dispatcher]]
- [[Scheduling Criteria]]
- [[CPU – IO Burst Cycle]]
- [[Scheduling Algorithms (One core)]]

---  

#### <span style="color:rgb(112, 48, 160)">Summary:</span> 

- **CPU scheduling** is the task of selecting a waiting process from the ready queue and allocating the CPU to it. The CPU is allocated to the selected process by the dispatcher.
- **Scheduling algorithms** may be either:
    - **Preemptive**: The CPU can be taken away from a process.
    - **Nonpreemptive**: A process must voluntarily relinquish control of the CPU. Almost all modern operating systems are preemptive.
- **Scheduling algorithms** can be evaluated according to the following five criteria:
    1. CPU utilization
    2. Throughput
    3. Turnaround time
    4. Waiting time
    5. Response time
- **First-Come, First-Served (FCFS) Scheduling**:
    - Simplest scheduling algorithm.
    - Can cause short processes to wait for very long processes.
- **Shortest-Job-First (SJF) Scheduling**:
    - Provably optimal, providing the shortest average waiting time.
    - Implementing SJF scheduling is difficult because predicting the length of the next CPU burst is difficult.
- **Round-Robin (RR) Scheduling**:
    - Allocates the CPU to each process for a time quantum.
    - If the process does not relinquish the CPU before its time quantum expires, the process is preempted, and another process is scheduled to run for a time quantum.
- **Priority Scheduling**:
    - Assigns each process a priority.
    - The CPU is allocated to the process with the highest priority.
    - Processes with the same priority can be scheduled in FCFS order or using RR scheduling.
- **Multilevel Queue Scheduling**:
    - Partitions processes into several separate queues arranged by priority.
    - The scheduler executes the processes in the highest-priority queue.
    - Different scheduling algorithms may be used in each queue.
- **Multilevel Feedback Queues**:
    - Similar to multilevel queues, except that a process may migrate between different queues.
- **Multicore Processors**:
    - Place one or more CPUs on the same physical chip.
    - Each CPU may have more than one hardware thread.
    - From the perspective of the operating system, each hardware thread appears to be a logical CPU.
- **Load Balancing on Multicore Systems**:
    - Equalizes loads between CPU cores.
    - Migrating threads between cores to balance loads may invalidate cache contents and increase memory access times.
- **Real-Time Scheduling**:
    - **Soft Real-Time Scheduling**: Gives priority to real-time tasks over non-real-time tasks.
    - **Hard Real-Time Scheduling**: Provides timing guarantees for real-time tasks.
- **Rate-Monotonic Real-Time Scheduling**:
    - Schedules periodic tasks using a static priority policy with preemption.
- **Earliest-Deadline-First (EDF) Scheduling**:
    - Assigns priorities according to deadlines.
    - The earlier the deadline, the higher the priority; the later the deadline, the lower the priority.
- **Proportional Share Scheduling**:
    - Allocates T shares among all applications.
    - If an application is allocated N shares of time, it is ensured of having N/T of the total processor time.
- **Linux Completely Fair Scheduler (CFS)**:
    - Assigns a proportion of CPU processing time to each task.
    - The proportion is based on the virtual runtime (vruntime) value associated with each task.
- **Windows Scheduling**:
    - Uses a preemptive, 32-level priority scheme to determine the order of thread scheduling.
- **Solaris Scheduling**:
    - Identifies six unique scheduling classes that are mapped to a global priority.
    - CPU-intensive threads are generally assigned lower priorities (and longer time quantums).
    - I/O-bound threads are usually assigned higher priorities (with shorter time quantums).

---

![[Pasted image 20250212175459.png]]
![[Pasted image 20250212175511.png]]
![[Pasted image 20250212175523.png]]
![[Pasted image 20250212175533.png]]