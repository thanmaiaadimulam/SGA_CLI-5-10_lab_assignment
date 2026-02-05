#!/bin/bash

# validate_results.sh
# Read marks.txt and identify:
# - Students who failed in exactly ONE subject
# - Students who passed in ALL subjects

INPUT_FILE="marks.txt"
OUTPUT_FILE="results_report.txt"

if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: '$INPUT_FILE' not found in current directory." >&2
  exit 1
fi

awk -v out="$OUTPUT_FILE" '
BEGIN {
  pass_mark = 33;
  failed_one_count = 0;
  passed_all_count = 0;
  # Prepare output file with headers
  print "Results Report" > out;
  print "==============" >> out;
  print "" >> out;
  print "Failed in exactly ONE subject:" >> out;
}
NR == 1 {
  # Assume header line; copy to output header section
  header = $0;
  next;
}
NR > 1 {
  roll = $1;
  name = $2;
  m1 = $3;
  m2 = $4;
  m3 = $5;

  failed = 0;
  if (m1 < pass_mark) failed++;
  if (m2 < pass_mark) failed++;
  if (m3 < pass_mark) failed++;

  if (failed == 1) {
    printf("  %s %s (Marks: %d, %d, %d)\n", roll, name, m1, m2, m3);
    printf("  %s %s (Marks: %d, %d, %d)\n", roll, name, m1, m2, m3) >> out;
    failed_one_count++;
  } else if (failed == 0) {
    passed_all[roll] = sprintf("%s %s (Marks: %d, %d, %d)", roll, name, m1, m2, m3);
    passed_all_count++;
  }
}
END {
  print "" >> out;
  print "Passed in ALL subjects:" >> out;
  for (r in passed_all) {
    print "  " passed_all[r];
  }

  print "";
  print "Summary:";
  print "  Failed in exactly ONE subject: " failed_one_count;
  print "  Passed in ALL subjects       : " passed_all_count;

  print "" >> out;
  print "Summary:" >> out;
  printf("  Failed in exactly ONE subject: %d\n", failed_one_count) >> out;
  printf("  Passed in ALL subjects       : %d\n", passed_all_count) >> out;
}
' "$INPUT_FILE"

echo "Detailed report written to: $OUTPUT_FILE"

exit 0

