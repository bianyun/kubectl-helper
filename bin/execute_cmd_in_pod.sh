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

# include common func
source $SCRIPT_DIR/_base/common_func


print_usage() {
  echo ""
  echo "==============================================================================="
  echo "# Execute command inside pod by specified name (as keyword to search pod name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0-SNAPSHOT"
  echo "# @date 2023/10/10"
  echo "==============================================================================="
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <name> <command>"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME nacos date"
  echo "  ./$SCRIPT_NAME redis ls -l /usr"
  echo "  ./$SCRIPT_NAME uds-es cat /etc/hosts"
  echo ""
}


#===================================
# script entry point
#===================================

type=pod
name=$1
command="${@:2}"

if [ $# -lt 2 ] || [ "$command" == "" ]; then
  print_usage && exit 1
fi

namespace="default"
res_name=$name

resolve_namespace_and_res_name "execute your command"

kubectl exec $type/$res_name -n $namespace -it -- $command

echo ""
