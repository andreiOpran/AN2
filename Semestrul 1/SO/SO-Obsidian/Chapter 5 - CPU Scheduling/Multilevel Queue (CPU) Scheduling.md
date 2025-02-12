
- With both [[Priority (CPU) Scheduling|priority]] and [[Round-Robin (CPU) Scheduling|round-robin scheduling]], all processes may be placed in a single queue, and the scheduler then selects the process with the highest priority to run. Depending on how the queues are managed, an *O(n)* search may be necessary to determine the highest-priority process. 
- In practice, it is often easier to have <span style="color:rgb(112, 48, 160)">separate queues</span> for each distinct priority, and priority scheduling simply schedules the process in the highest-priority queue. This is illustrated in Figure 5.7.
- This approach — known as <span style="color:rgb(112, 48, 160)">multilevel queue</span> — also works well when<span style="color:rgb(112, 48, 160)"> priority scheduling</span> is combined with <span style="color:rgb(112, 48, 160)">round-robin</span>: if there are multiple processes in the highest-priority queue, they are executed in round-robin order. In the most generalized form of this approach, a priority is assigned statically to each process, and a process remains in the same queue for the duration of its runtime.
- ![[Pasted image 20250212154348.png]]
- A <span style="color:rgb(112, 48, 160)">multilevel</span> <span style="color:rgb(112, 48, 160)">queue</span> scheduling algorithm can also be used to partition processes into several separate queues based on the process type (Figure 5.8). 
	- For example, a common division is made between <span style="color:rgb(112, 48, 160)">foreground</span> (interactive) processes and <span style="color:rgb(112, 48, 160)">background</span> (batch) processes. 
	- These two types of processes have different response-time requirements and so may have different scheduling needs. In addition, <span style="color:rgb(112, 48, 160)">foreground processes may have priority</span> (externally defined)<span style="color:rgb(112, 48, 160)"> over background processes</span>. 
	- Separate queues might be used for foreground and background processes, and each queue might have its own scheduling algorithm. 
		- The foreground queue might be scheduled by an RR algorithm. 
		- While the background queue is scheduled by an FCFS algorithm.
- ![[Pasted image 20250212154707.png]]

- <span style="color:rgb(112, 48, 160)">In addition</span>, there must be <span style="color:rgb(112, 48, 160)">scheduling among the queues</span>, which is commonly implemented as fixed-priority <span style="color:rgb(112, 48, 160)">preemptive</span> scheduling. 
	- For example, the real-time queue may have absolute priority over the interactive queue. Let’s look at an example of a multilevel queue scheduling algorithm with four queues, listed below in order of priority: 
		1. Real-time processes 
		2. System processes 
		3. Interactive processes 
		4. Batch processes
	- Each queue has absolute priority over lower-priority queues. No process in the batch queue, for example, could run unless the queues for real-time processes, system processes, and interactive processes were all empty. If an interactive process entered the ready queue while a batch process was running, the batch process would be <span style="color:rgb(112, 48, 160)">preempted</span>.
	- Another possibility is to time-slice among the queues. Here, each queue gets a certain portion of the CPU time, which it can then schedule among its various processes. For instance, in the foreground –background queue example, the foreground queue can be given <span style="color:rgb(112, 48, 160)">80 percent</span> of the CPU time for RR scheduling among its processes, while the background queue receives <span style="color:rgb(112, 48, 160)">20 percent</span> of the CPU to give to its processes on an FCFS basis.