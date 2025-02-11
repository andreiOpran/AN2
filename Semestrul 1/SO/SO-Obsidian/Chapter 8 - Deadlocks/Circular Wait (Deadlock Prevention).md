
- The three options presented thus far for deadlock prevention are generally <span style="color:rgb(112, 48, 160)">impractical</span> in most situations. ([[Mutual Exclusion (Deadlock Prevention)]], [[Hold and Wait (Deadlock Prevention)]], [[No Preemption (Deadlock Prevention)]])
- <span style="color:rgb(112, 48, 160)">However</span>, the fourth and final condition for deadlocks — <span style="color:rgb(112, 48, 160)">the circular-wait condition</span> — presents an opportunity for a practical solution by invalidating one of the necessary conditions. 
- One way to ensure that this condition never holds is to<span style="color:rgb(112, 48, 160)"> impose a total ordering of all resource types</span> and to require that each thread <span style="color:rgb(112, 48, 160)">requests</span> <span style="color:rgb(112, 48, 160)">resources in an increasing order of enumeration</span>.

- To illustrate, we let R = {R1, R2, ..., Rm} be the set of resource types. We assign to each resource type a unique integer number, which allows us to compare two resources and to determine whether one precedes another in our ordering. 
- Formally, we define a one-to-one function F: R → N, where N is the set of natural numbers.
- We can accomplish this scheme in an application program by developing an ordering among all synchronization objects in the system.
	- For example, the lock ordering in the Pthread program shown in Figure 8.1 could be 
		- `F(first mutex) = 1`
		- `F(second mutex) = 5`
	- ![[Pasted image 20250211174411.png]]
	- ![[Pasted image 20250211181018.png]]
	- We can now consider the following <span style="color:rgb(112, 48, 160)">protocol</span> <span style="color:rgb(112, 48, 160)">t</span><span style="color:rgb(112, 48, 160)">o</span> <span style="color:rgb(112, 48, 160)">prevent </span><span style="color:rgb(112, 48, 160)">deadlocks</span>: Each thread can request resources only in an increasing order of enumeration. That is, a thread can initially request an instance of a resource—say, Ri. After that, the thread can request an instance of resource `Rj` if and only if `F(Rj ) > F(Ri)`. For example, using the function defined above, a thread that wants to <span style="color:rgb(112, 48, 160)">use both</span> <span style="color:rgb(112, 48, 160)">first mutex</span> and <span style="color:rgb(112, 48, 160)">second mutex</span> at the same time must first <span style="color:rgb(112, 48, 160)">request</span> <span style="color:rgb(112, 48, 160)">first</span> <span style="color:rgb(112, 48, 160)">mutex</span> and <span style="color:rgb(112, 48, 160)">then</span> <span style="color:rgb(112, 48, 160)">second</span> <span style="color:rgb(112, 48, 160)">mutex</span>.
	- <span style="color:rgb(112, 48, 160)">Alternatively</span>, we can require that a thread requesting an instance of resource `Rj` must have released any resources `Ri` such that `F(Ri) ≥ F(Rj)`. <span style="color:rgb(112, 48, 160)">Note</span> also that if several instances of the same resource type are needed, a <span style="color:rgb(112, 48, 160)">single</span> request for all of them must be issued.
		- <span style="color:rgb(112, 48, 160)">If these two protocols are used, then the circular-wait condition cannot hold.</span> 

- <span style="color:rgb(112, 48, 160)">Keep in mind</span> that developing an ordering, or hierarchy, <span style="color:rgb(112, 48, 160)">does not in itself prevent deadlock</span>. <span style="color:rgb(112, 48, 160)">It is up to application developers to write programs that follow the ordering</span>. 
	- However, establishing a lock ordering can be difficult, especially on a system with hundreds—or thousands—of locks.
- It is also <span style="color:rgb(112, 48, 160)">important</span> to note that imposing a lock ordering d<span style="color:rgb(112, 48, 160)">oes not guarantee deadlock prevention if locks can be acquired dynamically</span>. 
	- For example, assume we have a function that transfers funds between two accounts. To prevent a race condition, each account has an associated mutex lock that is obtained from a `get_lock()` function such as that shown in Figure 8.7. 
	- ![[Pasted image 20250211175042.png]]
	- Deadlock is possible if two threads simultaneously invoke the `transaction()` function, transposing different accounts. 
		- That is, <span style="color:rgb(112, 48, 160)">one</span> thread might invoke: 
			- `transaction(checking account, savings account, 25.0)` 
		- and <span style="color:rgb(112, 48, 160)">another</span> might invoke
			- `transaction(savings account, checking account, 50.0)`