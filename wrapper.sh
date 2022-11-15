#!/bin/sh

OUTPUT_LOGS=0

if [ "$1" = "--logs" ]; then
  OUTPUT_LOGS=1
  shift;
fi

UUID="$1"
shift

curl -s -m 10 --retry 5 -o /dev/null https://hc-ping.com/"$UUID"/start
OUTPUT=$("$@" 2>&1)
EXIT_CODE=$?

# Remove ANSI codes
# Adapted from https://stackoverflow.com/a/30938702
OUTPUT_FILTERED=$(echo "$OUTPUT" | sed -r "s/\x1B\[(([0-9]{1,2})?(;)?([0-9]{1,2})?)?[m,K,H,f,J]//g")

curl -fsS -m 10 --retry 5 --data "$OUTPUT_FILTERED" -o /dev/null https://hc-ping.com/"$UUID"/"$EXIT_CODE"

if [ $OUTPUT_LOGS -eq 1 ]; then
  echo "$OUTPUT"
fi

exit $EXIT_CODE
