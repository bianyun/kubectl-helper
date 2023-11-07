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
  echo "==============================================================="
  echo "# Enter selected k8s pod filtered by specified [search_keyword]"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.2.0-SNAPSHOT"
  echo "# @date 2023/11/7"
  echo "==============================================================="
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <search_keyword>"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME nacos"
  echo "  ./$SCRIPT_NAME redis"
  echo "  ./$SCRIPT_NAME uds-es"
  echo ""
}

resolve_cmd_str() {
  local selected_resource=$1
  local base_cmd_str="$2"
  
  local temp_array=($(split_str_to_array "$selected_resource" "/"))
  local namespace="${temp_array[0]}"
  local resource_name="${temp_array[1]}"

  local result_cmd_str="$base_cmd_str"

  if [ "$namespace" != "default" ]; then
    result_cmd_str="$result_cmd_str -n $namespace"
  fi

  result_cmd_str="$result_cmd_str $resource_name"

  kubectl exec $resource_name -n $namespace -i -- sh -c 'which bash || type bash' >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    result_cmd_str="$result_cmd_str -- bash"
  else
    result_cmd_str="$result_cmd_str -- sh"
  fi
  
  echo $result_cmd_str
}


#====================
# script entry point
#====================

k8s_resource_type="pod"
base_cmd_str="kubectl exec -it"
action_desc="enter in it"

[ $# -ne 1 ] && print_usage && exit 1

search_keyword=$1

selected_k8s_resource=$(resolve_single_selected_k8s_resource $k8s_resource_type $search_keyword $action_desc)
cmd_str=$(resolve_cmd_str $selected_k8s_resource "$base_cmd_str")

execute_command_immediately "$cmd_str" "NOTE: The part below is inside the container"