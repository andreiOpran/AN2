
![[Pasted image 20250209185557.png]]

- [[IPC - Shared-Memory]]
- [[IPC - Message-Passing]]
- [[IPC - Pipe]]

--- 

- Processes executing concurrently in the operating system may be either independent processes or cooperating processes. 
- A process is <span style="color:rgb(112, 48, 160)">independent</span> if it does not share data with any other processes executing in the system. 
- A process is <span style="color:rgb(112, 48, 160)">cooperating</span> if it can affect or be affected by the other processes executing in the system. Clearly, any process that shares data with other processes is a cooperating process.
- Cooperating processes<span style="color:rgb(112, 48, 160)"> require an interprocess communication</span>.

---

<span style="color:rgb(112, 48, 160)">IPC reasons why:</span>

- <span style="color:rgb(112, 48, 160)">Information sharing.</span> Since several applications may be interested in the same piece of information (for instance, copying and pasting), we must provide an environment to allow concurrent access to such information.
- <span style="color:rgb(112, 48, 160)">Computation speedup.</span> If we want a particular task to run faster, we must break it into subtasks, each of which will be executing in parallel with the others. Notice that such a speedup can be achieved only if the computer has multiple processing cores.
- <span style="color:rgb(112, 48, 160)">Modularity</span><span style="color:rgb(112, 48, 160)">.</span> We may want to construct the system in a modular fashion, dividing the system functions into separate processes or threads.