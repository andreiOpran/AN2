#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char* argv[])
{
    int src;
    char buffer[256];
    ssize_t read_bytes;
    off_t size = 0;

    src = open(argv[1], O_RDWR);

    while((read_bytes = read(src, buffer, sizeof(buffer))) > 0)
    {
        for(ssize_t i = 0; i < read_bytes; i++)
        {
            if(buffer[i] != 0)
            {
                size++;
            } 
        }
    }

    printf("Fisierul are %ld octeti.\n", size);
    return 0;
}