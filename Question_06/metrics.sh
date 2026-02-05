#!/bin/bash

# metrics.sh
# Analyze input.txt and compute:
# - Longest word and its length
# - Shortest word and its length
# - Average word length
# - Count of unique words

INPUT_FILE="input.txt"

if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: '$INPUT_FILE' not found in current directory." >&2
  exit 1
fi

# Normalize to one word per line
words=$(tr -s '[:space:]' '\n' < "$INPUT_FILE" | sed '/^$/d')

if [ -z "$words" ]; then
  echo "No words found in input."
  exit 0
fi

# Use awk to compute metrics
echo "$words" | awk '
{
  w = $1;
  len = length(w);
  total_len += len;
  count++;

  if (count == 1 || len > max_len) {
    max_len = len;
    longest = w;
  }
  if (count == 1 || len < min_len) {
    min_len = len;
    shortest = w;
  }
}
END {
  avg = (count > 0) ? total_len / count : 0;
  printf("Longest word : %s (length %d)\n", longest, max_len);
  printf("Shortest word: %s (length %d)\n", shortest, min_len);
  printf("Average length: %.2f\n", avg);
}
'

unique_count=$(echo "$words" | sort | uniq | wc -l | awk '{print $1}')
echo "Unique word count: $unique_count"

exit 0

