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

int main()
{
    struct sockaddr_in s;
    int sock;
    char buf[1];
    time_t server_time;

    s.sin_family = AF_INET;
    s.sin_port = htons(7000);
    s.sin_addr.s_addr = inet_addr("127.0.0.1");

    if((sock = socket(AF_INET, SOCK_DGRAM, 0)) < 0)
    {
        perror("eroare la socket");
        exit(1);
    }

    if(sendto(sock, buf, sizeof(buf), 0, (struct sockaddr *)&s, sizeof(s)) < 0)
    {
        perror("eroare la sendto");
        exit(1);
    }

    socklen_t addr_len = sizeof(s);
    if(recvfrom(sock, &server_time, sizeof(server_time), 0, (struct sockaddr *)&s, &addr_len) < 0)
    {
        perror("eroare la recvfrom");
        exit(1);
    }

    server_time = ntohl(server_time) - UNIXEPOCH;
    printf("Time received from server: %s", ctime(&server_time));
    // if(write(sock, server_time, sizeof(server_time)) < 0)
    // {
    //     perror("eroare la write");
    //     exit(1);
    // }


    
    close(sock);
    return 0;
}