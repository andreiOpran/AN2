
- In our problem ([[Producer–consumer Problem]]), the <span style="color:rgb(112, 48, 160)">producer</span> and <span style="color:rgb(112, 48, 160)">consumer</span> processes share the following data structures:

```C
int n; 
semaphore mutex = 1; 
semaphore empty = n; 
semaphore full = 0;
```

- We assume that the pool consists of <span style="color:rgb(112, 48, 160)">n</span> <span style="color:rgb(112, 48, 160)">buffers</span>, each capable of holding <span style="color:rgb(112, 48, 160)">one item</span>. 
- The [[Mutex Locks (Critical Section)|mutex]] binary  [[Semaphores|semaphore]]  provides mutual exclusion for accesses to the buffer pool and is initialized to the value 1. 
- The empty and full semaphores count the number of empty and full buffers. The semaphore empty is initialized to the value n; the semaphore full is initialized to the value 0.

- The code for the <span style="color:rgb(112, 48, 160)">producer</span> process is shown in Figure 7.1, and the code for the <span style="color:rgb(112, 48, 160)">consumer</span> process is shown in Figure 7.2. 
- Note the <span style="color:rgb(112, 48, 160)">symmetry</span> between the producer and the consumer. 
- We can interpret this code as the <span style="color:rgb(112, 48, 160)">producer producing full buffers</span> for the consumer or as the <span style="color:rgb(112, 48, 160)">consumer producing empty buffers</span> for the producer.
- ![[Pasted image 20250210215959.png]]
- ![[Pasted image 20250210215945.png]]