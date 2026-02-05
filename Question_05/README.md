## Question 5 – Directory Sync / Comparison

- **Script**: `sync.sh`
- **Purpose**: Compare two directories and show which files are unique to each, and whether common files have matching or differing contents.

### How to Run

Make the script executable (one-time):

```bash
chmod +x sync.sh
```

Run the script with two directory paths. Example using the provided `dirA` and `dirB`:

```bash
./sync.sh dirA dirB
```

### Logic / Observation

The script lists regular files in each directory (non-recursively), sorts them, and uses `comm` to identify names that are unique to each side as well as common to both.  
For every common filename, it uses `cmp` to test if the file contents are identical, reporting `MATCH` or `DIFFER` so that directory differences are clearly visible.

### Placeholder for Screenshot

![Execution Screenshot](./screenshot.png)

### Simulated Terminal Output

```bash
$ cd Question_05
$ chmod +x sync.sh
$ ./sync.sh dirA dirB
Comparing 'dirA' and 'dirB'

Files only in dirA:
file1.txt

Files only in dirB:
file2.txt

Common files and content comparison:
  common.txt : DIFFER
```

