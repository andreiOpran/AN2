
- [[Peterson's Solution (Critical section)]], may not work because the system may reorder instructions, a policy that can lead to unreliable data states.
- How a computer architecture determines what memory guarantees it will provide to an application program is known as its <span style="color:rgb(112, 48, 160)">memory</span> <span style="color:rgb(112, 48, 160)">model</span>. 
- In general, a memory model falls into one of two categories:
	1. <span style="color:rgb(112, 48, 160)">Strongly ordered</span>, where a memory modification on one processor is immediately visible to all other processors.
	2. <span style="color:rgb(112, 48, 160)">Weakly ordered</span>, where modifications to memory on one processor may not be immediately visible to other processors.

- <span style="color:rgb(112, 48, 160)">Memory models</span> vary by processor type, so kernel developers cannot make any assumptions regarding the visibility of modifications to memory on a shared-memory multiprocessor. 
- To address this issue, computer architectures provide instructions that can <span style="color:rgb(112, 48, 160)">force any changes</span> in memory to be propagated to all other processors, thereby ensuring that memory modifications are visible to threads running on other processors.
- Such instructions are known as <span style="color:rgb(112, 48, 160)">memory barriers</span> or <span style="color:rgb(112, 48, 160)">memory fences</span>. 
- When a <span style="color:rgb(112, 48, 160)">memory barrier</span> instruction is performed, the system ensures that all loads and stores are completed before any subsequent load or store operations are performed. Therefore, even if instructions were reordered, the memory barrier ensures that the store operations are completed in memory and visible to other processors before future load or store operations are performed.

--- 

- We return to the example where [[Peterson's Solution (Critical section)]] did not work as expected.
- We add a <span style="color:rgb(112, 48, 160)">memory barrier</span> operation on Thread 1 and Thread 2.
	- ![[Pasted image 20250210160440.png]]
	- ![[Pasted image 20250210160640.png]]