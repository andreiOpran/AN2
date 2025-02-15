
- When the CPU is available, it is assigned to the process that has the <span style="color:rgb(112, 48, 160)">smallest</span> <span style="color:rgb(112, 48, 160)">next CPU burst</span>. If the next CPU bursts of two processes are the same, <span style="color:rgb(112, 48, 160)">FCFS</span> <span style="color:rgb(112, 48, 160)">scheduling</span> is used to break the tie.
- <span style="color:rgb(112, 48, 160)">Note</span> that a more appropriate term for this scheduling method would be the <span style="color:rgb(112, 48, 160)">shortest-next-CPU-burst algorithm</span>, because scheduling depends on the length of the next CPU burst of a process, rather than its total length.
- As an example of <span style="color:rgb(112, 48, 160)">SJF scheduling</span>, consider the following set of processes, with the length of the CPU burst given in milliseconds:
	- ![[Pasted image 20250212010013.png]]
	- Using SJF scheduling, we would schedule these processes according to the following <span style="color:rgb(112, 48, 160)">Gantt chart</span>:
	- ![[Pasted image 20250212010033.png]]
	- The waiting time is 3 milliseconds for process P1, 16 milliseconds for process P2, 9 milliseconds for process P3, and 0 milliseconds for process P4. Thus, the average waiting time is (3 + 16 + 9 + 0)/4 = <span style="color:rgb(112, 48, 160)">7 milliseconds</span>. By comparison, if we were using the <span style="color:rgb(112, 48, 160)">FCFS</span> scheduling scheme, the average waiting time would be <span style="color:rgb(112, 48, 160)">10.25 milliseconds</span>.

- Although the SJF algorithm is <span style="color:rgb(112, 48, 160)">optimal</span>, <span style="color:rgb(112, 48, 160)">it cannot be implemented</span> at the level of CPU scheduling, as there is <span style="color:rgb(112, 48, 160)">no way to know the length of the next CPU burst</span>. 
	- One approach to this problem is to try to <span style="color:rgb(112, 48, 160)">approximate</span> SJF scheduling. We may not know the length of the next CPU burst, but we may be able to <span style="color:rgb(112, 48, 160)">predict</span> its value. We expect that the next CPU burst will be similar in length to the previous ones. By computing an approximation of the length of the next CPU burst, we can pick the process with the shortest predicted CPU burst
	- The next CPU burst is generally predicted as an exponential average of the measured lengths of previous CPU bursts. We can define the exponential average with the following formula.
	- Let $t_n$ be the length of the $n$-th CPU burst, and let $\tau_{n+1}$ be our predicted value for the next CPU burst. Then, for $\alpha$, where $0 \leq \alpha \leq 1$, we define:
	- $$
\tau_{n+1} = \alpha t_n + (1 - \alpha)\tau_n
$$
	- The value of $t_n$ contains our most recent information, while $\tau_n$ stores the past history. The parameter $\alpha$ controls the relative weight of recent and past history in our prediction.
		- If $\alpha = 0$, then $\tau_{n+1} = \tau_n$, meaning recent history has no effect (current conditions are assumed to be transient).  
		- If $\alpha = 1$, then $\tau_{n+1} = t_n$, meaning only the most recent CPU burst matters (history is assumed to be old and irrelevant).  
		- More commonly, $\alpha = \frac{1}{2}$, so recent history and past history are equally weighted.  
	- The initial $\tau_0$ can be defined as a constant or as an overall system average.  
	- Figure 5.4 shows an exponential average with $\alpha = \frac{1}{2}$ and $\tau_0 = 10$.
	- ![[Pasted image 20250212010924.png]]
	- To understand the behavior of the exponential average, we can expand the formula for $\tau_{n+1}$ by substituting for $\tau_n$ to find: 
	- $$ \tau_{n+1} = \alpha t_n + (1 - \alpha) \alpha t_{n-1} + \dots + (1 - \alpha)^j \alpha t_{n-j} + \dots + (1 - \alpha)^{n+1} \tau_0. $$
	- Typically, $\alpha$ is less than 1. As a result, $(1 - \alpha)$ is also less than 1, and each successive term has less weight than its predecessor.

- The SJF algorithm can be either <span style="color:rgb(112, 48, 160)">preemptive</span> or <span style="color:rgb(112, 48, 160)">nonpreemptive</span>. The choice arises when a new process arrives at the ready queue while a previous process is still executing. The next CPU burst of the newly arrived process may be shorter than what is left of the currently executing process. A<span style="color:rgb(112, 48, 160)"> preemptive SJF algorithm</span> will preempt the currently executing process, whereas a <span style="color:rgb(112, 48, 160)">nonpreemptive SJF algorithm</span> will allow the currently running process to finish its CPU burst. <span style="color:rgb(112, 48, 160)">Preemptive SJF scheduling</span> is sometimes called<span style="color:rgb(112, 48, 160)"> shortest-remaining-time-first scheduling</span>.

- As an example, consider the following four processes, with the length of the CPU burst given in milliseconds:
- ![[Pasted image 20250212011527.png]]
- If the processes arrive at the ready queue at the times shown and need the indicated burst times, then the resulting <span style="color:rgb(112, 48, 160)">preemptive</span> SJF schedule is as depicted in the following <span style="color:rgb(112, 48, 160)">Gantt chart</span>:
- ![[Pasted image 20250212011602.png]]
- Process P1 is started at time 0, since it is the only process in the queue. Process P2 arrives at time 1. The remaining time for process P1 (7 milliseconds) is larger than the time required by process P2 (4 milliseconds), so process P1 is preempted, and process P2 is scheduled. The average waiting time for this example is \[(10 − 1) + (1 − 1) + (17 − 2) + (5 − 3)]/4 = 26/4 = <span style="color:rgb(112, 48, 160)">6.5 milliseconds</span>. 
	- Nonpreemptive SJF scheduling would result in an average waiting time of <span style="color:rgb(112, 48, 160)">7.75 milliseconds</span>.
