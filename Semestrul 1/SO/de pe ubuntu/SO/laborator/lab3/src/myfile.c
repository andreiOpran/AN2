#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char* argv[])
{
    struct stat file_stat;
    lstat(argv[1], &file_stat);    

    /*
    
    if (S_ISREG(statbuf.st_mode)) 
    {
        printf("Fisier obisnuit.\n");
    } 
    else 
    if (S_ISDIR(statbuf.st_mode)) 
    {
        printf("dDirector.\n");
    } 
    else 
    if (S_ISLNK(statbuf.st_mode)) 
    {
        printf("Link simbolic\n");
    }
    else 
    {
        printf("Tip necunoscut\n");
    }
    
    */

    switch(file_stat.st_mode & S_IFMT)
    {
        case S_IFREG:
            printf("Fisier obisnuit.\n");
            break;
        case S_IFDIR:
            printf("Director.\n");
            break;
        case S_IFLNK:
            printf("Link simbolic.\n");
            break;
        case S_IFIFO:
            printf("FIFO.\n");
            break;
        case S_IFSOCK:
            printf("Socket.\n");
            break;
        case S_IFCHR:
            printf("Caracter special.\n");
            break;
        case S_IFBLK:
            printf("Bloc special.\n");
            break;
        default:
            printf("Tip necunoscut.\n");
            break;
    }

    return 0;
}