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

void (*old_handler)(int);

void handler(int sig) 
{
    int status;
    printf("Semnal: %d\n", sig);
    waitpid(-1, &status, WNOHANG);
}


int main(int argc, char *argv[]) 
{
    pid_t pid;
    
    signal(SIGCHLD, handler);
    
    pid = fork();

    // eroare
    if(pid < 0)
    {
        perror("eroare la fork");
        exit(1);
    }
    // copil
    if(pid == 0)
    {
        printf("PID-ul parinte: %d\n", getppid());
        printf("PID-ul copil: %d\n", getpid());
        _exit(44); 
    }
    // parinte
    if(pid > 0)
    {
        getchar();
    }



    return 0;
}
