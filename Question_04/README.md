## Question 4 – Email Cleaner

- **Script**: `emailcleaner.sh`
- **Purpose**: Validate email addresses from `emails.txt` using a simple pattern and separate them into `valid.txt` and `invalid.txt`, removing duplicates from the valid list.

### How to Run

Make the script executable (one-time):

```bash
chmod +x emailcleaner.sh
```

Run the script from inside the `Question_04` directory:

```bash
./emailcleaner.sh
```

This will read `emails.txt` and generate `valid.txt` and `invalid.txt`.

### Logic / Observation

Each non-empty line from `emails.txt` is tested against a case-insensitive regex of the form `<letters_digits>@<letters>.com` (for example, `john42@sample.com`).  
Addresses that match are written to `valid.txt` (then deduplicated via `sort | uniq`), while all others are written to `invalid.txt`, cleanly separating well-formed `.com` addresses from malformed or unsupported formats.

### Placeholder for Screenshot

![Execution Screenshot](./screenshot.png)

### Simulated Terminal Output

```bash
$ cd Question_04
$ chmod +x emailcleaner.sh
$ ./emailcleaner.sh
Valid emails written to   : valid.txt
Invalid emails written to : invalid.txt
```

Example contents after running:

```bash
$ cat valid.txt
alice123@example.com
BOB@example.com
daniel99@example.com
john42@sample.com

$ cat invalid.txt
invalid-email
carol_99@test.org
eve@domain
foo.bar@example.com
```

