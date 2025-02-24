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
    int fifo = open("myfifo", O_RDWR);

    if(fifo < 0) {
        perror("Eroare la deschiderea FIFO");
        return 1;
    }

    char buffer[256];
    ssize_t bytes_read = read(fifo, buffer, sizeof(buffer));
    if(bytes_read < 0) {
        perror("Eroare la citirea din FIFO");
        return 1;
    }
    buffer[bytes_read] = '\0';
    printf("Mesaj primit: %s", buffer);

    write(fifo, "pong\n", 5);

    close(fifo);
    return 0;
}