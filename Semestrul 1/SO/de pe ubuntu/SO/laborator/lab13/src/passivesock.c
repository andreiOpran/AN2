/* passivesock.c - passivesock */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <errno.h>
#include <stdio.h>

typedef unsigned short u_short;

/*------------------------------------------------------------------------
* passivesock - allocate & bind a server socket using TCP or UDP
*------------------------------------------------------------------------
*/
int passivesock(const char *service, const char *transport, int qlen)
/*
* Arguments:
* service
- service associated with the desired port
* transport - transport protocol to use ("tcp" or "udp")
* qlen
- maximum server request queue length
*/
{
	struct servent *pse; /* pointer to service information entry */
	struct protoent *ppe; /* pointer to protocol information entry*/
	struct sockaddr_in sin; /* an Internet endpoint address */
	int s, type; /* socket descriptor and socket type */

	memset(&sin, 0, sizeof(sin));
	sin.sin_family = AF_INET;
	sin.sin_addr.s_addr = INADDR_ANY;

	/* Map service name to port number */
	if ( pse = getservbyname(service, transport) )
		sin.sin_port = htons(ntohs((u_short)pse->s_port));
	else if ( (sin.sin_port = htons((u_short)atoi(service))) == 0 )
		printf("can't get \"%s\" service entry\n", service), exit(1);

	/* Map protocol name to protocol number */
	if ( (ppe = getprotobyname(transport)) == 0)
		printf("can't get \"%s\" protocol entry\n", transport), exit(1);

	/* Use protocol to choose a socket type */
	if (strcmp(transport, "udp") == 0)
		type = SOCK_DGRAM;
	else
		type = SOCK_STREAM;

	/* Allocate a socket */
	s = socket(PF_INET, type, ppe->p_proto);
	if (s < 0)
		printf("can't create socket: %s\n", strerror(errno)), exit(1);

	/* Bind the socket */
	if (bind(s, (struct sockaddr *)&sin, sizeof(sin)) < 0)
		printf("can't bind to %s port: %s\n", service, strerror(errno)), exit(1);

	if (type == SOCK_STREAM && listen(s, qlen) < 0)
		printf("can't listen on %s port: %s\n", service, strerror(errno)), exit(1);

	return s;
}

int passiveTCP(const char *service, int qlen)
/*
* Arguments:
* service - service associated with the desired port
* qlen
- maximum server request queue length
*/
{
	return passivesock(service, "tcp", qlen);
}

int passiveUDP(const char *service)
/*
* Arguments:
*
service - service associated with the desired port
*/
{
	return passivesock(service, "udp", 0);
}

