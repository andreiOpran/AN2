
- Suppose that a database is to be shared among several concurrent processes. Some of these processes may want only to read the database, whereas others may want to update (that is, <span style="color:rgb(112, 48, 160)">read</span> and <span style="color:rgb(112, 48, 160)">write</span>) the database. 
- We distinguish between these two types of processes by referring to the former as <span style="color:rgb(112, 48, 160)">readers</span> and to the latter as <span style="color:rgb(112, 48, 160)">writers</span>. 
	- Obviously, if two readers access the shared data simultaneously, no adverse effects will result. 
	- However, if a <span style="color:rgb(112, 48, 160)">writer</span> and some <span style="color:rgb(112, 48, 160)">other process</span> (either a reader or a writer) access the database simultaneously, <span style="color:rgb(112, 48, 160)">chaos may ensue</span>.
		- To ensure that these difficulties do not arise, we require that the <span style="color:rgb(112, 48, 160)">writers</span> have <span style="color:rgb(112, 48, 160)">exclusive access</span> to the shared database <span style="color:rgb(112, 48, 160)">while writing</span> to the database. 
		- This synchronization problem is referred to as the r<span style="color:rgb(112, 48, 160)">eaders–writers problem</span>. Since it was originally stated, it has been used to test nearly every new synchronization primitive.
	
	-  The readers–writers problem has <span style="color:rgb(112, 48, 160)">several variations</span>, <span style="color:rgb(112, 48, 160)">all involving priorities</span>. 
		- The simplest one, referred to as the first readers–writers problem, requires that no reader be kept waiting unless a writer has already obtained permission to use the shared object. In other words, no reader should wait for other readers to finish simply because a writer is waiting. 
		- The second readers–writers problem requires that, once a writer is ready, that writer perform its write as soon as possible. In other words, if a writer is waiting to access the object, no new readers may start reading.
			- A solution to either problem may result in starvation. In the first case, <span style="color:rgb(112, 48, 160)">writers may starve</span>; in the second case, <span style="color:rgb(112, 48, 160)">readers may starve</span>.


- Next, we present a solution to the <span style="color:rgb(112, 48, 160)">first</span> readers–writers problem.
- The reader processes share the following data structures:
```C
semaphore rw_mutex = 1; 
semaphore mutex = 1; 
int read_count = 0;
```
- The binary [[Semaphores|semaphores]] <span style="color:rgb(112, 48, 160)">mutex</span> and <span style="color:rgb(112, 48, 160)">rw_mutex</span> are initialized to 1; 
- <span style="color:rgb(112, 48, 160)">read_count</span> is a counting semaphore initialized to 0. 
- The semaphore <span style="color:rgb(112, 48, 160)">rw_mutex</span> is common to both reader and writer processes. 
- The <span style="color:rgb(112, 48, 160)">mutex </span>semaphore is used to ensure mutual exclusion when the variable read count is updated. 
- The <span style="color:rgb(112, 48, 160)">read_count</span> variable keeps track of how many processes are currently reading the object. 
- The semaphore <span style="color:rgb(112, 48, 160)">rw_mutex</span> functions as a mutual exclusion semaphore for the writers. It is also used by the first or last reader that enters or exits the critical section. It is not used by readers that enter or exit while other readers are in their critical sections.

- The code for a <span style="color:rgb(112, 48, 160)">writer</span> process is shown in Figure 7.3
- The code for a <span style="color:rgb(112, 48, 160)">reader</span> process is shown in Figure 7.4. 
- Note that, if a writer is in the critical section and n readers are waiting, then one reader is queued on <span style="color:rgb(112, 48, 160)">rw_mutex</span>, and n−1 readers are queued on <span style="color:rgb(112, 48, 160)">mutex</span>. 
- Also observe that, when a writer executes <span style="color:rgb(112, 48, 160)">signal(rw_mutex)</span>, we may resume the execution of either the waiting readers or a single waiting writer. The selection is made by the scheduler.
- ![[Pasted image 20250210231428.png]]
- ![[Pasted image 20250210231437.png]]


- The readers–writers problem and its solutions have been generalized to provide <span style="color:rgb(112, 48, 160)">reader–writer</span> <span style="color:rgb(112, 48, 160)">locks</span> on some systems. Acquiring a reader–writer lock requires specifying the mode of the lock: either read or write access. When a process wishes only to read shared data, it requests the reader–writer lock in read mode. A process wishing to modify the shared data must request the lock in write mode. Multiple processes are permitted to concurrently acquire a reader–writer lock in read mode, but only one process may acquire the lock for writing, as exclusive access is required for writers. 
	- <span style="color:rgb(112, 48, 160)">Reader–writer locks</span> are most useful in the following situations:
		- In applications where it is easy to identify which processes only read shared data and which processes only write shared data. 
		- In applications that have more readers than writers. This is because reader–writer locks generally require more overhead to establish than semaphores or mutual-exclusion locks. The increased concurrency of allowing multiple readers compensates for the overhead involved in setting up the reader–writer lock.