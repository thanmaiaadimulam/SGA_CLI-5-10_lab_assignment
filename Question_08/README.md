## Question 8 – Background Move with Job Control

- **Script**: `bg_move.sh`
- **Purpose**: Move files from a source directory into a `backup/` directory using a background job, printing the background PID and waiting for completion.

### How to Run

Make the script executable (one-time):

```bash
chmod +x bg_move.sh
```

Run the script with a source directory. Example using the provided `data` directory:

```bash
./bg_move.sh data
```

After completion, the files from `data/` will be found under `backup/`.

### Logic / Observation

The script validates the source directory, creates a `backup/` folder if needed, and then starts an `mv` command in the background using `&`, capturing its PID from `$!`.  
It prints the background PID, then calls `wait` on that PID so the script can report when the move finished and with what status, demonstrating simple background job control.

### Placeholder for Screenshot

![Execution Screenshot](./screenshot.png)

### Simulated Terminal Output

```bash
$ cd Question_08
$ chmod +x bg_move.sh
$ ls data
file1.txt  file2.log
$ ./bg_move.sh data
Starting background move from 'data' to 'backup'...
Background mv PID: 12345
Background move completed successfully.
$ ls data
$ ls backup
file1.txt  file2.log
```

*(Actual PID will vary at runtime.)*

