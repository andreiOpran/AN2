#include <stdio.h>
#include <pwd.h>
#include <stdlib.h>

int main(int argc, char *argv[]) 
{
    if(argc != 2) 
    {
        printf("Usage: %s username\n", argv[0]);
        return 1;
    }

    struct passwd *pwd;
    pwd = getpwnam(argv[1]);

    if(pwd == NULL) 
    {
        printf("No such user: %s\n", argv[1]);
        return 1;
    }

    printf("User: %s\n", pwd->pw_name);
    printf("UID: %d\n", pwd->pw_uid);
    printf("GID: %d\n", pwd->pw_gid);
    printf("Home directory: %s\n", pwd->pw_dir);
    printf("Shell: %s\n", pwd->pw_shell);

    return 0;
}