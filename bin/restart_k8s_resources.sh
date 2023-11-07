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
  echo "====================================================================================="
  echo "# Restart k8s resource filtered by specified [k8s_resource_type] and [search_keyword]"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0"
  echo "# @date 2023/11/7"
  echo "====================================================================================="
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <k8s_resource_type> <search_keyword>"
  echo "  ./$SCRIPT_NAME <k8s_resource_type> all <namespace>"
  echo ""
  echo "Note:"
  echo "  - Supported k8s resource types: [$supported_resource_types]"
  echo "  - Restarting k8s resources under namespace [kube-system] is prohibited by default"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME deploy nacos"
  echo "  ./$SCRIPT_NAME deploy redis"
  echo "  ./$SCRIPT_NAME deploy uds"
  echo "  ./$SCRIPT_NAME daemonset dns"
  echo "  ./$SCRIPT_NAME statefulset uds"
  echo "  ./$SCRIPT_NAME deploy all uds"
  echo "  ./$SCRIPT_NAME daemonset all kube-system"
  echo ""
}

check_if_restarting_kube_system_resources() {
  local resource_type=$1
  local namespace=$2
  
  if [ $namespace == "kube-system" ] && [ $allow_restart_kube_system_resource != "true" ]; then
    echo "=== [WARN] Do not allow restart of ${resource_type}s under namespace [kube-system]" && exitscript
  fi
}

batch_restart_resources() {
  local resource_type=$1
  local namespace="${2,,}"

  kubectl get ns $namespace > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    valid_namespaces=$(kubectl get ns | awk 'NR>1' | awk '{print $1}' |tr '\n' ' ')
    echo "=== [ERROR] Invalid namespace [$2], valid namespaces are as follows: [ $valid_namespaces ]"
    exitscript
  fi

  check_if_restarting_kube_system_resources $resource_type $namespace
  
  local resource_count=$(kubectl get $resource_type -n $namespace 2> /dev/null | wc -l)
  if [ $resource_count -eq 0 ]; then
    echo "=== [WARN] No ${resource_type}s found in [$namespace] namespace." && exitscript
  fi
  
  echo ""
  while : ; do
    read -n1 -p "=== Do you want to restart all the ${resource_type}s under [$namespace] namespace? [y/n]: " whether_continue
    case $whether_continue in 
      Y|y)
          echo ""
          break
          ;;
      N|n)
          echo -e "\n" && exit 0
          ;;
      *) 
          if [ "$whether_continue" != "" ]; then
            echo ""
          fi
          ;;
    esac
  done
  
  cmd_str="kubectl get $resource_type -n $namespace | awk 'NR>1' | awk '{print \$1}' | xargs -I {} kubectl rollout restart $resource_type -n $namespace {}"
  
  execute_command_immediately "$cmd_str"
}

restart_selected_k8s_resource() {
  local resource_type=$1
  local search_keyword=$2
  local action_desc="${@:3}"
  
  local selected_k8s_resource=$(resolve_single_selected_k8s_resource $k8s_resource_type $search_keyword $action_desc)

  local temp_array=($(split_str_to_array "$selected_k8s_resource" "/"))
  local namespace="${temp_array[0]}"
  local resource_name="${temp_array[1]}"

  check_if_restarting_kube_system_resources $resource_type $namespace

  cmd_str="kubectl rollout restart -n $namespace $resource_type/$resource_name"

  execute_command_immediately "$cmd_str"
}


#====================
# script entry point
#====================

supported_resource_types="deployment, daemonset, statefulset"
involved_k8s_command="kubectl rollout restart"
action_desc="restart it"


if [ $# -lt 2 ] || [ $# -gt 3 ]; then
  print_usage && exit 1
fi

if [ $# -eq 3 ] && [ "$2" != "all" ]; then
  print_usage && exit 1
fi

if [ $# -eq 2 ] && [ "$2" == "all" ]; then
  print_usage && exit 1
fi


k8s_resource_type=$(normlize_k8s_resource_type $1)
search_keyword=$2

supported_resource_types=$(remove_all_blanks_from_str $supported_resource_types)
check_if_resource_type_supported_for_k8s_command $k8s_resource_type $supported_resource_types $involved_k8s_command

if [ $# -eq 3 ]; then
  # Batch restart all resources with specified type under specified namespace.
  batch_restart_resources $k8s_resource_type $3
else 
  restart_selected_k8s_resource $k8s_resource_type $search_keyword $action_desc
fi
