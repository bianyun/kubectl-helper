#!/usr/bin/env bash

SCRIPT_PATH="${0}"
while [ -h "${SCRIPT_PATH}" ]; do
  LS=$(ls -ld "${SCRIPT_PATH}")
  LINK=$(expr "${LS}" : '.*-> \(.*\)$')
  if [ "$(expr "${LINK}" : '/.*')" -gt 1 ]; then
    SCRIPT_PATH="${LINK}"
  else
    SCRIPT_PATH="$(dirname "${SCRIPT_PATH}")/${LINK}"
  fi
done
cd "$(dirname "${SCRIPT_PATH}")" > /dev/null || { echo "=== ERROR: failed to change directory to [$(dirname "${SCRIPT_PATH}")"]; exit 1; }
SCRIPT_DIR=$(pwd)
SCRIPT_NAME=$(basename $SCRIPT_PATH)


print_usage() {
  echo ""
  echo "====================================================================="
  echo "# View logs of svc by specified name (as keyword to search svc name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0-SNAPSHOT"
  echo "# @date 2023/10/10"
  echo "====================================================================="
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <name>"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME nacos"
  echo "  ./$SCRIPT_NAME redis"
  echo "  ./$SCRIPT_NAME uds-es"
  echo ""
}


#===================================
# script entry point
#===================================

type=svc
name=$1

[ $# -ne 1 ] && print_usage && exit 1

$SCRIPT_DIR/_base/do_view_k8s_resource_logs.sh $type $name
