
- A <span style="color:rgb(112, 48, 160)">thread library</span> provides the programmer with an API for creating and managing threads. There are two primary ways of implementing a thread library. 
	- The first approach is to provide a library entirely in user space with no kernel support. All code and data structures for the library exist in user space. This means that invoking a function in the library results in a local function call in user space and not a system call. 
	- The second approach is to implement a kernel-level library supported directly by the operating system. In this case, code and data structures for the library exist in kernel space. Invoking a function in the API for the library typically results in a system call to the kernel.
- <span style="color:rgb(112, 48, 160)">Three main thread libraries</span> are in use today: POSIX Pthreads, Windows, and Java. Pthreads.
	- The threads extension of the POSIX standard, may be provided as either a user-level or a kernel-level library. 
	- The Windows thread library is a kernel-level library available on Windows systems.
	- The Java thread API allows threads to be created and managed directly in Java programs.