
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