#!/bin/bash

# logparser.sh
# Parse a log file, count INFO/WARNING/ERROR lines,
# show the most recent ERROR, and write a summary file.

usage() {
  echo "Usage: $0 <log_file>" >&2
  exit 1
}

if [ "$#" -ne 1 ]; then
  echo "Error: Exactly one argument (log file) is required." >&2
  usage
fi

LOGFILE=$1

if [ ! -e "$LOGFILE" ]; then
  echo "Error: '$LOGFILE' does not exist." >&2
  exit 2
fi

if [ ! -r "$LOGFILE" ]; then
  echo "Error: '$LOGFILE' is not readable." >&2
  exit 3
fi

info_count=$(grep -c "INFO" "$LOGFILE" 2>/dev/null || echo 0)
warn_count=$(grep -c "WARNING" "$LOGFILE" 2>/dev/null || echo 0)
error_count=$(grep -c "ERROR" "$LOGFILE" 2>/dev/null || echo 0)

recent_error=$(grep "ERROR" "$LOGFILE" | tail -n 1)

summary_file="logsummary_$(date +%Y%m%d_%H%M%S).txt"

{
  echo "Log summary for: $LOGFILE"
  echo "Generated on   : $(date)"
  echo
  echo "INFO lines   : $info_count"
  echo "WARNING lines: $warn_count"
  echo "ERROR lines  : $error_count"
  echo
  if [ -n "$recent_error" ]; then
    echo "Most recent ERROR:"
    echo "$recent_error"
  else
    echo "Most recent ERROR: None found."
  fi
} > "$summary_file"

echo "INFO count   : $info_count"
echo "WARNING count: $warn_count"
echo "ERROR count  : $error_count"

if [ -n "$recent_error" ]; then
  echo "Most recent ERROR:"
  echo "$recent_error"
else
  echo "No ERROR entries were found in the log."
fi

echo "Summary written to: $summary_file"

exit 0

