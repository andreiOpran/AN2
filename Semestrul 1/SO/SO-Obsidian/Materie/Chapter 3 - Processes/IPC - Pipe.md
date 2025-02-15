
- A <span style="color:rgb(112, 48, 160)">pipe</span> acts as a conduit allowing two processes to communicate. Pipes were one of the first IPC mechanisms in early UNIX systems. They typically provide one of the simpler ways for processes to communicate with one another, although they also have some limitations. In implementing a pipe, four issues must be considered:
	1. Does the pipe allow <span style="color:rgb(112, 48, 160)">bidirectional</span> communication, or is communication <span style="color:rgb(112, 48, 160)">unidirectional</span>?
	2. If two-way communication is allowed, is it <span style="color:rgb(112, 48, 160)">half duplex</span> (data can travel only one way at a time) or <span style="color:rgb(112, 48, 160)">full duplex</span> (data can travel in both directions at the same time)?
	3. Must a relationship (such as parent–child) exist between the communicating processes?
	4. Can the pipes <span style="color:rgb(112, 48, 160)">communicate over a networ</span><span style="color:rgb(112, 48, 160)">k</span>, or must the communicating processes reside on the same machine?

---

## <span style="color:rgb(112, 48, 160)">Ordinary pipes</span>

- <span style="color:rgb(112, 48, 160)">Ordinary pipes</span> allow two processes to communicate in standard producer–consumer fashion: the <span style="color:rgb(112, 48, 160)">producer</span> writes to one end of the pipe (the <span style="color:rgb(112, 48, 160)">write end</span>) and the <span style="color:rgb(112, 48, 160)">consume</span><span style="color:rgb(112, 48, 160)">r</span> reads from the other end (the <span style="color:rgb(112, 48, 160)">read end</span>). 
- As a result, ordinary pipes are <span style="color:rgb(112, 48, 160)">unidirectional</span>, allowing only one-way communication. 
- If two-way communication is required, two pipes must be used, with each pipe sending data in a different direction.

###### fd\[0] is the <span style="color:rgb(112, 48, 160)">read end</span> of the pipe, and fd\[1] is the<span style="color:rgb(112, 48, 160)"> write end</span>
 ![[Pasted image 20250209210809.png]]


```C
#include <sys/types.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#define BUFFER SIZE 25
#define READ END 0
#define WRITE END 1
int main(void)
{
	char write msg[BUFFER SIZE] = "Greetings";
	char read msg[BUFFER SIZE];
	int fd[2];
	pid t pid;
	
	/* create the pipe */
	if (pipe(fd) == -1) {
		fprintf(stderr,"Pipe failed");
		return 1;
	}
	
	/* fork a child process */
	pid = fork();
	
	if (pid < 0) { /* error occurred */
		fprintf(stderr, "Fork Failed");
		return 1;
	}
	
	if (pid > 0) { /* parent process */
		/* close the unused end of the pipe */
		close(fd[READ END]);
		/* write to the pipe */
		write(fd[WRITE END], write msg, strlen(write msg)+1);
		/* close the write end of the pipe */
		close(fd[WRITE END]);
	}
	else { /* child process */
		/* close the unused end of the pipe */
		close(fd[WRITE END]);
		/* read from the pipe */
		read(fd[READ END], read msg, BUFFER SIZE);
		printf("read %s",read msg);
		/* close the read end of the pipe */
		close(fd[READ END]);
	}
	return 0;
}
```


--- 

## <span style="color:rgb(112, 48, 160)">Named pipes</span>

- Ordinary pipes provide a simple mechanism for allowing a pair of processes to communicate. However, ordinary pipes exist only while the processes are communicating with one another. On both UNIX and Windows systems, once the processes have finished communicating and have terminated, the ordinary pipe ceases to exist.
- <span style="color:rgb(112, 48, 160)">Named pipes</span> provide a much more powerful communication tool. Communication can be <span style="color:rgb(112, 48, 160)">bidirectional</span>, and <span style="color:rgb(112, 48, 160)">no parent–child</span> <span style="color:rgb(112, 48, 160)">relationship</span> is required.
- Once a named pipe is established, several processes can use it for communication. In fact, in a typical scenario, a named pipe has <span style="color:rgb(112, 48, 160)">several writers</span>. 
- Additionally, named pipes <span style="color:rgb(112, 48, 160)">continue to exist</span> after communicating processes have finished.
- Named pipes are referred to as <span style="color:rgb(112, 48, 160)">FIFOs</span> in UNIX systems. 
- Once created, they appear as typical files in the file system. A FIFO is created with the mkfifo() system call and manipulated with the ordinary open(), read(), write(), and close() system calls. It will <span style="color:rgb(112, 48, 160)">continue to exist until it is explicitly deleted</span>.
- Although <span style="color:rgb(112, 48, 160)">FIFOs allow bidirectional communication</span>, <span style="color:rgb(112, 48, 160)">only half-duplex transmission is permitted</span>. If data must travel in both directions, two FIFOs are typically used. 
- Additionally, the communicating processes must reside on the same machine. If intermachine communication is required, [[Sockets]] must be used.