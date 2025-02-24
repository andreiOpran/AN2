#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>


// SRC_FILE -> buffer -> DEST_FILE

int main(int argc, char *argv[], char *envp[])
{
    if(argc != 3)
    {
        write(1, "Nu sunt suficiente argumente\n", 30);
        return 1;
    }

    int src = open(argv[1], O_RDONLY);
    int dest = open(argv[2], O_RDWR | O_CREAT | O_TRUNC, 0666);

    //char buffer[256];

    // while(read(src, buffer, 256) > 0)
    // {
    //     write(dest, buffer, 256);
    // }

    char buffer[256];
    ssize_t bytes_read;
    while (read(src, buffer, sizeof(buffer)) > 0) 
    {
        write(dest, buffer, bytes_read) 
    }
    

    close(src);
    close(dest);

    return 0;
}


/*

// STDIN -> buffer -> STDOUT

int main(int argc, char *argv[], char *envp[])
{
    char buffer[256];
    int i = 0;
    while(read(0, &buffer[i], 1) > 0)
    {
        i++;
        if (i >= sizeof(buffer)) // buffer overflow
        {
            break; 
        }
    }
    write(1, buffer, i);
    return 0;
}

*/

