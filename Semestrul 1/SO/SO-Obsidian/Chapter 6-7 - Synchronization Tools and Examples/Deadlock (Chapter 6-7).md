
- The implementation of a semaphore with a waiting queue may result in a situation where<span style="color:rgb(112, 48, 160)"> two or more processes are waiting indefinitely</span> for an event that can be caused only by one of the waiting processes. The event in question is the execution of a signal() operation.
- When such a state is reached, these processes are said to be <span style="color:rgb(112, 48, 160)">deadlocked</span>.

- To illustrate this, consider a system consisting of two processes, P0 and P1, each accessing two semaphores, S and Q, set to the value 1:
	- ![[Pasted image 20250210164533.png]]
- Suppose that <span style="color:rgb(112, 48, 160)">P0 executes wait(S)</span> and then <span style="color:rgb(112, 48, 160)">P1 executes wait(Q)</span>. 
- When <span style="color:rgb(112, 48, 160)">P0 executes wait(Q)</span>, it must wait until <span style="color:rgb(112, 48, 160)">P1 executes signal(Q)</span>. 
- Similarly, when <span style="color:rgb(112, 48, 160)">P1 executes wait(S)</span>, it must wait until <span style="color:rgb(112, 48, 160)">P0 executes signal(S)</span>. 
- Since these signal() operations cannot be executed, <span style="color:rgb(112, 48, 160)">P0 and P1 are deadlocked</span>.

---

- Other types of events may result in deadlocks, as we show in more detail in [[Chapter 8 - Deadlocks]] 