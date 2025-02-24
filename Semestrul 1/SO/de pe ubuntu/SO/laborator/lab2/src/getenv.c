#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[], char *envp[]) 
{
    if(argc == 2)
    {
        for(int i = 0; envp[i] != NULL; i++)
        {
            if(!strncmp(argv[1], envp[i], strlen(argv[1])))
            {
                printf("%s\n", envp[i]);
            }
        }
    }
    else 
    {
        for(int i = 0; envp[i] != NULL; i++)
        {
            //if(!strncmp(argv[1], envp[i], strlen(argv[1])))
                printf("%s\n", envp[i]);
        }
    }

    return 0;
}