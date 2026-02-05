#!/bin/bash

# patterns.sh
# Categorize words (case-insensitive) into:
# - Only vowels      -> vowels.txt
# - Only consonants  -> consonants.txt
# - Mixed (start with consonant and contain vowels) -> mixed.txt

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <words_file>" >&2
  exit 1
fi

INPUT_FILE=$1

if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: '$INPUT_FILE' not found." >&2
  exit 2
fi

VOWELS_FILE="vowels.txt"
CONSONANTS_FILE="consonants.txt"
MIXED_FILE="mixed.txt"

> "$VOWELS_FILE"
> "$CONSONANTS_FILE"
> "$MIXED_FILE"

while IFS= read -r word; do
  # Skip empty lines
  if [ -z "$word" ]; then
    continue
  fi

  # Normalize for matching (but preserve original in output)
  w="$word"

  # Only vowels
  if echo "$w" | grep -Eqi '^[aeiou]+$'; then
    echo "$word" >> "$VOWELS_FILE"
  # Only consonants (letters but no vowels)
  elif echo "$w" | grep -Eqi '^[bcdfghjklmnpqrstvwxyz]+$'; then
    echo "$word" >> "$CONSONANTS_FILE"
  else
    # Mixed: starts with consonant and contains at least one vowel and one consonant
    if echo "$w" | grep -Eqi '^[bcdfghjklmnpqrstvwxyz]' && \
       echo "$w" | grep -Eqi '[aeiou]' && \
       echo "$w" | grep -Eqi '[bcdfghjklmnpqrstvwxyz]'; then
      echo "$word" >> "$MIXED_FILE"
    fi
  fi
done < "$INPUT_FILE"

echo "Vowel-only words written to     : $VOWELS_FILE"
echo "Consonant-only words written to : $CONSONANTS_FILE"
echo "Mixed words written to          : $MIXED_FILE"

exit 0

