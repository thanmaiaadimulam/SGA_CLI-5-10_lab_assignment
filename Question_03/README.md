## Question 3 – Validate Exam Results

- **Script**: `validate_results.sh`
- **Purpose**: Read `marks.txt` and identify students who failed in exactly one subject and those who passed in all subjects.

### How to Run

Make the script executable (one-time):

```bash
chmod +x validate_results.sh
```

Run the script from inside the `Question_03` directory:

```bash
./validate_results.sh
```

This will read `marks.txt` and generate `results_report.txt`.

### Logic / Observation

The script uses `awk` to parse each row of `marks.txt`, counting how many subjects fall below the pass mark of 33.  
Students with exactly one failed subject are listed under “Failed in exactly ONE subject”, those with zero failed subjects appear under “Passed in ALL subjects”, and a summary of counts is printed and written to `results_report.txt`.

### Placeholder for Screenshot

![Execution Screenshot](./screenshot.png)

### Simulated Terminal Output

```bash
$ cd Question_03
$ chmod +x validate_results.sh
$ ./validate_results.sh
  102 Bob (Marks: 30, 55, 60)
  105 Eve (Marks: 90, 10, 95)

Passed in ALL subjects:
  101 Alice (Marks: 45, 67, 82)
  104 David (Marks: 33, 33, 33)

Summary:
  Failed in exactly ONE subject: 2
  Passed in ALL subjects       : 2

Detailed report written to: results_report.txt
```

