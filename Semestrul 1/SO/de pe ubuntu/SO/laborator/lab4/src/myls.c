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

void PrintFileInfo(char *path, struct dirent *entry) {
    struct stat file_stat;
    char full_path[1024];

    snprintf(full_path, sizeof(full_path), "%s/%s", path, entry->d_name);

    if (lstat(full_path, &file_stat) < 0) {
        perror("lstat");
        return;
    }


    // Print file type and permissions
    printf((S_ISDIR(file_stat.st_mode)) ? "d" : "-");
    printf((file_stat.st_mode & S_IRUSR) ? "r" : "-");
    printf((file_stat.st_mode & S_IWUSR) ? "w" : "-");
    printf((file_stat.st_mode & S_IXUSR) ? "x" : "-");
    printf((file_stat.st_mode & S_IRGRP) ? "r" : "-");
    printf((file_stat.st_mode & S_IWGRP) ? "w" : "-");
    printf((file_stat.st_mode & S_IXGRP) ? "x" : "-");
    printf((file_stat.st_mode & S_IROTH) ? "r" : "-");
    printf((file_stat.st_mode & S_IWOTH) ? "w" : "-");
    printf((file_stat.st_mode & S_IXOTH) ? "x" : "-");

    // Print number of links
    printf(" %lu", file_stat.st_nlink);

    // Print owner and group
    struct passwd *pw = getpwuid(file_stat.st_uid);
    struct group *gr = getgrgid(file_stat.st_gid);
    printf(" %s %s", pw->pw_name, gr->gr_name);

    // Print file size
    printf(" %5ld", file_stat.st_size);

    // Print last modification time
    char timebuf[80];
    struct tm *tm_info = localtime(&file_stat.st_mtime);
    strftime(timebuf, sizeof(timebuf), "%b %d %H:%M", tm_info);
    printf(" %s", timebuf);

    // Print file name
    printf(" %s\n", entry->d_name);
}

int main(int argc, char* argv[])
{
    // determinare aparitie "-l"
    bool longFormat = false;
    char *path = NULL;

    if(argc == 3 && strcmp(argv[1], "-l") == 0)
    {
        longFormat = true;
        path = argv[2];
    }
    else
    {
        path = argv[1];
    }


    DIR *dir;
    struct dirent *entry;
    dir = opendir(path);

    if(dir == NULL)
    {
        printf("Eroare la deschiderea directorului %s\n", argv[1]);
        return 1;
    }

    while((entry = readdir(dir)) != NULL)
    {
       if(longFormat)
       {
            PrintFileInfo(path, entry);
       }
       else
       {
            printf("%s\n", entry->d_name);
       }
    }

    closedir(dir);
    return 0;
}