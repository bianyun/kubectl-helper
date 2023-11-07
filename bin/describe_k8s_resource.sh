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
  echo "=============================================================================================="
  echo "# Describe k8s resource by specified type and search keyword (used for selecting k8s resource)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0"
  echo "# @date 2023/11/7"
  echo "=============================================================================================="
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
  echo "  ./$SCRIPT_NAME deploy uds-es"
  echo "  ./$SCRIPT_NAME endpoints uds-es"
  echo ""
}

resolve_cmd_str() {
  local resource_type=$1
  local selected_resource=$2
  local base_cmd_str="$3"
  
  local type_support_namespace=$(check_if_resource_type_support_namespace $resource_type)

  local result_cmd_str="$base_cmd_str"
  
  local resource_name=""
  if [ $type_support_namespace == "true" ]; then
    local temp_array=($(split_str_to_array "$selected_resource" "/"))
    local namespace="${temp_array[0]}"
    resource_name="${temp_array[1]}"
    
    if [ "$namespace" != "default" ]; then
      result_cmd_str="$result_cmd_str -n $namespace"
    fi
  else
    resource_name=$selected_resource
  fi

  result_cmd_str="$result_cmd_str $resource_type/$resource_name"
  echo $result_cmd_str
}

#====================
# script entry point
#====================

base_cmd_str="kubectl describe"
action_desc="describe it"

[ $# -ne 2 ] && print_usage && exit 1

k8s_resource_type=$(normlize_k8s_resource_type $1)
search_keyword=$2

selected_k8s_resource=$(resolve_single_selected_k8s_resource $k8s_resource_type $search_keyword $action_desc)
cmd_str=$(resolve_cmd_str $k8s_resource_type $selected_k8s_resource "$base_cmd_str")

execute_command_after_wait_seconds 1 "$cmd_str"
