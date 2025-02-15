
- When <span style="color:rgb(112, 48, 160)">a process creates a new process</span>, two possibilities for execution exist:
	1. The parent continues to execute concurrently with its children.
	2. The parent waits until some or all of its children have terminated.

- There are also two address-space possibilities for the new process:
	1. The child process is a duplicate of the parent process (it has the same program and data as the parent).
	2. The child process has a new program loaded into it.


```C
#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>
int main()
{
	pid t pid;
	/* fork a child process */
	pid = fork();
	if (pid < 0) { /* error occurred */
		fprintf(stderr, "Fork Failed");
		return 1;
	}
	else if (pid == 0) { /* child process */
		execlp("/bin/ls","ls",NULL);
	}
	else { /* parent process */
		/* parent will wait for the child to complete */
		wait(NULL);
		printf("Child Complete");
	}
	return 0;
}
```