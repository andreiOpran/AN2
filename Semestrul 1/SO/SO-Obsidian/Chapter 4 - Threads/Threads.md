
- A <span style="color:rgb(112, 48, 160)">thread</span> is a basic unit of CPU utilization
- It comprises a <span style="color:rgb(112, 48, 160)">thread ID</span>, a <span style="color:rgb(112, 48, 160)">program counter (PC)</span>, a <span style="color:rgb(112, 48, 160)">register set</span>, and a <span style="color:rgb(112, 48, 160)">stack</span>. 
- It shares with other thread<span style="color:rgb(112, 48, 160)"><span style="color:rgb(112, 48, 160)"></span></span>s belonging to the same process its <span style="color:rgb(112, 48, 160)">code</span> section, <span style="color:rgb(112, 48, 160)">data</span> section, and other operating-system resources, such as <span style="color:rgb(112, 48, 160)">open files and signals</span>. 
- A <span style="color:rgb(112, 48, 160)">traditional process</span> has a single thread of control. If a process has <span style="color:rgb(112, 48, 160)">multiple threads of control</span>, it can perform more than one task at a time. 
- Figure below illustrates the difference between a traditional <span style="color:rgb(112, 48, 160)">single-threaded process </span>and a <span style="color:rgb(112, 48, 160)">multithreaded process</span>.

![[Pasted image 20250209223743.png]]


- <span style="color:rgb(112, 48, 160)">Benefits:</span>
	- <span style="color:rgb(112, 48, 160)">Responsiveness.</span> Multithreading an interactive application may allow a program to continue running even if part of it is <span style="color:rgb(112, 48, 160)">blocked</span> or is performing a <span style="color:rgb(112, 48, 160)">lengthy operation</span>, thereby increasing responsiveness to the user.
		- For instance, consider what happens when a user clicks a button that results in the performance of a time-consuming operation. A single-threaded application would be unresponsive to the user until the operation had been completed. In contrast, if the time-consuming operation is performed in a separate, asynchronous thread, the application remains responsive to the user.
	- <span style="color:rgb(112, 48, 160)">Resource sharing.</span> Processes can share resources only through techniques such as shared memory and message passing. Such techniques must be explicitly arranged by the programmer. 
		- However, threads share the memory and the resources of the process to which they belong by default. The benefit of sharing code and data is that it allows an application to have several different threads of activity within the same address space
	- <span style="color:rgb(112, 48, 160)">Economy.</span> Allocating memory and resources for process creation is costly. Because threads share the resources of the process to which they belong, it is more economical to create and context-switch threads. 
		- Empirically gauging the difference in overhead can be difficult, but in general, thread creation consumes less time and memory than process creation. Additionally, context switching is typically faster between threads than between processes.
	- <span style="color:rgb(112, 48, 160)">Scalability.</span> The benefits of multithreading can be even greater in a multiprocessor architecture, where threads may be running in parallel on different processing cores. 
		- A single-threaded process can run on only one processor, regardless of how many are available.

---

##### <span style="color:rgb(112, 48, 160)">Multicore programming:</span>

- Consider an application with four threads. On a system with a single computing core, concurrency merely means that the execution of the threads will be interleaved over time, because the processing core is capable of executing only one thread at a time:
	- ![[Pasted image 20250209230723.png]]
- On a system with multiple cores, however, concurrency means that some threads can run in parallel, because the system can assign a separate thread to each core:
	- ![[Pasted image 20250209230935.png]]


- Notice the distinction between [[Concurrency vs. Parallelism|concurrency and parallelism]] in this discussion. A <span style="color:rgb(112, 48, 160)">concurrent</span> system supports more than one task by allowing all the tasks to make progress. In contrast, a <span style="color:rgb(112, 48, 160)">parallel</span> system can perform more than one task simultaneously. Thus, it is possible to have concurrency without parallelism.
- Before the advent of multiprocessor and multicore architectures, most computer systems had only a single processor, and CPU schedulers were designed to provide the <span style="color:rgb(112, 48, 160)">illusion of parallelism</span> by rapidly switching between processes, thereby allowing each process to make progress. Such processes were running <span style="color:rgb(112, 48, 160)">concurrently</span>, but not in <span style="color:rgb(112, 48, 160)">parallel</span>.

--- 

##### <span style="color:rgb(112, 48, 160)">Multicore programming challenges:</span> 

1. <span style="color:rgb(112, 48, 160)">Identifying tasks.</span> This involves examining applications to find areas that can be divided into separate, concurrent tasks. Ideally, tasks are independent of one another and thus can run in parallel on individual cores.
2. <span style="color:rgb(112, 48, 160)">Balance. </span>While identifying tasks that can run in parallel, programmers must also ensure that the tasks perform equal work of equal value. In some instances, a certain task may not contribute as much value to the overall process as other tasks. Using a separate execution core to run that task may not be worth the cost, see [[Amdahl's Law]].
3. <span style="color:rgb(112, 48, 160)">Data splitting.</span> Just as applications are divided into separate tasks, the data accessed and manipulated by the tasks must be divided to run on separate cores.
4. <span style="color:rgb(112, 48, 160)">Data dependency.</span> The data accessed by the tasks must be examined for dependencies between two or more tasks. When one task depends on data from another, programmers must ensure that the execution of the tasks is synchronized to accommodate the data dependency. 

---

- #### [[Thread Cancellation]]
- #### [[Thread-Local Storage]]