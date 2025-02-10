
- A scheduling challenge arises when a higher-priority process needs to read or modify kernel data that are currently being accessed by a lower-priority process—or a chain of lower-priority processes. 
- Since kernel data are typically protected with a lock, the higher-priority process will have to wait for a lower-priority one to finish with the resource. The situation becomes more complicated if the lower-priority process is preempted in favor of another process with a higher priority.

- As an example, assume we have three processes—L, M, and H—whose priorities follow the order L < M < H. 
- Assume that process H requires a semaphore S, which is currently being accessed by process L. 
- Ordinarily, process H would wait for L to finish using resource S. However, now suppose that process M becomes runnable, thereby preempting process L. 
- Indirectly, a process with a lower priority—process M—has affected how long process H must wait for L to relinquish resource S. 

- This liveness problem is known as <span style="color:rgb(112, 48, 160)">priority inversion</span>, and it can occur only in systems with more than two priorities. 
- Typically, priority inversion is avoided by implementing a <span style="color:rgb(112, 48, 160)">priority-inheritance protocol</span>. 
- According to this protocol, all processes that are accessing resources needed by a higher-priority process inherit the higher priority until they are finished with the resources in question. When they are finished, their priorities revert to their original values. 
	- In the example above, a priority-inheritance protocol would allow process L to temporarily inherit the priority of process H, thereby preventing process M from preempting its execution. 
	- When process L had finished using resource S, it would relinquish its inherited priority from H and assume its original priority. Because resource S would now be available, process H—not M—would run next.