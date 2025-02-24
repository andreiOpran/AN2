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
    getpwnam("nobody");
}

int main(int argc, char *argv[])
{
    signal(SIGALRM, handler);
    alarm(1);

    while(1)
    {
        
        if(argc != 2)
        {
            printf("Usage: %s username\n", argv[0]);
            return 1;
        }

        struct passwd *pwd;
        pwd = getpwnam(argv[1]);

        if(pwd == NULL)
        {
            printf("No such user: %s\n", argv[1]);
            return 1;
        }

        printf("UID: %d\n", pwd->pw_uid);
       
    }

    return 0;
}