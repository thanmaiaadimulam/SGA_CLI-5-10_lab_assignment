## Question 10 – Signal Handling with Multiple Children (C)

- **Source**: `signal_handling.c`
- **Purpose**: Demonstrate distinct handling of `SIGTERM` and `SIGINT` sent from two child processes to a looping parent, followed by a graceful shutdown.

### How to Compile and Run

From inside the `Question_10` directory, compile with `gcc`:

```bash
gcc signal_handling.c -o signal_handling
```

Then run the resulting binary:

```bash
./signal_handling
```

### Logic / Observation

The parent installs separate handlers for `SIGTERM` and `SIGINT`, then forks two children: child 1 sleeps 5 seconds and sends `SIGTERM`, while child 2 sleeps 10 seconds and sends `SIGINT`.  
The parent remains in a work loop, printing status until both signals have been received, prints distinct messages in each handler, then reaps both children with `waitpid()` and exits cleanly to demonstrate coordinated signal handling and graceful termination.

### Placeholder for Screenshot

![Execution Screenshot](./screenshot.png)

### Simulated Terminal Output

```bash
$ cd Question_10
$ gcc signal_handling.c -o signal_handling
$ ./signal_handling
Parent PID: 55000
Child 1 (PID 55001): will send SIGTERM to parent (PID 55000) after 5 seconds.
Child 2 (PID 55002): will send SIGINT to parent (PID 55000) after 10 seconds.
Parent: entering work loop. Waiting for signals from children...
Parent: working... (SIGTERM=0, SIGINT=0)
Parent: working... (SIGTERM=0, SIGINT=0)
Parent: working... (SIGTERM=0, SIGINT=0)
Parent: working... (SIGTERM=0, SIGINT=0)
Parent: working... (SIGTERM=0, SIGINT=0)

Parent: Caught SIGTERM from child 1. Initiating graceful shutdown step.
Child 1 (PID 55001): SIGTERM sent, exiting.
Parent: working... (SIGTERM=1, SIGINT=0)
Parent: working... (SIGTERM=1, SIGINT=0)
Parent: working... (SIGTERM=1, SIGINT=0)
Parent: working... (SIGTERM=1, SIGINT=0)
Parent: working... (SIGTERM=1, SIGINT=0)

Parent: Caught SIGINT from child 2. Finalizing graceful exit.
Child 2 (PID 55002): SIGINT sent, exiting.
Parent: working... (SIGTERM=1, SIGINT=1)
Parent: both SIGTERM and SIGINT received. Cleaning up children...
Parent: child PID 55001 exited with status 0.
Parent: child PID 55002 exited with status 0.
Parent: graceful exit complete.
```

*(Actual PIDs and timing output will vary per run.)*

