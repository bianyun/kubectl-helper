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
  echo "================================================================================="
  echo "# Restart k8s deployment by specified name (as keyword to search deployment name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0-SNAPSHOT"
  echo "# @date 2023/11/3"
  echo "================================================================================="
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <name>"
  echo "  ./$SCRIPT_NAME all <namespace>"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME webui"
  echo "  ./$SCRIPT_NAME nacos"
  echo "  ./$SCRIPT_NAME all uds"
  echo ""
}


#===================================
# script entry point
#===================================

type=deployment

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  print_usage && exit 1
fi

if [ $# -eq 2 ] && [ "$1" != "all" ]; then
  print_usage && exit 1
fi

if [ $# -eq 1 ] && [ "$1" == "all" ]; then
  print_usage && exit 1
fi

$SCRIPT_DIR/_base/do_restart_k8s_resource.sh $type $@
