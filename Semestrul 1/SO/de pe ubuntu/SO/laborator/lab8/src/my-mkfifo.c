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

    if(argc < 2)
    {
        perror("lipsa argument");
        exit(1);
    }
    
    const char *nume = argv[1];

    if (mkfifo(nume, 0666) == -1)
    {
        perror("eroare la crearea FIFO");
        exit(1);
    }

    printf("FIFO-ul cu numele '%s' a fost creat cu succes.\n", nume);

    return 0;
}

/*

andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ my-mkfifo test1
FIFO-ul cu numele 'test1' a fost creat cu succes.

andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ ls -l test1
prw-rw-r-- 1 andrei andrei 0 Nov 28 11:46 test1

*/