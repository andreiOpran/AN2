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
#include <arpa/inet.h>

#define UNIXEPOCH 2208988800

int main(int argc, char* argv[])
{

    struct sockaddr_in s;
    int sLen = sizeof(s);
    memset(&s, 0, sLen);
    char buf[1];
    time_t now;

    s.sin_family = AF_INET;
    s.sin_port = htons(7000);
    s.sin_addr.s_addr = inet_addr("127.0.0.1");

    int sock;
    if((sock = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
    {
        perror("eroare la socket");
        exit(1);
    }

    sLen = sizeof(s);
    if(bind(sock, (struct sockaddr *)&s, sLen) < 0)
    {
        perror("eroare la bind");
        exit(1);
    }

    while(1)
    {
        sLen = sizeof(s);
        if(recvfrom(sock, buf, sizeof(buf), 0, (struct sockaddr *)&s, &sLen) < 0)
        {
            perror("eroare la recvfrom");
            exit(1);
        }
        (void) time(&now);
        now = htonl((uint32_t) (now + UNIXEPOCH));

        sLen = sizeof(s);
        if(sendto(sock, (char *)&now, sizeof(now), 0, (struct sockaddr *)&s, sLen) < 0)
        {
            perror("eroare la sendto");
            exit(1);
        }
    }
    exit(0);
}
