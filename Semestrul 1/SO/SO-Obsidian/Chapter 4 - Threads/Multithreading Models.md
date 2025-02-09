
- Our discussion so far has treated <span style="color:rgb(112, 48, 160)">threads</span> in a generic sense. However, support for threads may be provided either at the user level, for <span style="color:rgb(112, 48, 160)">user threads</span>, or by the kernel, for <span style="color:rgb(112, 48, 160)">kernel threads</span>. 
- <span style="color:rgb(112, 48, 160)">User threads</span> are supported above the kernel and are managed without kernel support.
- <span style="color:rgb(112, 48, 160)">Kernel threads</span> are supported and managed directly by the operating system. 
	- Ultimately, a relationship must exist between <span style="color:rgb(112, 48, 160)">user threads</span> and <span style="color:rgb(112, 48, 160)">kernel threads</span>, as illustrated in Figure 4.6.
	- ![[Pasted image 20250210000359.png]]

--- 

#### <span style="color:rgb(112, 48, 160)">Many-To-One Model</span> 

- The <span style="color:rgb(112, 48, 160)">many-to-one model </span>(Figure 4.7) maps many user-level threads to one kernel thread.
- Thread management is done by the <span style="color:rgb(112, 48, 160)">thread library</span> in <span style="color:rgb(112, 48, 160)">user space</span>, so it is efficient (we discuss thread libraries [[Thread libraries|here]]). 
- However, the entire process will block if a thread makes a blocking system call. Also, because only one thread can access the kernel at a time, multiple threads are <span style="color:rgb(112, 48, 160)">unable to run in parallel</span> on multicore systems. 
	- <span style="color:rgb(112, 48, 160)">Green threads</span>—a thread library available for Solaris systems and adopted in early versions of Java—used the many-to-one model. However, very few systems continue to use the model because of its inability to take advantage of multiple processing cores, which have now become standard on most computer systems.
- ![[Pasted image 20250210000959.png]]

---

#### <span style="color:rgb(112, 48, 160)">One-To-One Model</span> 