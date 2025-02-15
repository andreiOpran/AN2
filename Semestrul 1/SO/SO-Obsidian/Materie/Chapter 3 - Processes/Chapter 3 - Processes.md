
- [[Process State]] =  the current activity of the process
- [[PCB]] = process control block 
- [[Context switch]]
- [[When a process creates a new process]]
- [[Process termination]] = a parent may terminate the execution of one of its children
- [[Zombie versus Orphan]]
- [[IPC]] = Interprocess Communication

--- 
### <span style="color:rgb(112, 48, 160)">Summary:</span> 

A process is a program in execution, and the status of the current activity of a process is represented by the program counter, as well as other registers.

- The <span style="color:rgb(112, 48, 160)">layout of a process in memory</span> is represented by four different sections: (1) text, (2) data, (3) heap, and (4) stack.
- As a process executes, it changes process state. There are four general [[Process State|states of a process]]: (1) ready, (2) running, (3) waiting, and (4) terminated.
- A [[PCB|process control block (PCB)]] is the kernel data structure that represents a process in an operating system.
- The role of the <span style="color:rgb(112, 48, 160)">process scheduler</span> is to select an available process to run on a CPU.
- An operating system performs a [[Context switch]] when it switches from running one process to running another.
- The <span style="color:rgb(112, 48, 160)">fork() and CreateProcess()</span> <span style="color:rgb(112, 48, 160)">system calls</span> are used to create processes on UNIX and Windows systems, respectively.
- When [[IPC - Shared-Memory|shared memory]] is used for communication between processes, two (or more) processes share the same region of memory. POSIX provides an API for shared memory.
- Two processes may communicate by exchanging messages with one another using [[IPC - Message-Passing|message passing]]. The Mach operating system uses message passing as its primary form of interprocess communication. Windows provides a form of message passing as well.
- A [[IPC - Pipe]] provides a conduit for two processes to communicate. There are two forms of pipes, <span style="color:rgb(112, 48, 160)">ordinary</span> and <span style="color:rgb(112, 48, 160)">named</span>. Ordinary pipes are designed for communication between processes that have a parent–child relationship. Named pipes are more general and allow several processes to communicate.
- UNIX systems provide <span style="color:rgb(112, 48, 160)">ordinary pipes</span> through the <span style="color:rgb(112, 48, 160)">pipe() system call</span>. Ordinary pipes have a read end and a write end. A parent process can, for example, send data to the pipe using its write end, and the child process can read it from its read end. <span style="color:rgb(112, 48, 160)">Named pipes</span> in UNIX are termed FIFOs.
- Two common forms of <span style="color:rgb(112, 48, 160)">client–server communication</span> are [[Sockets|sockets]] and [[Remote procedure calls|remote procedure calls (RPCs)]]. Sockets allow two processes on different machines to communicate over a network.
- [[Remote procedure calls |RPCs]] abstract the concept of function (procedure) calls in such a way that a function can be invoked on another process that may reside on a separate computer.

---

![[Pasted image 20250211214835.png]]
![[Pasted image 20250211214847.png]]
![[Pasted image 20250211214859.png]]
![[Pasted image 20250211214914.png]]