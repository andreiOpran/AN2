#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char* argv[])
{

    int src = open(argv[1], O_RDONLY);
    int dest = open(argv[2], O_RDWR | O_CREAT | O_TRUNC, 0666);

    char buffer[256];
    ssize_t bytes_read;

    dup2(src, 0);
    dup2(dest, 1);

    while ((bytes_read = read(0, buffer, sizeof(buffer))) > 0) 
    {
        write(1, buffer, bytes_read);
    }
    


    close(src);
    close(dest);

    return 0;

}