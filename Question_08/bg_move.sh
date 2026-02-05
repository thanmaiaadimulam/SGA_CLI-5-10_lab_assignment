#!/bin/bash

# bg_move.sh
# Move files into backup/ using a background process.

usage() {
  echo "Usage: $0 <source_directory>" >&2
  exit 1
}

if [ "$#" -ne 1 ]; then
  echo "Error: Exactly one argument (source directory) is required." >&2
  usage
fi

SRC_DIR=$1
BACKUP_DIR="backup"

if [ ! -d "$SRC_DIR" ]; then
  echo "Error: '$SRC_DIR' is not a directory or does not exist." >&2
  exit 2
fi

mkdir -p "$BACKUP_DIR"

echo "Starting background move from '$SRC_DIR' to '$BACKUP_DIR'..."

mv "$SRC_DIR"/* "$BACKUP_DIR"/ 2>/dev/null &
bg_pid=$!

echo "Background mv PID: $bg_pid"

wait "$bg_pid"
status=$?

if [ $status -eq 0 ]; then
  echo "Background move completed successfully."
else
  echo "Background move finished with status $status (possibly no files to move)."
fi

exit $status

