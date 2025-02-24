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

int main(int argc, char* argv[]) // pong
{
    int fifo = open("myfifo", O_RDWR);

    if(fifo < 0) {
        perror("Eroare la deschiderea FIFO");
        return 1;
    }

    while (1)
    {
        char buffer[256];
        ssize_t bytes_read = read(fifo, buffer, sizeof(buffer));
        if (bytes_read < 0)
        {
            perror("Eroare la citirea din FIFO");
            return 1;
        }
        buffer[bytes_read] = '\0';
        write(fifo, buffer, bytes_read);
    }

    close(fifo);
    return 0;
}

/*

andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ gcc -o ../bin/fifo-echod fifo-echod.c
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ gcc -o ../bin/fifo-echo fifo-echo.c
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ fifo-echod
^Z
[1]+  Stopped                 fifo-echod
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ bg
[1]+ fifo-echod &
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ fifo-echo
tae
tae
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$

*/