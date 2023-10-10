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
  echo "=========================================================================="
  echo "# Dump pod logs to file by specified name (as keyword to search pod name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.0.0"
  echo "# @date 2023/10/10"
  echo "=========================================================================="
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

type=pod
name=$1

[ $# -ne 1 ] && print_usage && exit 1

namespace="default"
res_name=$name

resolve_namespace_and_res_name "dump its logs to file"

pod_logs_dump_dir="${SCRIPT_DIR}/pod_logs_dump"
mkdir -p $pod_logs_dump_dir

log_filepath="${pod_logs_dump_dir}/${res_name}_$(date +'%Y-%m-%d_%H%M').log"

echo "=== Dumping pod logs to file for pod [$res_name]... "

kubectl logs -n $namespace --tail 500000 $type/$res_name > $log_filepath

echo "=== Pod logs has been successfully dumped to file: "
echo "    [$log_filepath]"
echo ""
