
- Our discussion so far has treated <span style="color:rgb(112, 48, 160)">threads</span> in a generic sense. However, support for threads may be provided either at the user level, for <span style="color:rgb(112, 48, 160)">user threads</span>, or by the kernel, for <span style="color:rgb(112, 48, 160)">kernel threads</span>. 
- <span style="color:rgb(112, 48, 160)">User threads</span> are supported above the kernel and are managed without kernel support.
- <span style="color:rgb(112, 48, 160)">Kernel threads</span> are supported and managed directly by the operating system. 
	- Ultimately, a relationship must exist between <span style="color:rgb(112, 48, 160)">user threads</span> and <span style="color:rgb(112, 48, 160)">kernel threads</span>, as illustrated in Figure 4.6.
	- ![[Pasted image 20250210122214.png]]

--- 

#### <span style="color:rgb(112, 48, 160)">Many-To-One Model</span> 

- The <span style="color:rgb(112, 48, 160)">many-to-one model </span>(Figure 4.7) maps many <span style="color:rgb(112, 48, 160)">user-level threads</span> to one <span style="color:rgb(112, 48, 160)">kernel thread</span>.
- Thread management is done by the <span style="color:rgb(112, 48, 160)">thread library</span> in <span style="color:rgb(112, 48, 160)">user space</span>, so it is efficient (we discuss thread libraries [[Thread libraries|here]]). 
- However, the entire process will block if a thread makes a blocking system call. Also, because only one thread can access the kernel at a time, multiple threads are <span style="color:rgb(112, 48, 160)">unable to run in parallel</span> on multicore systems. 
	- <span style="color:rgb(112, 48, 160)">Green threads</span>—a thread library available for Solaris systems and adopted in early versions of Java—used the many-to-one model. However, very few systems continue to use the model because of its inability to take advantage of multiple processing cores, which have now become standard on most computer systems.
- ![[Pasted image 20250210122229.png]]

---

#### <span style="color:rgb(112, 48, 160)">One-To-One Model</span> 

- The <span style="color:rgb(112, 48, 160)">one-to-one model</span> (Figure 4.8) maps each <span style="color:rgb(112, 48, 160)">user thread</span> to a <span style="color:rgb(112, 48, 160)">kernel thread</span>. 
- It provides more concurrency than the many-to-one model by allowing another thread to run when a thread makes a blocking system call. It also allows multiple threads to run in parallel on multiprocessors.
- The only drawback to this model is that creating a user thread requires creating the corresponding kernel thread, and a large number of kernel threads may burden the performance of a system. Linux, along with the family of Windows operating systems, implement the one-to-one model.

![[Pasted image 20250210122657.png]]


--- 

#### <span style="color:rgb(112, 48, 160)">Many-to-Many Model</span> 

- The <span style="color:rgb(112, 48, 160)">many-to-many model</span> (Figure 4.9) multiplexes many <span style="color:rgb(112, 48, 160)">user-level threads</span> to a smaller or equal number of <span style="color:rgb(112, 48, 160)">kernel threads</span>. 
- The number of kernel threads may be specific to either a particular application or a particular machine (an application may be allocated more kernel threads on a system with eight processing cores than a system with four cores).

 ![[Pasted image 20250210123018.png]]

- One variation on the many-to-many model still multiplexes many userlevel threads to a smaller or equal number of kernel threads but also allows a user-level thread to be bound to a kernel thread. This variation is sometimes referred to as the<span style="color:rgb(112, 48, 160)"> two-level model</span> (Figure 4.10).

![[Pasted image 20250210123455.png]]