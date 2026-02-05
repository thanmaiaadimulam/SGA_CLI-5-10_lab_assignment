## Question 7 – Pattern-Based Word Categorization

- **Script**: `patterns.sh`
- **Purpose**: Categorize words (case-insensitive) into vowel-only, consonant-only, and mixed (starting with a consonant and containing both vowels and consonants).

### How to Run

Make the script executable (one-time):

```bash
chmod +x patterns.sh
```

Run the script with a word list file. Example using the provided `words.txt`:

```bash
./patterns.sh words.txt
```

This will generate `vowels.txt`, `consonants.txt`, and `mixed.txt`.

### Logic / Observation

The script reads each non-empty line and uses case-insensitive regex checks to classify it: words matching only vowels go to `vowels.txt`, words matching only consonant letters go to `consonants.txt`, and the rest are checked for starting with a consonant while containing at least one vowel and one consonant before being written to `mixed.txt`.  
This demonstrates practical use of regex and case-insensitive matching to bucket tokens into distinct linguistic pattern groups.

### Screenshot

![Execution Screenshot](../Question7.png)

### Output

```bash
chmod +x patterns.sh
./patterns.sh words.txt
```

```
Vowel-only words written to : vowels.txt
Consonant-only words written to : consonants.txt
Mixed words written to : mixed.txt
```

### Explanation

The script is made executable and run with `words.txt` as input. It classifies every word into three groups using pattern checks: **vowel-only** (e.g. "a", "aeiou") → `vowels.txt`, **consonant-only** (e.g. "sky", "rhythm") → `consonants.txt`, and **mixed** (starts with a consonant and has both vowels and consonants) → `mixed.txt`. The three confirmation lines show that all three output files were written successfully, demonstrating the pattern-based word categorization.

### Simulated Terminal Output (with example contents)

```bash
$ cd Question_07
$ chmod +x patterns.sh
$ ./patterns.sh words.txt
Vowel-only words written to     : vowels.txt
Consonant-only words written to : consonants.txt
Mixed words written to          : mixed.txt
```

Example contents after running:

```bash
$ cat vowels.txt
a
AEIOU

$ cat consonants.txt
bbb
sky
rhythm

$ cat mixed.txt
linux
script
tool
data
echo
```

