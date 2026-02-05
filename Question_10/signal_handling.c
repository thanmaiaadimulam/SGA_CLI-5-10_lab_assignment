#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>

volatile sig_atomic_t sigterm_received = 0;
volatile sig_atomic_t sigint_received = 0;

void handle_sigterm(int signo) {
    (void)signo;
    sigterm_received = 1;
    printf("\nParent: Caught SIGTERM from child 1. Initiating graceful shutdown step.\n");
    fflush(stdout);
}

void handle_sigint(int signo) {
    (void)signo;
    sigint_received = 1;
    printf("\nParent: Caught SIGINT from child 2. Finalizing graceful exit.\n");
    fflush(stdout);
}

int main(void) {
    pid_t child1, child2;

    printf("Parent PID: %d\n", getpid());

    /* Install signal handlers in parent */
    struct sigaction sa_term, sa_int;

    sa_term.sa_handler = handle_sigterm;
    sigemptyset(&sa_term.sa_mask);
    sa_term.sa_flags = 0;
    if (sigaction(SIGTERM, &sa_term, NULL) == -1) {
        perror("sigaction SIGTERM");
        return EXIT_FAILURE;
    }

    sa_int.sa_handler = handle_sigint;
    sigemptyset(&sa_int.sa_mask);
    sa_int.sa_flags = 0;
    if (sigaction(SIGINT, &sa_int, NULL) == -1) {
        perror("sigaction SIGINT");
        return EXIT_FAILURE;
    }

    /* Fork first child (sends SIGTERM after 5s) */
    child1 = fork();
    if (child1 < 0) {
        perror("fork child1");
        return EXIT_FAILURE;
    }

    if (child1 == 0) {
        printf("Child 1 (PID %d): will send SIGTERM to parent (PID %d) after 5 seconds.\n",
               getpid(), getppid());
        sleep(5);
        kill(getppid(), SIGTERM);
        printf("Child 1 (PID %d): SIGTERM sent, exiting.\n", getpid());
        _exit(0);
    }

    /* Fork second child (sends SIGINT after 10s) */
    child2 = fork();
    if (child2 < 0) {
        perror("fork child2");
        return EXIT_FAILURE;
    }

    if (child2 == 0) {
        printf("Child 2 (PID %d): will send SIGINT to parent (PID %d) after 10 seconds.\n",
               getpid(), getppid());
        sleep(10);
        kill(getppid(), SIGINT);
        printf("Child 2 (PID %d): SIGINT sent, exiting.\n", getpid());
        _exit(0);
    }

    /* Parent main loop */
    printf("Parent: entering work loop. Waiting for signals from children...\n");

    while (!(sigterm_received && sigint_received)) {
        printf("Parent: working... (SIGTERM=%d, SIGINT=%d)\n",
               sigterm_received, sigint_received);
        fflush(stdout);
        sleep(1);
    }

    printf("Parent: both SIGTERM and SIGINT received. Cleaning up children...\n");

    /* Reap child processes */
    int status;
    pid_t pid;
    while ((pid = waitpid(-1, &status, 0)) > 0) {
        if (WIFEXITED(status)) {
            printf("Parent: child PID %d exited with status %d.\n",
                   pid, WEXITSTATUS(status));
        } else if (WIFSIGNALED(status)) {
            printf("Parent: child PID %d terminated by signal %d.\n",
                   pid, WTERMSIG(status));
        }
    }

    printf("Parent: graceful exit complete.\n");
    return EXIT_SUCCESS;
}

