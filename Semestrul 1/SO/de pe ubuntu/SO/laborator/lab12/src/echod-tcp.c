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


int main()
{

    struct sockaddr_in s;
    int sLen = sizeof(s);
    memset(&s, 0, sLen);
    char buf[256];

    s.sin_family = AF_INET;
    s.sin_port = htons(7003);
    s.sin_addr.s_addr = inet_addr("127.0.0.1");

    int sock;
    if((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
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

    if((listen(sock, 128)) < 0)
    {
        perror("eroare la listen");
        exit(1);
    }

    while(1)
    {
        int newSock;
        if((newSock = accept(sock, (struct sockaddr *)&s, &sLen)) < 0)
        {
            perror("eroare la accept");
            exit(1);
        }
        int n = read(newSock, buf, sizeof(buf));
        write(newSock, buf, n);
    }
    close(sock);
    exit(0);
}