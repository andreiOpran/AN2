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
    if(!fork()) // copil
    {
        close(fd[1]);
        
        char buffer[256];
        read(fd[0], buffer, 256);
        printf("Mesajul primti de copil este: %s\n", buffer);

    }
    else // parinte
    {
        close(fd[0]);

        char mesaj[] = "hello world";
        write(fd[1], mesaj, sizeof(mesaj));
        wait(NULL);
    }


}