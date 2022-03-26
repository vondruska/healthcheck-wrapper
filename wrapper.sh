
#!/bin/sh

OUTPUT_LOGS=0

if [ "$1" = "--logs" ]; then
  OUTPUT_LOGS=1
  shift;
fi

UUID="$1"
shift

curl -s -m 10 --retry 5 -o /dev/null https://hc-ping.com/$UUID/start
m=$($@ 2>&1)
EXIT_CODE=$?

curl -fsS -m 10 --retry 5 --data-raw "$m" -o /dev/null https://hc-ping.com/$UUID/$EXIT_CODE

if [ $OUTPUT_LOGS -eq 1 ]; then
  echo $m
fi

exit $EXIT_CODE
