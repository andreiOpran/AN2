
- <span style="color:rgb(112, 48, 160)">Definition: </span> 
	- Parallelism is the simultaneous execution of multiple tasks or sub-tasks on different processors or cores. It involves physically running tasks at the same time, which can significantly speed up computation.

- <span style="color:rgb(112, 48, 160)">Key Points:</span>
	- Tasks are executed literally at the same time on multiple processing units.
	- Requires hardware support, such as multi-core processors or distributed systems.
	- Focuses on dividing a problem into independent parts that can be solved concurrently to enhance performance

---

- <span style="color:rgb(112, 48, 160)">Types</span>:
	- <span style="color:rgb(112, 48, 160)">data parallelism</span>
	- <span style="color:rgb(112, 48, 160)">task parallelism</span> 

- <span style="color:rgb(112, 48, 160)">Data parallelism</span> focuses on distributing subsets of the same data across multiple computing cores and performing the same operation on each core. 
	- Consider, for example, summing the contents of an array of size N. On a single-core system, one thread would simply sum the elements \[0] . . . \[N − 1]. On a dual-core system, however, thread A, running on core 0, could sum the elements \[0] . . . \[N ∕ 2 − 1] while thread B, running on core 1, could sum the elements \[N ∕ 2] . . . \[N − 1]. The two threads would be running in parallel on separate computing cores.
- <span style="color:rgb(112, 48, 160)">Task parallelism</span> involves distributing not data but tasks (threads) across multiple computing cores. Each thread is performing a unique operation. Different threads may be operating on the same data, or they may be operating on different data. 
	- Consider again our example above. In contrast to that situation, an example of task parallelism might involve two threads, each performing a unique statistical operation on the array of elements. The threads again are operating in parallel on separate computing cores, but each is performing a unique operation.


- ![[Pasted image 20250209233807.png]]

- Fundamentally, then, <span style="color:rgb(112, 48, 160)">data parallelism</span> involves the distribution of data across multiple cores, and <span style="color:rgb(112, 48, 160)">task parallelism</span> involves the distribution of tasks across multiple cores, as shown in Figure 4.5. 
	- However, data and task parallelism are not mutually exclusive, and an application may in fact use a hybrid of these two strategies.


---

### [[Multithreading Models]]