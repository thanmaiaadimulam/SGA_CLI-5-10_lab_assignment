#!/bin/bash

# emailcleaner.sh
# Separate valid and invalid email addresses based on a simple regex:
# <letters_digits>@<letters>.com

INPUT_FILE="emails.txt"
VALID_FILE="valid.txt"
INVALID_FILE="invalid.txt"

if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: '$INPUT_FILE' not found in current directory." >&2
  exit 1
fi

# Clear previous outputs
> "$VALID_FILE"
> "$INVALID_FILE"

while IFS= read -r email; do
  # Skip empty lines
  if [ -z "$email" ]; then
    continue
  fi

  if echo "$email" | grep -E -qi '^[A-Za-z0-9]+@[A-Za-z]+\.com$'; then
    echo "$email" >> "$VALID_FILE"
  else
    echo "$email" >> "$INVALID_FILE"
  fi
done < "$INPUT_FILE"

# Remove duplicates from valid emails (case-sensitive)
sort "$VALID_FILE" | uniq > "${VALID_FILE}.tmp" && mv "${VALID_FILE}.tmp" "$VALID_FILE"

echo "Valid emails written to   : $VALID_FILE"
echo "Invalid emails written to : $INVALID_FILE"

exit 0

