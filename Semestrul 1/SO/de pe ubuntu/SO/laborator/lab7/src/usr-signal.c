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
    printf("Semnal: %d\n", sig);
}

int main(int argc, char *argv[]) 
{
    if((old_handler = signal(SIGUSR1, handler)) == SIG_ERR)
        exit(1);

    if((old_handler = signal(SIGUSR2, handler)) == SIG_ERR)
        exit(1);

    while(1)
        pause();

    return 0;
}
