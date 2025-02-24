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

void myprint(char* str)
{
    char c;

    while((c = *str++) != '\0')
    {
        write(1, &c, 1);
    }
}

// struct sembuf {
//     short sem_num; // nr semafor in set: 0, 1 , …
//     short sem_op; // operatia > 0, 0, < 0
//     short sem_flg; // IPC_NOWAIT, SEM_UNDO
// };


int main()
{

    char str[30];

    struct sembuf up = {0, 1, 0};
    struct sembuf down = {0, -1, 0};

    int id;
    id = semget(IPC_PRIVATE, 1, IPC_CREAT | 0666);
    semctl(id, 0, SETVAL, 1);

    pid_t pid = fork();
    if(pid < 0)
    {
        printf("eroare la fork");
        return 1;
    }
    
    if(pid == 0) // copil
    {
        int i = 0;
        strcpy(str, "This is the child process\n");
        int check;


        check = semop(id, &down, 1);
        if(check < 0)
        {
            perror("eroare copil");
            exit(1);
        } 
        
        while(i++ < 10)
        {
            myprint(str);
        }

        check = semop(id, &up, 1);
        if(check < 0)
        {
            perror("eroare copil");
            exit(1);
        } 

    }
    if(pid > 0) // parinte
    {
        int i = 0;
        strcpy(str, "This is the parent process\n");   
        int check;

        check = semop(id, &down, 1);
        if(check < 0)
        {
            perror("eroare parinte");
            exit(1);
        } 

        while(i++ < 10)
        {
            myprint(str);
        }
      
        check = semop(id, &up, 1); 
        if(check < 0)
        {
            perror("eroare parinte");
            exit(1);
        } 

    }

    wait(NULL);
    shmctl(id, IPC_RMID, NULL);

    return 0;
}