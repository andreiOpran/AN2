
- Another component involved in the CPU-scheduling function is the <span style="color:rgb(112, 48, 160)">dispatcher</span>. 
- The dispatcher is the module that <span style="color:rgb(112, 48, 160)">gives control of the CPU’s core</span> to the <span style="color:rgb(112, 48, 160)">process</span> <span style="color:rgb(112, 48, 160)">selected by</span> the <span style="color:rgb(112, 48, 160)">CPU scheduler</span>. This function involves the following:
	- Switching context from one process to another
	- Switching to user mode
	- Jumping to the proper location in the user program to resume that program
- The <span style="color:rgb(112, 48, 160)">dispatcher should be as fast as possible</span>, since it is invoked during every <span style="color:rgb(112, 48, 160)">context switch</span>. 
	- The time it takes for the dispatcher to stop one  process and start another running is known as the <span style="color:rgb(112, 48, 160)">dispatch latency</span> and is illustrated in Figure 5.3.
	- ![[Pasted image 20250211201259.png]]