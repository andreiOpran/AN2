#include <stdio.h>
#include <unistd.h>

int main() 
{
    printf("PID: %d\n", getpid());
    printf("UID: %d\n", getuid());
    printf("GID: %d\n", getgid());

    return 0;
}