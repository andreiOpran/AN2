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
    msgid = msgget(key, 0666 | IPC_CREAT);

    while(1)
    {
        // pthread aici si dupa apelez cu functie de thread

        msgrcv(msgid, &message, sizeof(message), 1, 0);
        msgsnd(msgid, &message, sizeof(message), 0);
        // printf("Data received is: %s\n", message.mesg_text);
    }
}