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
source $SCRIPT_DIR/common_func


print_usage() {
  echo ""
  echo "============================================================================================"
  echo "# View logs of k8s resource by specified type and name (as keyword to search resource name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.0.0"
  echo "# @date 2023/10/10"
  echo "============================================================================================"
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <type> <name>"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME node 10.1.76.1"
  echo "  ./$SCRIPT_NAME pv uds-es"
  echo "  ./$SCRIPT_NAME pvc uds-es"
  echo "  ./$SCRIPT_NAME pod nacos"
  echo "  ./$SCRIPT_NAME svc redis"
  echo "  ./$SCRIPT_NAME endpoints uds-es"
  echo "  ./$SCRIPT_NAME deployment uds-es"
  echo ""
}


#===================================
# script entry point
#===================================

type=$1
name=$2

if [ $# -ne 2 ] || [[ ! "$type" =~ ^(pod|svc|deploy|deployment)$ ]]; then
  print_usage
  exit 1
fi

namespace="default"
res_name=$name

resolve_namespace_and_res_name "view its logs"

kubectl logs -n $namespace -f --tail 5000 $type/$res_name
