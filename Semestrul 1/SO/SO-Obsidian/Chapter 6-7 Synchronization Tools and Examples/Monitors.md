
- An <span style="color:rgb(112, 48, 160)">abstract data type</span>—or <span style="color:rgb(112, 48, 160)">ADT</span>—encapsulates data with a set of functions to operate on that data that are independent of any specific implementation of the ADT. 
- A <span style="color:rgb(112, 48, 160)">monitor type</span> is an ADT that includes a set of programmer-defined operations that are provided with <span style="color:rgb(112, 48, 160)">mutual exclusion </span>within the monitor. The monitor type also declares the variables whose values define the state of an instance of that type, along with the bodies of functions that operate on those variables. 
- The syntax of a monitor type is shown in Figure 6.11. 
- ![[Pasted image 20250211000304.png]]
- The representation of a <span style="color:rgb(112, 48, 160)">monitor type</span> cannot be used directly by the various processes. Thus, a function defined within a monitor can access only those <span style="color:rgb(112, 48, 160)">variables declared locally</span> within the monitor and its formal parameters. 
- Similarly, the local variables of a monitor can be accessed by only the local functions.

- The monitor construct ensures that <span style="color:rgb(112, 48, 160)">only one process at a time is active within the monitor</span>. 
- Consequently, the programmer does not need to code this synchronization constraint explicitly (Figure 6.12). 
- ![[Pasted image 20250211000442.png]]
- <span style="color:rgb(112, 48, 160)">However</span>, the monitor construct, as defined so far, is not sufficiently powerful for modeling some synchronization schemes. For this purpose, we need to define additional synchronization mechanisms. These mechanisms are provided by the condition construct.
- A programmer who needs to write a tailor-made synchronization scheme can define one or more variables of type <span style="color:rgb(112, 48, 160)">condition</span>: `condition x, y;`
- The only operations that can be invoked on a condition variable are `wait()` and `signal()`. 
- The operation `x.wait();` means that the process invoking this operation is suspended until another process invokes `x.signal();`
- The `x.signal()` operation <span style="color:rgb(112, 48, 160)">resumes exactly one suspended process</span>. If no process is suspended, then the `signal()` operation has no effect; that is, the state of x is the same as if the operation had never been executed (Figure 6.13). 
- ![[Pasted image 20250211001057.png]]
- Contrast this operation with the `signal()` operation associated with <span style="color:rgb(112, 48, 160)">semaphores</span>, which always affects the state of the semaphore.

- Now suppose that, when the `x.signal() `operation is invoked by a process P, there exists a suspended process Q associated with condition x. Clearly, if the suspended process Q is allowed to resume its execution, the signaling process P must wait. Otherwise, both P and Q would be active simultaneously within the monitor. 
- <span style="color:rgb(112, 48, 160)">Note</span>, however, that conceptually both processes can continue with their execution. Two possibilities exist:
	 1. <span style="color:rgb(112, 48, 160)">Signal and wait.</span> P either waits until Q leaves the monitor or waits for another condition.
	 2. <span style="color:rgb(112, 48, 160)">Signal and continue. </span>Q either waits until P leaves the monitor or waits for another condition.