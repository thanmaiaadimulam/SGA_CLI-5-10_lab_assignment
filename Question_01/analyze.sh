#!/bin/bash

# analyze.sh
# Check if the given argument is a file or directory and print statistics.

usage() {
  echo "Usage: $0 <path_to_file_or_directory>" >&2
  exit 1
}

# Ensure exactly one argument
if [ "$#" -ne 1 ]; then
  echo "Error: Exactly one argument is required." >&2
  usage
fi

TARGET=$1

# Check existence
if [ ! -e "$TARGET" ]; then
  echo "Error: '$TARGET' does not exist." >&2
  exit 2
fi

if [ -f "$TARGET" ]; then
  echo "'$TARGET' is a regular file."
  # wc output: lines words bytes
  lines=$(wc -l < "$TARGET")
  words=$(wc -w < "$TARGET")
  bytes=$(wc -c < "$TARGET")
  echo "Line count : $lines"
  echo "Word count : $words"
  echo "Byte count : $bytes"
elif [ -d "$TARGET" ]; then
  echo "'$TARGET' is a directory."
  # Count total files (regular files only) and *.txt files inside (recursively)
  total_files=$(find "$TARGET" -type f 2>/dev/null | wc -l)
  txt_files=$(find "$TARGET" -type f -name "*.txt" 2>/dev/null | wc -l)
  echo "Total files      : $total_files"
  echo "Text (*.txt) files: $txt_files"
else
  echo "Error: '$TARGET' is neither a regular file nor a directory." >&2
  exit 3
fi

exit 0

