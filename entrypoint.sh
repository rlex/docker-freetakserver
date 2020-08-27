#!/bin/sh

#verify if we have access to datadir
if ! touch /data/.verify_access; then
  log "ERROR: /data doesn't seem to be writable. Please make sure attached directory is writable by uid=$(id -u)"
  exit 2
fi

#FTS doesn't pre-create logs directory
mkdir -pv /data/logs

FTS_ARGS=""

#set external IP if it's provided via ENV variables
if [ -z ${FTS_ARGS} ]; then
  python -m FreeTAKServer.controllers.FTS
else
  echo "IP Defined: ${FTS_ARGS}"
  python -m FreeTAKServer.controllers.FTS ${FTS_ARGS}
fi