
- We begin our consideration of process synchronization by discussing the so-called <span style="color:rgb(112, 48, 160)">critical-section problem</span>. 
- Consider a system consisting of <span style="color:rgb(112, 48, 160)">n</span> processes \{P_0, P_1,. . ., P_(n−1)} 
- Each process has a segment of code, called a <span style="color:rgb(112, 48, 160)">critical section</span>, in which the process may be accessing — and updating — data that is shared with at least one other process. 
- The <span style="color:rgb(112, 48, 160)">important</span> feature of the system is that, when one process is executing in its critical section, no other process is allowed to execute in its critical section. That is, no two processes are executing in their critical sections at the same time. The critical-section problem is to design a protocol that the processes can use to synchronize their activity so as to cooperatively share data. 
- Each process <span style="color:rgb(112, 48, 160)">must request permission</span> to enter its <span style="color:rgb(112, 48, 160)">critical section</span>. The section of code implementing this request is the <span style="color:rgb(112, 48, 160)">entry section</span>. 
- The critical section may be followed by an <span style="color:rgb(112, 48, 160)">exit section</span>. 
- The remaining code is the <span style="color:rgb(112, 48, 160)">remainder section</span>. 
- The general structure of a typical process is shown in Figure 6.1. The <span style="color:rgb(112, 48, 160)">entry section</span> and <span style="color:rgb(112, 48, 160)">exit sections</span> are used to handle the synchronization.

![[Pasted image 20250210151506.png]]

- A solution to the critical-section problem must satisfy the following three requirements:
	1. <span style="color:rgb(112, 48, 160)">Mutual exclusion</span>: If process P_i is executing in its critical section, then no other processes can be executing in their critical sections.
	2. <span style="color:rgb(112, 48, 160)">Progress</span>: If no process is executing in its critical section and some processes wish to enter their critical sections, then only those processes that are not executing in their remainder sections can participate in deciding which will enter its critical section next, and this selection cannot be postponed indefinitely.
	3. <span style="color:rgb(112, 48, 160)">Bounded waiting</span>: There exists a bound, or limit, on the number of times that other processes are allowed to enter their critical sections after a process has made a request to enter its critical section and before that request is granted.

- <span style="color:rgb(112, 48, 160)">Solutions</span>:
	- [[Peterson's Solution (Critical section)|Peterson's Solution]]  
	- [[Mutex Locks (Critical Section)|Mutex Locks]]
	- [[Memory Barriers - A Hardware Implementation (Critical Section)|Memory Barriers - A Hardware Implementation]] 
	- [[Semaphores]] 