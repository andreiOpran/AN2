
- the task of switching the CPU core to another process requires performing a state save of the current process and a state restore to a different process is known as a <span style="color:rgb(112, 48, 160)">context switch</span>.
- ![[Pasted image 20250209171657.png]]
- the [[Kernel]] saves the context of the old process in its PCB and loads the saved context of the new process scheduled to run

 