#!/bin/sh

#verify if we have access to datadir
if ! touch /data/.verify_access; then
  log "ERROR: /data doesn't seem to be writable. Please make sure attached directory is writable by uid=$(id -u)"
  exit 2
fi

#set external IP if it's provided via ENV variables
if [ -z ${DATAPACKAGE_SERVER_IP} ]; then
  python -m FreeTAKServer.controllers.Orchestrator
else
  echo "IP Defined: ${DATAPACKAGE_SERVER_IP}"
  python -m FreeTAKServer.controllers.Orchestrator -IP ${DATAPACKAGE_SERVER_IP}
fi