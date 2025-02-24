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
#include <sys/shm.h>
#include <sys/sem.h>
#include <semaphore.h>
#include <pthread.h>
#include <sys/socket.h>
#include <netinet/in.h>



int main(int argc, char* argv[])
{

    struct sockaddr_in s; 
    memset(&s, 0, sizeof(s));

    s.sin_family = AF_INET;
    s.sin_port = htons(13);
    s.sin_addr.s_addr = inet_addr(argv[1]);

    int sock;
    if((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        perror("eroare la socket");
        exit(1);
    }

    if(connect(sock, &s, sizeof(s)) < 0)
    {
        perror("eroare la connect");
        exit(1);
    }

    int n;
    char buffer[100];
    n = read(sock, buffer, sizeof(buffer));
    write(1, buffer, n);

    exit(0);
}

// daytime-tcp 127.0.0.1