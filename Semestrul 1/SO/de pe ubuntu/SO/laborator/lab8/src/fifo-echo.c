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

int main(int argc, char* argv[]) // ping
{
    int fifo = open("myfifo", O_RDWR);

    if(fifo < 0)
    {
        perror("Eroare la deschiderea FIFO");
        return 1;
    }


    
    char buffer[256];
    ssize_t bytes_read = read(0, buffer, sizeof(buffer));
    buffer[bytes_read] = '\0';

    write(fifo, buffer, bytes_read);
    
    int n;
    n = read(fifo, buffer, sizeof(buffer));


    char output_buffer[512];
    snprintf(output_buffer, sizeof(output_buffer), "Citit din fifo de catre fifo-echo.c: %s", buffer);

    write(1, output_buffer, strlen(output_buffer));

    // write(1, buffer, n);

    close(fifo);
    return 0;
}

// fifo-echo ia mesajul de la tastatura si il scrie in fifo
// fifo-echod citeste mesajul din fifo si il scrie inapoi in fifo
// fifo-echo citeste mesajul din fifo si il afiseaza pe ecran


/*

andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ gcc -o ../bin/fifo-echod fifo-echod.c
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ gcc -o ../bin/fifo-echo fifo-echo.c
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ fifo-echod
^Z
[1]+  Stopped                 fifo-echod
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ bg
[1]+ fifo-echod &
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ fifo-echo
ceva
Citit din fifo de catre fifo-echo.c: ceva
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ kill %1
[1]+  Terminated              fifo-echod
andrei@andrei-ubuntu:~/SO/laborator/lab8/src$ 


*/