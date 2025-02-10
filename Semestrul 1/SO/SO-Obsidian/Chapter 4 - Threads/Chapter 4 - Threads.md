
- [[Threads]]
- [[Parallelism]]
- [[Concurrency]]
	- [[Concurrency vs. Parallelism]]
- [[Amdahl's Law]]
- [[Multithreading Models]]
- [[Signals]]


---

### <span style="color:rgb(112, 48, 160)">Summary:</span>


- A [[Threads|thread]] represents a basic unit of CPU utilization, and threads belonging to the same process share many of the process resources, including code and data.
- There are four primary benefits to [[Multithreading Models|multithreaded]] applications: (1) responsiveness, (2) resource sharing, (3) economy, and (4) scalability.
- [[Concurrency]] exists when multiple threads are making progress, whereas [[Parallelism]] exists when multiple threads are making progress simultaneously. On a system with a single CPU, only concurrency is possible; parallelism requires a multicore system that provides multiple CPUs.
- There are several challenges in designing multithreaded applications. They include dividing and balancing the work, dividing the data between the different threads, and identifying any data dependencies. Finally, multithreaded programs are especially challenging to test and debug.
- [[Parallelism|Data parallelism]] distributes subsets of the same data across different computing cores and performs the same operation on each core. [[Parallelism|Task parallelism]] distributes not data but tasks across multiple cores. Each task is running a unique operation.
- User applications create user-level threads, which must ultimately be mapped to kernel threads to execute on a CPU. [[Multithreading Models|The many-to-one model maps many user-level threads to one kernel thread. Other approaches include the one-to-one and many-to-many models]].
- A [[Thread libraries|thread library]] provides an API for creating and managing threads. Three common thread libraries include Windows, Pthreads, and Java threading. Windows is for the Windows system only, while Pthreads is available for POSIX-compatible systems such as UNIX, Linux, and macOS. Java threads will run on any system that supports a Java virtual machine.
- Threads may be [[Thread Cancellation|terminated]] using either asynchronous or deferred cancellation. Asynchronous cancellation stops a thread immediately, even if it is in the middle of performing an update. Deferred cancellation informs a thread that it should terminate but allows the thread to terminate in an orderly fashion. In most circumstances, deferred cancellation is preferred to asynchronous termination.
- Unlike many other operating systems, Linux does not distinguish between processes and threads; instead, it refers to each as a task. The Linux clone() system call can be used to create tasks that behave either more like processes or more like threads.

---

![[Pasted image 20250210132140.png]]
![[Pasted image 20250210132226.png]]