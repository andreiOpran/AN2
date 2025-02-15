
- In [[IPC - Shared-Memory]], we showed how cooperating processes can communicate in a shared-memory environment. The scheme requires that these processes share a region of memory and that the code for accessing and manipulating the shared memory be written explicitly by the application programmer. Another way to achieve the same effect is for the <span style="color:rgb(112, 48, 160)">operating system to provide the means for cooperating processes</span> to communicate with each other via a <span style="color:rgb(112, 48, 160)">message-passing facility</span>.

##### <span style="color:rgb(112, 48, 160)">The consumer process using shared memory.</span>
```C
item next consumed;
while (true) {
	while (in == out)
	; /* do nothing */
	next consumed = buffer[out];
	out = (out + 1) % BUFFER SIZE;
	/* consume the item in next consumed */
}
```

- <span style="color:rgb(112, 48, 160)">Message passing </span>provides a mechanism to allow processes to communicate and to synchronize their actions <span style="color:rgb(112, 48, 160)">without sharing the same address space</span>. It is particularly useful in a distributed environment, where the communicating processes may reside on different computers connected by a network. 
- For example, an Internet chat program could be designed so that chat participants communicate with one another by exchanging messages.
- A message-passing facility provides at least two operations:
	1. send(message)
	2. receive(message)


---

## <span style="color:rgb(112, 48, 160)">Syncronization</span> 

 - Communication between processes takes place through calls to *send()* and *receive()* primitives. There are different design options for implementing each primitive. Message passing may be either <span style="color:rgb(112, 48, 160)">blocking</span> or <span style="color:rgb(112, 48, 160)">nonblocking</span>—also known as <span style="color:rgb(112, 48, 160)">synchronous</span> and <span style="color:rgb(112, 48, 160)">asynchronous</span>. 
	 - <span style="color:rgb(112, 48, 160)">Blocking send.</span> The sending process is blocked until the message is received by the receiving process or by the mailbox.
	 - <span style="color:rgb(112, 48, 160)">Nonblocking send.</span> The sending process sends the message and resumes operation.
	 - <span style="color:rgb(112, 48, 160)">Blocking receive.</span> The receiver blocks until a message is available.
	 - <span style="color:rgb(112, 48, 160)">Nonblocking receive.</span> The receiver retrieves either a valid message or a null.


- Different combinations of send() and receive() are possible. When both send() and receive() are blocking, we have a <span style="color:rgb(112, 48, 160)">rendezvous</span> between the sender and the receiver. 
- The solution to the [[Producer–consumer Problem]] becomes trivial when we use blocking send() and receive() statements. The producer merely invokes the blocking send() call and waits until the message is delivered to either the receiver or the mailbox. Likewise, when the consumer invokes receive(), it blocks until a message is available. This is illustrated in below:

##### <span style="color:rgb(112, 48, 160)">The producer process using message passing.</span>
```C
message next_produced;
while (true) {
	/* produce an item in next produced */
	send(next_produced);
}
```

##### <span style="color:rgb(112, 48, 160)">The consumer process using message passing.</span>
```C
message next_consumed;
while (true) {
	receive(next_consumed);
	/* consume the item in next consumed */
}
```