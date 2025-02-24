#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

// VARIANTA 2

// myecho
// echo "alt fel de a rula codul" | myecho
// echo "iarasi alt fel" > out; myecho < out

int main(int argc, char *argv[], char *envp[]) 
{
    char buffer[256];
    int i = 0;
    read(0, buffer, 256);
    while(buffer[i] != '\n')
    {
        write(1, &buffer[i], 1);
        i++;
    }
    write(1, "\n", 1); // endl
    return 0;
}


/*

VARIANTA 1

int main(int argc, char *argv[], char *envp[]) 
{
    // argv[1] de afisat
    if(argc == 1)
    {
        write(1, "Fara argumente\n", 15);
    }
    else
    {
        write(1, argv[1], strlen(argv[1]));
        write(1, "\n", 1);
    }
    return 0;
}

*/


