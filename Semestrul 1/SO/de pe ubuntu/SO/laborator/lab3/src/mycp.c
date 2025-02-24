#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char* argv[])
{
    int src, dest;

    src = open(argv[1], O_RDWR);
    dest = creat(argv[2], 0755);
    
    /*
    
    0XYZ -> X = OWNER, Y = GROUP, Z = OTHERS
    
    RWX -> read write execute
    
    4 = READ PERMISSION
    2 = WRITE PERMISSION
    1 = EXECUTE PERMISSION

    7 = READ + WRITE + EXECUTE 
    6 = READ + WRITE 
    5 = READ + EXECUTE 
    4 = READ 
    3 = WRITE + EXECUTE 
    2 = WRITE 
    1 = EXECUTE 
    0 = NO PERMISSION

    */

    char buffer[256];
    ssize_t read_bytes;

    while((read_bytes = read(src, buffer, sizeof(buffer))) > 0)
    {
        write(dest, buffer, read_bytes);
    }

    close(src);
    close(dest);

    return 0;
}