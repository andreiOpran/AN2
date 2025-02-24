#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/select.h>

int passiveTCP(const char *service, int qlen);
int passiveUDP(const char *service);
void gettime(time_t *);

#define QLEN 5
#define UNIXEPOCH 2208988800 /* UNIX epoch, in UCT secs */

/*------------------------------------------------------------------------
* main - Iterative TCP server for DAYTIME service
*------------------------------------------------------------------------
*/
int main(int argc, char *argv[])
{
	struct sockaddr_in fsin; /* the from address of a client */
	char *service = "time"; /* service name or port number */
	int tsock, usock, ssock; /* master & slave sockets */
	int alen; /* from-address length */
	fd_set rfds; /* read file descriptor set */
	fd_set afds; /* active file descriptor set */
	int fd, nfds;
	time_t now;

	switch (argc) {
		case 1:
			break;
		case 2:
			service = argv[1];
			break;
		default:
			printf("usage: TCPdaytimed [port]\n"), exit(1);
	}

	// create passive TCP socket
	tsock = passiveTCP(service, QLEN);
	// create passive UDP socket
	usock = passiveUDP(service);
	// find out the size of the file descriptor table and store it in nfds
	nfds = getdtablesize();


	// zero your file descriptor set(s)
	FD_ZERO(&rfds);	
	FD_ZERO(&afds);
	// add file descriptor(s) to your zeroed file descriptor set(s)
	FD_SET(tsock, &afds);
	FD_SET(usock, &afds);

	
	while (1) {

		memcpy(&rfds, &afds, sizeof(rfds));

		// add the file descriptors of interest to the appropriate file descriptor set

		if (select(nfds, &rfds, NULL, NULL, (struct timeval *)0) < 0)
			printf("select failed: %s\n", strerror(errno)), exit(1);

		// check if the passive UDP socket is ready for use
		if(FD_ISSET(usock, &rfds))
		{
			// handle the UDP client request as in previous labs
			struct sockaddr_in s;
			int sLen = sizeof(s);
			memset(&s, 0, sLen);
			char buf[1];
			
			sLen = sizeof(s);
			if(recvfrom(usock, buf, sizeof(buf), 0, (struct sockaddr *)&s, &sLen) < 0)
			{
				perror("eroare la recvfrom");
				exit(1);
			}
			(void) time(&now);
			now = htonl((uint32_t) (now + UNIXEPOCH));

			sLen = sizeof(s);
			if(sendto(usock, (char *)&now, sizeof(now), 0, (struct sockaddr *)&s, sLen) < 0)
			{
				perror("eroare la sendto");
				exit(1);
			}
		}
		else if(FD_ISSET(tsock, &rfds))
		{
			// handle the TCP client request as in previous labs
			struct sockaddr_in s;
			int sLen = sizeof(s);
			memset(&s, 0, sLen);
			char buf[256];

			sLen = sizeof(s);
			int ssock;
			if((ssock = accept(tsock, (struct sockaddr *)&s, &sLen)) < 0)
			{
				perror("eroare la accept");
				exit(1);
			}
			(void) time(&now);
			//now = htonl((uint32_t) (now + UNIXEPOCH));

			sLen = sizeof(s);
			if(write(ssock, (char *)&now, sizeof(now)) < 0)
			{
				perror("eroare la write");
				exit(1);
			}
		}

		// do not forget to close the newly created socket !
		close(ssock);		
	}
}

void gettime(time_t *now)
{
	// get the current time	
}

