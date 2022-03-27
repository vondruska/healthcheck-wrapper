# healthchecks.io Shell Wrapper
A wrapper surrounding shell scripts to track script start/stop, logs and failures and push into healthchecks.io. Typically used within a cron job.

## Usage
`wrapper.sh [--logs] [healthcheck uuid] command...`

By default, the wrapper will automatically redirect log output to upload into healthchecks.io. Meaning no output. If you want to have logs outputted, use `--logs`.

The wrapper will trigger a [`start` event](https://healthchecks.io/docs/http_api/#start-uuid), execute the `command` then send the exit code with captured output to healthchecks.io.
