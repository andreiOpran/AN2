- each process in the OS is represented by a <span style="color:rgb(112, 48, 160)">PCB</span>
- it contains the following information:<span style="color:rgb(57, 9, 93)"></span>
	- <span style="color:rgb(112, 48, 160)">Process</span> <span style="color:rgb(112, 48, 160)">state</span> = The state may be new, ready, running, waiting, halted, and so on.
	- <span style="color:rgb(112, 48, 160)">Program</span> <span style="color:rgb(112, 48, 160)">counter</span> = The counter indicates the address of the next instruction to be executed for this process.
	- <span style="color:rgb(112, 48, 160)">CPU</span> <span style="color:rgb(112, 48, 160)">registers</span> = The registers vary in number and type, depending on the computer architecture. Along with the program counter, this state information must be saved when an interrupt occurs, to allow the process to be continued correctly afterward when it is rescheduled to run.
	- <span style="color:rgb(112, 48, 160)">CPU-scheduling information</span> = This information includes a process priority, pointers to scheduling queues, and any other scheduling parameters.
	- <span style="color:rgb(112, 48, 160)">Memory-management information</span> = This information may include such items as the value of the base and limit registers and the page tables, or the segment tables, depending on the memory system used by the operating system.
	- <span style="color:rgb(112, 48, 160)">Accounting information</span> = This information includes the amount of CPU and real time used, time limits, account numbers, job or process numbers.
	- <span style="color:rgb(112, 48, 160)">I/O status information</span> = This information includes the list of I/O devices allocated to the process, a list of open files.

![[Pasted image 20250209165617.png]]