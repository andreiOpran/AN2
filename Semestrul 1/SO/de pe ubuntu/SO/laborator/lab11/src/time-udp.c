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
#include <time.h>

#define UNIXEPOCH 2208988800


int main(int argc, char* argv[])
{

    time_t now;
    now = time(NULL);
    now -= UNIXEPOCH;


    struct sockaddr_in s; 
    memset(&s, 0, sizeof(s));

    s.sin_family = AF_INET;
    s.sin_port = htons(37);
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

    unsigned int t = 0;
    t = buffer[3] & 0xff;
    t |= (buffer[2] << 8) & 0xff00;
    t |= (buffer[1] << 16) & 0xff0000;
    t |= (buffer[0] << 24) & 0xff000000;

    t -= UNIXEPOCH;

    printf("Server time: %s", ctime(&t));
    printf("Local time: %s", ctime(&now));



}