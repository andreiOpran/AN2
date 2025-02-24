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


int main(int argc, char *argv[])
{

    int fd[2];

    if(pipe(fd) < 0)
    {
        perror("eroare la pipe");
        exit(1);
    }
    if(!fork()) // copil 1
    {
        close(fd[0]);
        dup2(fd[1], STDOUT_FILENO);
        
        execlp("ls", "ls", "-l", NULL);
        exit(1);
    }
    if(!fork()) // copil 2
    {
        close(fd[1]);
        dup2(fd[0], STDIN_FILENO);
       
        execlp("less", "less", NULL);
        exit(1);
    }
    else // parinte
    {
        close(fd[0]);
        close(fd[1]);

        while(wait(NULL) > 0)
            ;
    }
    return 0;
}