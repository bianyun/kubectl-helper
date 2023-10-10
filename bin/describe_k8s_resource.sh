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
  echo "========================================================================================"
  echo "# Describe k8s resource by specified type and name (as keyword to search resource name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.0.0-SNAPSHOT"
  echo "# @date 2023/10/10"
  echo "========================================================================================"
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <k8s_res_type> <name>"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME node 10.1.76."
  echo "  ./$SCRIPT_NAME ns uds"
  echo "  ./$SCRIPT_NAME ds kube"
  echo "  ./$SCRIPT_NAME pod redis"
  echo "  ./$SCRIPT_NAME svc redis"
  echo "  ./$SCRIPT_NAME deploy uds-es"
  echo "  ./$SCRIPT_NAME endpoints uds-es"
  echo ""
}


#===================================
# script entry point
#===================================

type=$1
name=$2

[ $# -ne 2 ] && print_usage && exit 1

k8s_res_list=$(kubectl get $type -A > /dev/null 2>&1)
[ $? -ne 0 ] && echo -e "[ERROR] Unsupported k8s resource type: [$type]\n" && exit 1

namespace="default"
res_name=$name

resolve_namespace_and_res_name "describe it"

kubectl describe -n $namespace $type $res_name && echo ""
