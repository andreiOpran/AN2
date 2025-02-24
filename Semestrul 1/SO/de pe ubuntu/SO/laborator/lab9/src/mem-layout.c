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

/*

- adresa functiei main
- adresa argv
- adresa unei variabile globale initializate
- adresele de inceput si sfarsit ale unui array global de octeti neinitializat (de dimensiune relativ
mare, sa zicem 40000 bytes)
- adresa primei variabile locale declarate in main (va fi alocata pe stiva)
- adresa unui vector de 10000 octeti alocat in main cu alloca
- adresa unui vector de 10000 de octeti alocat dinamic in main cu malloc + program break-ul
(folositi apelul sbrk)
- creati o zona de memorie partajata privata (shmget cu IPC_PRIVATE) si tipariti valoarea adresei
la care se ataseaza in program (obtinuta cu shmat).

*/


int varGlobala = 0;
char arrayGlobal[40000];

int main(int argc, char *argv[])
{
	int varLocala = 0;

	char *vectorAlloca = alloca(10000);
	char *vectorMalloc = malloc(10000);

	int id = shmget(IPC_PRIVATE, 10000, IPC_CREAT | 0666);
	char* buf = shmat(id, 0, 0);

	printf("Adresa functiei main: %p\n", main);
	printf("Adresa argv: %p\n", argv);
	printf("Adresa variabilei globale initializate: %p\n", &varGlobala);
	printf("Adresa de inceput a array-ului global: %p\n", &arrayGlobal);
	printf("Adresa de sfarsit a array-ului global: %p\n", &arrayGlobal + sizeof(arrayGlobal));
	printf("Adresa primei variabile locale declarate in main: %p\n", &varLocala);
	printf("Adresa vectorului alocat cu alloca: %p\n", vectorAlloca);
	printf("Adresa vectorului alocat cu malloc: %p\n", vectorMalloc);
	printf("Adresa program break-ului: %p\n", sbrk(0));
	printf("Adresa zonei de memorie partajata: %p\n", buf);
	
	shmctl(id, IPC_RMID, NULL);

	return 0;
}