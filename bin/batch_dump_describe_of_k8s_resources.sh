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

# include common config
source $SCRIPT_DIR/_base/common_config

# include common func
source $SCRIPT_DIR/_base/common_func

print_usage() {
  echo ""
  echo "====================================================================================================="
  echo "# Batch dump describe of k8s resources filtered by specified [k8s_resource_type] and [search_keyword]"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0-SNAPSHOT"
  echo "# @date 2023/11/7"
  echo "====================================================================================================="
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <k8s_resource_type> <search_keyword>"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME node 10.1.76."
  echo "  ./$SCRIPT_NAME ns uds"
  echo "  ./$SCRIPT_NAME ds kube"
  echo "  ./$SCRIPT_NAME pod redis"
  echo "  ./$SCRIPT_NAME svc redis"
  echo "  ./$SCRIPT_NAME deploy uds-gateway"
  echo "  ./$SCRIPT_NAME endpoints uds-es"
  echo ""
}


#====================
# script entry point
#====================

[ $# -ne 2 ] && print_usage && exit 1

global_out_dir_path=$SCRIPT_DIR/$global_out_dir_name
k8s_resource_type=$(normlize_k8s_resource_type $1)
name=$2
dump_type="describe"

selected_k8s_resources=$(resolve_multiple_selected_k8s_resources $k8s_resource_type $name)

dump_resource_info_of_selected_k8s_resources $k8s_resource_type $name $dump_type "$selected_k8s_resources"
