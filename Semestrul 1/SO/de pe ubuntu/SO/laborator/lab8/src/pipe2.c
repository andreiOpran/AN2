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
        // close(fd[1]);


        char buffer[256];
        
        int n;
        n = read(fd[0], buffer, 256);
        write(fd[1], "done\n", 5);

        printf("Mesajul primit de copil este: ");
        write(1, buffer, n);
        exit(0);

    }
    else // parinte
    {
        // close(fd[0]);

        char mesaj[] = "hello world", buffer[256];
        
        int n;
        write(fd[1], mesaj, sizeof(mesaj));
        n = read(fd[0], buffer, 256);
        
        printf("Mesajul primit de parinte este: ");
        write(1, buffer, n);
        
        wait(NULL);
    
    }

    return 0;
}