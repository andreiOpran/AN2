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
    return;
}

unsigned int mysleep(unsigned int secunde)
{
    alarm(secunde);
    pause();
    return alarm(0);
}

int main(int argc, char *argv[])
{

    signal(SIGINT, handler);
    unsigned int timp = mysleep(60);
    printf("\nTimp ramas: %d\n", timp);
    return 0;

}