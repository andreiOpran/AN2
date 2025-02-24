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
        _exit(1);
    }
    // vfork garanteaza ca ruleaza copilul primul
    if(!vfork()) // copil
    {
        int n;
        char buffer[256];
        close(fd[1]);
        n = read(fd[0], buffer, 256);
        printf("Mesajul citit de copil: %s\n", buffer);
        printf("PID copil: %d\n", getpid());
        exit(0);
    }
    else // parinte
    {
        close(fd[0]);
        write(fd[1], "b", 1);
    }
    return 0;
}   