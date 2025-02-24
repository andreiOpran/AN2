#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char* argv[])
{
    int dest;
    char hole[] = "hole.txt";

    dest = creat(hole, 0755);

    write(dest, "fisier cu ", 10);

    // modifica pozitia curenta a cursorului la 100 de octeti de la inceputul fisierului (de la inceputul fisierului pentru ca am folosit SEEK_SET)
    lseek(dest, 100, SEEK_SET); 

	write(dest, " goluri", 7);

    return 0;
} 