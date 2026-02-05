## Question 6 – Text Metrics

- **Script**: `metrics.sh`
- **Purpose**: Analyze `input.txt` to find the longest and shortest words, compute the average word length, and count unique words.

### How to Run

Make the script executable (one-time):

```bash
chmod +x metrics.sh
```

Run the script from inside the `Question_06` directory:

```bash
./metrics.sh
```

### Logic / Observation

The script uses `tr` to convert whitespace into newlines so each word appears on its own line, filters out empty lines, and then leverages `awk` to track total length, count, and min/max lengths.  
Finally, it calculates the average word length and uses `sort | uniq | wc` to determine how many distinct words appear in the input.

### Placeholder for Screenshot

![Execution Screenshot](./screenshot.png)

### Simulated Terminal Output

```bash
$ cd Question_06
$ chmod +x metrics.sh
$ ./metrics.sh
Longest word : scripting (length 9)
Shortest word: tr (length 2)
Average length: 4.46
Unique word count: 17
```

*(Exact values may vary slightly if you edit `input.txt`.)*

