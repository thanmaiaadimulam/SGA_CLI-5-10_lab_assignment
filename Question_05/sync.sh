#!/bin/bash

# sync.sh
# Compare two directories and report:
# - Files unique to each directory
# - For common files, whether contents match or differ

usage() {
  echo "Usage: $0 <dirA> <dirB>" >&2
  exit 1
}

if [ "$#" -ne 2 ]; then
  echo "Error: Exactly two directory arguments are required." >&2
  usage
fi

DIR_A=$1
DIR_B=$2

if [ ! -d "$DIR_A" ]; then
  echo "Error: '$DIR_A' is not a directory or does not exist." >&2
  exit 2
fi

if [ ! -d "$DIR_B" ]; then
  echo "Error: '$DIR_B' is not a directory or does not exist." >&2
  exit 3
fi

echo "Comparing '$DIR_A' and '$DIR_B'"
echo

# List file basenames (non-recursive) in each directory
list_files() {
  local dir=$1
  (cd "$dir" && for f in *; do
    [ -f "$f" ] && echo "$f"
  done)
}

FILES_A=$(list_files "$DIR_A" | sort)
FILES_B=$(list_files "$DIR_B" | sort)

tmp_a=$(mktemp)
tmp_b=$(mktemp)

echo "$FILES_A" > "$tmp_a"
echo "$FILES_B" > "$tmp_b"

echo "Files only in $DIR_A:"
comm -23 "$tmp_a" "$tmp_b"
echo

echo "Files only in $DIR_B:"
comm -13 "$tmp_a" "$tmp_b"
echo

echo "Common files and content comparison:"
comm -12 "$tmp_a" "$tmp_b" | while read -r fname; do
  if cmp -s "$DIR_A/$fname" "$DIR_B/$fname"; then
    echo "  $fname : MATCH"
  else
    echo "  $fname : DIFFER"
  fi
done

rm -f "$tmp_a" "$tmp_b"

exit 0

