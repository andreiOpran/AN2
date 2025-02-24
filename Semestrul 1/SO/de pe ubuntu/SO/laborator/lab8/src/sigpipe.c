#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <pwd.h>
#include <grp.h>
#include <time.h>
#include <stdbool.h>
#include <sys/wait.h> 
#include <signal.h>

void handler(int sig)
{
    printf("Semnal: %d\n", sig);
}

int main(int argc, char *argv[])
{

    signal(SIGPIPE, handler);

    int fd[2];
    if(pipe(fd) < 0)
    {
        perror("eroare la pipe");
        _exit(1);
    }
    if(!fork()) // copil
    {
        close(fd[0]);
        
        sleep(1);
        exit(0);
    }
    else // parinte
    {
        close(fd[0]);

        sleep(2);
        write(fd[1], "hello world\n", 12);
        wait(NULL);
    }

    return 0;

}