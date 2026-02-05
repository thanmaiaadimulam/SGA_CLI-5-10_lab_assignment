## Question 2 – Log Parser

- **Script**: `logparser.sh`
- **Purpose**: Parse a log file, count `INFO`, `WARNING`, and `ERROR` entries, display the most recent `ERROR`, and write a timestamped summary file.

### How to Run

Make the script executable (one-time):

```bash
chmod +x logparser.sh
```

Run the script with the path to a log file. Example using the provided `system.log`:

```bash
./logparser.sh system.log
```

### Logic / Observation

The script validates that the log file exists and is readable, then uses `grep` to count lines containing `INFO`, `WARNING`, and `ERROR`.  
It extracts the most recent `ERROR` line using `tail -n 1` and writes all statistics plus that last error into a `logsummary_<date>.txt` file while echoing the same key information to the terminal.

### Placeholder for Screenshot

![Execution Screenshot](./screenshot.png)

### Simulated Terminal Output

```bash
$ cd Question_02
$ chmod +x logparser.sh
$ ./logparser.sh system.log
INFO count   : 4
WARNING count: 2
ERROR count  : 2
Most recent ERROR:
2026-02-05 09:17:42 [ERROR] Backup job failed: permission denied
Summary written to: logsummary_20260205_093000.txt
```

*(The exact summary filename and timestamps will vary depending on the current date/time.)*

