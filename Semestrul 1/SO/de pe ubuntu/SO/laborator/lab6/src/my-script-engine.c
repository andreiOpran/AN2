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

// execv

int main(int argc, char* argv[])
{
    char path[1024], interpretor[1024], comenzi[1024];
    int fd, i = 2;

    fd = open(argv[1], O_RDWR);

    if(fd < 0)
    {
        printf("eroare la deschiderea fisierului\n");
        return 1;
    }

    char buffer[1024];
    ssize_t bytesRead;
    while ((bytesRead = read(fd, buffer, sizeof(buffer) - 1)) > 0) 
    {
        buffer[bytesRead] = '\0';
    }
    if(buffer[0] == '#' && buffer[1] == '!')
    {
        while(buffer[i] != '\n')
        {
            i++;
            path[i - 3] = buffer[i];
        }
        path[i - 3] = '\0';
    }
    else
    {
        printf("fisierul nu incepe cu #!\n");
        return 1;
    }

    strcpy(interpretor, path);

    // acum buffer + i este \n de dupa interpretor

    // sarim peste \n
    ++i;

    // adaugare / lipsa de la inceput
    char aux[] = "/";
    strcat(aux, interpretor);
    strcpy(interpretor, aux);

    strcpy(comenzi, buffer + i);

    pid_t pid = vfork();

    if(pid < 0)
    {
        printf("eroare la fork\n");
        return 1;
    }
    if (pid == 0) // copil
    {
        int i = 0, j;
        char comanda[1024];
        while (comenzi[i] != '\0')
        {
            j = 0;
            while (comenzi[i] != '\n' && comenzi[i] != '\0')
            {
                if (j < sizeof(comanda) - 1)
                {
                    comanda[j] = comenzi[i];
                    j++;
                }
                i++;
            }
            comanda[j] = '\0';
    
            if (comenzi[i] == '\n')
                i++;
    
            char *args[] = {interpretor, "-c", comanda, NULL};
            execv(interpretor, args);
    
            perror("execv failed");
            exit(1);
            
        }
        exit(0);
    }
    if(pid > 0) // parinte
    {
        wait(NULL);
    }

    
    

    close(fd);

    return 0;
}