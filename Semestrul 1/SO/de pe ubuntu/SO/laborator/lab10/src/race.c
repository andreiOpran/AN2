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


sem_t sem;


void myprint1(char* str)
{
    char c;

    char mesaj[256];
    strcpy(mesaj, "This is the first thread\n");

    for(int i = 0;i <= 10; i++)
    {
        sem_wait(&sem);
        for(int i=0;i<strlen(mesaj);i++)
        {
            write(1, &mesaj[i], 1);
        }
        sem_post(&sem);
    }
    
}

void myprint2(char* str)
{
    char c;

    char mesaj[256];
    strcpy(mesaj, "This is the second thread\n");

    for(int i =0;i<=10;i++)
    {
        sem_wait(&sem);
        for(int i=0; i<strlen(mesaj);i++)
        {
            write(1, &mesaj[i], 1);
        }
        sem_post(&sem);
    }
    
}
int main()
{

    pthread_t thread1, thread2;

    char buf1[256], buf2[256];

    sem_init(&sem, 0, 1);

    if(pthread_create(&thread1, NULL, (void*)myprint1, buf1) != 0)
    {
        perror("eroare la crearea threadului 1");
        exit(1);
    }

    if(pthread_create(&thread2, NULL, (void*)myprint2, buf2) != 0)
    {
        perror("eroare la crearea threadului 2");
        exit(1);
    }

    if(pthread_join(thread1, NULL) != 0)
    {
        perror("eroare la asteptarea threadului 1");
        exit(1);
    }

    if(pthread_join(thread2, NULL) != 0)
    {
        perror("eroare la asteptarea threadului 2");
        exit(1);
    }

    sem_destroy(&sem);
    exit(0);

}