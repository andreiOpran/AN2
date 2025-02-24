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

// execvp

int main(int argc, char* argv[])
{

    char* comanda = argv[1];

    pid_t pid = vfork();

    if(pid < 0)
    {
        printf("eroare la fork\n");
        return 1;
    }
    if(pid == 0) // copil
    {
        //execvp(comanda, argv + 1);
        execvp(argv[1], &argv[1]);
        exit(0);
    }
    if(pid > 0) // parinte
    {
       wait(NULL);
    }

    return 0;
}
