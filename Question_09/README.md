## Question 9 – Zombie Prevention (C, `fork()` + `waitpid()`)

- **Source**: `zombie_prevention.c`
- **Purpose**: Demonstrate proper child process cleanup using `waitpid()` so that no zombie processes remain.

### How to Compile and Run

From inside the `Question_09` directory, compile with `gcc`:

```bash
gcc zombie_prevention.c -o zombie_prevention
```

Then run the resulting binary:

```bash
./zombie_prevention
```

### Logic / Observation

The program calls `fork()`; the child sleeps briefly, prints messages, and exits, while the parent calls `waitpid()` on the child to collect its exit status.  
By explicitly waiting for the terminated child, the parent ensures the kernel can fully reclaim the child’s resources, preventing zombie processes and printing the PID of the cleaned-up child.

### Placeholder for Screenshot

![Execution Screenshot](./screenshot.png)

### Simulated Terminal Output

```bash
$ cd Question_09
$ gcc zombie_prevention.c -o zombie_prevention
$ ./zombie_prevention
Parent PID: 54321
Child started with PID: 54322
Parent waiting for child (PID 54322)...
Child (PID 54322) exiting now.
Parent cleaned up child PID 54322 with exit status 0.
Parent exiting.
```

*(Actual PIDs will vary per run.)*

