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


int main(int argc, char* argv[])
{
    if(argc != 2)
    {
        return 1;
    }

    if (chdir(argv[1]) != 0) {
        printf("Eroare la schimbarea directorului.\n");
        return 1;
    }

    char cwd[1024];
    getcwd(cwd, sizeof(cwd));
    printf("Director curent: %s\n", cwd);

    return 0;
}