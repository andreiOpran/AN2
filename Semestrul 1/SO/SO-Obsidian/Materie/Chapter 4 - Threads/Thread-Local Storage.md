
- Threads belonging to a process share the data of the process. Indeed, this data sharing provides one of the benefits of multithreaded programming. 
- However, in some circumstances, each thread might need its own copy of certain data. We will call such data <span style="color:rgb(112, 48, 160)">thread-local storage</span> (or <span style="color:rgb(112, 48, 160)">TLS</span>). 
- For example, in a transaction-processing system, we might service each transaction in a separate thread. Furthermore, each transaction might be assigned a unique identifier. To associate each thread with its unique transaction identifier, we could use <span style="color:rgb(112, 48, 160)">thread-local storage</span>.

- It is easy to confuse <span style="color:rgb(112, 48, 160)">TLS</span> with <span style="color:rgb(112, 48, 160)">local variables</span>. 
- However, local variables are visible only during a single function invocation, whereas TLS data are visible across function invocations. 
- Additionally, when the developer has no control over the thread creation process—for example, when using an implicit technique such as a thread pool—then an alternative approach is necessary.