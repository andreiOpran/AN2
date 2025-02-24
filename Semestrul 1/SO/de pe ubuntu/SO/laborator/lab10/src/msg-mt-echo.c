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
#include <sys/msg.h>

struct mesg_buffer
{
    long mesg_type;
    char mesg_text[100];
} message;

int main(int argc, char *argv[])
{
    key_t key;
    key = ftok("keyfile", 65);
    int msgid;
    msgid = msgget(key, 0666);

    message.mesg_type = 1;
    strcpy(message.mesg_text, argv[1]);
    msgsnd(msgid, &message, sizeof(message), 0);

    msgrcv(msgid, &message, sizeof(message), 1, 0);
    printf("Data received is: %s\n", message.mesg_text);
        
}