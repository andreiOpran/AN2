#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <errno.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int passiveTCP(const char *service, int qlen) {
    struct servent *pse;
    struct sockaddr_in sin;
    int s;
    int port;
 
    memset(&sin, 0, sizeof(sin));
    sin.sin_family = AF_INET;
    sin.sin_addr.s_addr = INADDR_ANY;
    if ((pse = getservbyname(service, "tcp")) != NULL) {
        port = ntohs((unsigned short)pse->s_port);
    } else if ((port = atoi(service)) == 0) {
        fprintf(stderr, "port invalid: %s\n", service);
        exit(1);
    }
    sin.sin_port = htons(port);
    if ((s = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
        perror("socket");
        exit(1);
    }
    if (bind(s, (struct sockaddr *)&sin, sizeof(sin)) < 0) {
        perror("bind");
        exit(1);
    }
    if (listen(s, qlen) < 0) {
        perror("listen");
        exit(1);
    }
 
    return s;
}
 
int main(int argc, char *argv[]) {
    char *service = "12345"; // port default daca nu e dat argument
    int sock, fd;
    struct sockaddr_in fsin;
    socklen_t alen = sizeof(fsin);
    char buf[1024], header[1024];
    int n;
    if (argc == 2) {
        service = argv[1];
    }
    sock = passiveTCP(service, 5);
    for (;;) {
        fd = accept(sock, (struct sockaddr *)&fsin, &alen);
        if (fd < 0) {
            if (errno == EINTR)
                continue;
            perror("accept");
            exit(1);
        }
 
        while ((n = read(fd, buf, sizeof(buf))) > 0) {
            strcpy(header, "HTTP/1.1 200 OK\r\n");
            strcat(header, "Content-Type: text/html; charset=utf-8\r\n\r\n");
            write(fd, header, strlen(header));
            write(fd, buf, n);
        }
        close(fd);
    }
 
    return 0;
}


/*

HEADER:

"HTTP/1.1 200 OK\n"
"Content-Type: text/html; charset=utf-8\n\n"

*/