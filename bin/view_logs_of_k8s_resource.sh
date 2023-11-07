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
  echo "==========================================================================================="
  echo "# View logs of k8s resources filtered by specified [k8s_resource_type] and [search_keyword]"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0"
  echo "# @date 2023/11/7"
  echo "==========================================================================================="
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <k8s_resource_type> <search_keyword> [tail_size]"
  echo ""
  echo "Note:"
  echo "  - Supported resource types: [$supported_resource_types]"
  echo "  - tail_size: Used in (kubectl logs --tail \$tail_size), default value: [ $default_tail_size_for_logs_view ]"
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
  echo "  ./$SCRIPT_NAME svc uds-gateway 5000"
  echo ""
}

resolve_view_logs_cmd_str() {
  local resource_type=$1
  local selected_resource=$2
  local tail_size=$3
  
  local temp_array=($(split_str_to_array "$selected_resource" "/"))
  local namespace="${temp_array[0]}"
  local resource_name="${temp_array[1]}"

  local cmd_str="kubectl logs"

  if [ "$namespace" != "default" ]; then
    cmd_str="$cmd_str -n $namespace"
  fi

  if [ "$k8s_resource_type" == "pod" ]; then
    cmd_str="${cmd_str} -f --tail=$tail_size $resource_name"
  else
    cmd_str="${cmd_str} --prefix=true -f --tail=$tail_size $resource_type/$resource_name"
  fi
  
  echo "$cmd_str"
}


#====================
# script entry point
#====================

supported_resource_types="pod,service,deployment,statefulset,daemonset,job,cronjob"
involved_k8s_command="kubectl logs"
action_desc="view its logs"

[ $# -lt 2 -o $# -gt 3 ] && print_usage && exit 1

tail_size=$(resolve_tail_size $default_tail_size_for_logs_view $3)
k8s_resource_type=$(normlize_k8s_resource_type $1)
search_keyword=$2

check_if_resource_type_supported_for_k8s_command $k8s_resource_type $supported_resource_types $involved_k8s_command

selected_k8s_resource=$(resolve_single_selected_k8s_resource $k8s_resource_type $search_keyword $action_desc)
cmd_str=$(resolve_view_logs_cmd_str $k8s_resource_type $selected_k8s_resource $tail_size)

execute_command_after_wait_seconds 1 "$cmd_str"
