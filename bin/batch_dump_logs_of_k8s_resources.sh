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
  echo "================================================================================================="
  echo "# Batch dump logs of k8s resources filtered by specified [k8s_resource_type] and [search_keyword]"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0"
  echo "# @date 2023/11/7"
  echo "================================================================================================="
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <k8s_resource_type> <search_keyword> [tail_size]"
  echo ""
  echo "Note:"
  echo "  - Supported resource types: [$supported_resource_types]"
  echo "  - tail_size: Used in (kubectl logs --tail \$tail_size), default value: [ $default_tail_size_for_logs_dump ]"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME pod uds"
  echo "  ./$SCRIPT_NAME svc uds-es"
  echo "  ./$SCRIPT_NAME deploy gateway"
  echo "  ./$SCRIPT_NAME sts uds"
  echo "  ./$SCRIPT_NAME ds dns"
  echo "  ./$SCRIPT_NAME job uds"
  echo "  ./$SCRIPT_NAME cj uds"
  echo ""
  echo "  ./$SCRIPT_NAME pod uds-metadata 2000"
  echo "  ./$SCRIPT_NAME svc uds-gateway 2000000"
  echo ""
}


#====================
# script entry point
#====================

supported_resource_types="pod, service, deployment, statefulset, daemonset, job, cronjob"
involved_k8s_command="kubectl logs"

global_out_dir_path=$SCRIPT_DIR/$global_out_dir_name
k8s_resource_type="pod"
dump_type="logs"

[ $# -lt 2 -o $# -gt 3 ] && print_usage && exit 1

tail_size=$(resolve_tail_size $default_tail_size_for_logs_dump $3)

k8s_resource_type=$(normlize_k8s_resource_type $1)
search_keyword=$2

supported_resource_types=$(remove_all_blanks_from_str $supported_resource_types)
check_if_resource_type_supported_for_k8s_command $k8s_resource_type $supported_resource_types $involved_k8s_command

selected_k8s_resources=$(resolve_multiple_selected_k8s_resources $k8s_resource_type $search_keyword)

dump_resource_info_of_selected_k8s_resources $k8s_resource_type $search_keyword $dump_type "$selected_k8s_resources"
