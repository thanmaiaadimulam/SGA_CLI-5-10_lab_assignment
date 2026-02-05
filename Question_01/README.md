## Question 1 – File / Directory Analyzer

- **Script**: `analyze.sh`
- **Purpose**: Analyze a given path and print file statistics if it is a regular file, or file counts if it is a directory.

### How to Run

Make the script executable (one-time):

```bash
chmod +x analyze.sh
```

Run the script with exactly one argument (file or directory path). Example using the provided sample data:

```bash
./analyze.sh sample.txt
./analyze.sh sample_dir
```

### Logic / Observation

The script first validates that exactly one argument is provided and that the path exists.  
If it is a regular file, it uses `wc` to report line, word, and byte counts; if it is a directory, it uses `find` to count all regular files and how many of them are `.txt` files.

### Placeholder for Screenshot

![Execution Screenshot](./screenshot.png)

### Simulated Terminal Output

Example run on the provided `sample.txt`:

```bash
$ cd Question_01
$ chmod +x analyze.sh
$ ./analyze.sh sample.txt
'sample.txt' is a regular file.
Line count : 3
Word count : 10
Byte count : 86
```

Example run on the provided `sample_dir`:

```bash
$ ./analyze.sh sample_dir
'sample_dir' is a directory.
Total files      : 2
Text (*.txt) files: 1
```

