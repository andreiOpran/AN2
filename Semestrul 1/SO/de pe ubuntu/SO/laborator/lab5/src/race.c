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

void myprint(char* str)
{
    char c;

    while((c = *str++) != '\0')
    {
        write(1, &c, 1);
    }
}

int main()
{
    pid_t pid = fork();
    if(pid < 0)
    {
        printf("eroare la fork");
        return 1;
    }

    char str[30];
    
    if(pid == 0) // copil
    {
        strcpy(str, "This is the child process\n");
        myprint(str);
        exit(0);
    }
    if(pid > 0) // parinte
    {
        strcpy(str, "This is the parent process\n");
        myprint(str);
        exit(0);
    }
    return 0;
}