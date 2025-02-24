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
char *buf = "unbuffered write to stdout\n";

int main(int argc, char* argv[])
{
    int varLocala = 10;

    write(1, buf, strlen(buf));
    printf("inainte de fork\n");

    // buffer-ul se partajeaza intre procesul parinte si copil
    fflush(stdout); // golire buffer

    pid_t pid = fork();

    if(pid < 0)
    {
        printf("eroare la fork\n");
        return 1;
    }
    if(pid == 0) // copil
    {
        varGlobala++;
        varLocala++;
    }
    if(pid > 0) // parinte
    {
        sleep(2);
    }
    
    printf("pid = %d, varGlobala = %d, varLocala = %d\n", pid, varGlobala, varLocala);

    return 0;
}