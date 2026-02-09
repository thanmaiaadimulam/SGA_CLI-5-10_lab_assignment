## Question 1 – File / Directory Analyzer

- **Script**: `analyze.sh`
- **Purpose**: Analyze a given path and print file statistics if it is a regular file, or file counts if it is a directory.

### How to Run


```bash
chmod +x analyze.sh
```


```bash
./analyze.sh sample.txt
./analyze.sh sample_dir
```

### Logic / Observation

The script first validates that exactly one argument is provided and that the path exists.  
If it is a regular file, it uses `wc` to report line, word, and byte counts; if it is a directory, it uses `find` to count all regular files and how many of them are `.txt` files.

### Screenshot

![Execution Screenshot](../Question1.png)

### Output

```bash
chmod +x ./analyze.sh
sudo ./analyze.sh analyze.sh
```

```
'analyze.sh' is a regular file.
Line count : 47
Word count : 184
Byte count : 1137
```

### Explanation

The first command (`chmod +x`) makes `analyze.sh` executable. The second command runs the script with `analyze.sh` itself as the argument. The script correctly identifies the path as a regular file and uses `wc` to report **line count** (47 lines), **word count** (184 words), and **byte count** (1137 bytes). This confirms the file analyzer works as intended when given a regular file.


