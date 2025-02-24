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


int varGlobala = 6;

int main(int argc, char* argv[])
{
    int varLocala = 10;

    printf("inainte de fork\n");

    pid_t pid = vfork();

    if(pid < 0)
    {
        printf("eroare la fork\n");
        return 1;
    }
    if(pid == 0) // copil
    {
        varGlobala++;
        varLocala++;
        exit(0);
    }
    if(pid > 0) // parinte
    {
        printf("pid = %d, varGlobala = %d, varLocala = %d\n", pid, varGlobala, varLocala);
    }

    return 0;
}