#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char* argv[])
{

    int temp = open("tempfile", O_RDWR);
    unlink("tempfile");
    printf("Fisierul temporar a fost sters.\n");
    sleep(15);

    char buffer[256];
    ssize_t bytes_read;
    while ((bytes_read = read(temp, buffer, sizeof(buffer))) > 0) 
    {
        write(1, buffer, bytes_read);
    }

    close(temp);

    return 0;

}