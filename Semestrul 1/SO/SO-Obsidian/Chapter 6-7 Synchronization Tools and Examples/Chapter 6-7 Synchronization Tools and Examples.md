
### <span style="color:rgb(112, 48, 160)">Chapter 6 - Synchronization Tools</span>

- [[Critical section]]
- [[Mutex Locks (Critical Section)]]
- [[Semaphores]]
- [[Memory Barriers - A Hardware Implementation (Critical Section)]]
- [[Liveness]]
- [[Deadlock (Chapter 6-7)]] 
- [[Priority Inversion]]

---
#### <span style="color:rgb(112, 48, 160)">Summary (Chapter 6 - Synchronization Tools):</span> 

- A race condition occurs when processes have concurrent access to shared data and the final result depends on the particular order in which concurrent accesses occur. Race conditions can result in corrupted values of shared data.
- A critical section is a section of code where shared data may be manipulated and a possible race condition may occur. The critical-section problem Practice Exercises 287 is to design a protocol whereby processes can synchronize their activity to cooperatively share data.
- A solution to the critical-section problem must satisfy the following three requirements: (1) mutual exclusion, (2) progress, and (3) bounded waiting. Mutual exclusion ensures that only one process at a time is active in its critical section. Progress ensures that programs will cooperatively determine what process will next enter its critical section. Bounded waiting limits how much time a program will wait before it can enter its critical section.
- Software solutions to the critical-section problem, such as Peterson’s solution, do not work well on modern computer architectures.
- Hardware support for the critical-section problem includes memory barriers; hardware instructions, such as the compare-and-swap instruction; and atomic variables.
- A mutex lock provides mutual exclusion by requiring that a process acquire a lock before entering a critical section and release the lock on exiting the critical section.
- Semaphores, like mutex locks, can be used to provide mutual exclusion. However, whereas a mutex lock has a binary value that indicates if the lock is available or not, a semaphore has an integer value and can therefore be used to solve a variety of synchronization problems.
- A monitor is an abstract data type that provides a high-level form of process synchronization. A monitor uses condition variables that allow processes to wait for certain conditions to become true and to signal one another when conditions have been set to true.
- Solutions to the critical-section problem may suffer from liveness problems, including deadlock.
- The various tools that can be used to solve the critical-section problem as well as to synchronize the activity of processes can be evaluated under varying levels of contention. Some tools work better under certain contention loads than others.

---

#### <span style="color:rgb(112, 48, 160)">Practice exercises (Chapter 6 - Synchronization Tools):</span>


![[Pasted image 20250210171006.png]]
![[Pasted image 20250210171022.png]]


---

### <span style="color:rgb(112, 48, 160)">Chapter 7 - Synchronization Examples</span>

- 