
- Every process in a set of processes is waiting for an event that can be caused only by another process in the set
- [[Deadlock (Chapter 6-7)]]
- [[Livelock]]
- [[Deadlocks - Necessary Conditions]]
- [[Deadlocks - Handling]]
- [[Deadlocks - Prevention]]
- ![[Pasted image 20250211181255.png]]

--- 

### <span style="color:rgb(112, 48, 160)">Summary:</span> 

- Deadlock occurs in a set of processes when every process in the set is waiting for an event that can only be caused by another process in the set.
- There are four necessary conditions for deadlock: (1) mutual exclusion, (2) hold and wait, (3) no preemption, and (4) circular wait. Deadlock is only possible when all four conditions are present.
- Deadlocks can be modeled with resource-allocation graphs, where a cycle indicates deadlock.
- Deadlocks can be prevented by ensuring that one of the four necessary conditions for deadlock cannot occur. Of the four necessary conditions, eliminating the circular wait is the only practical approach.
- Deadlock can be avoided by using the banker’s algorithm, which does not grant resources if doing so would lead the system into an unsafe state where deadlock would be possible.
- A deadlock-detection algorithm can evaluate processes and resources on a running system to determine if a set of processes is in a deadlocked state.
- If deadlock does occur, a system can attempt to recover from the deadlock by either aborting one of the processes in the circular wait or preempting resources that have been assigned to a deadlocked process.

--- 

### <span style="color:rgb(112, 48, 160)">Practice exercises:</span> 

![[Pasted image 20250211183415.png]]
![[Pasted image 20250211183429.png]]
![[Pasted image 20250211183442.png]]
![[Pasted image 20250211183523.png]]
![[Pasted image 20250211183503.png]]