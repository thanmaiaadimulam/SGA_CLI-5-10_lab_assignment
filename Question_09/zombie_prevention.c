#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(void) {
    pid_t pid;

    printf("Parent PID: %d\n", getpid());

    pid = fork();
    if (pid < 0) {
        perror("fork");
        return EXIT_FAILURE;
    }

    if (pid == 0) {
        /* Child process */
        printf("Child started with PID: %d\n", getpid());
        sleep(2);
        printf("Child (PID %d) exiting now.\n", getpid());
        _exit(0);
    } else {
        /* Parent process */
        int status;
        pid_t cleaned;

        printf("Parent waiting for child (PID %d)...\n", pid);
        cleaned = waitpid(pid, &status, 0);
        if (cleaned == -1) {
            perror("waitpid");
            return EXIT_FAILURE;
        }

        if (WIFEXITED(status)) {
            printf("Parent cleaned up child PID %d with exit status %d.\n",
                   cleaned, WEXITSTATUS(status));
        } else if (WIFSIGNALED(status)) {
            printf("Parent cleaned up child PID %d terminated by signal %d.\n",
                   cleaned, WTERMSIG(status));
        } else {
            printf("Parent cleaned up child PID %d (other termination).\n", cleaned);
        }

        printf("Parent exiting.\n");
    }

    return EXIT_SUCCESS;
}

