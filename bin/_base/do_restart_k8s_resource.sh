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
# include common config
source $SCRIPT_DIR/common_config


print_usage() {
  echo ""
  echo "======================================================================================"
  echo "# Restart k8s resource by specified type and name (as keyword to search resource name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0-SNAPSHOT"
  echo "# @date 2023/11/3"
  echo "======================================================================================"
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <type> <name>"
  echo "  ./$SCRIPT_NAME <type> all <namespace>"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME deploy nacos"
  echo "  ./$SCRIPT_NAME deploy redis"
  echo "  ./$SCRIPT_NAME deploy uds-es"
  echo "  ./$SCRIPT_NAME deploy all uds (restart ALL deploys under namespace [uds])"
  echo "  ./$SCRIPT_NAME daemonset dns"
  echo "  ./$SCRIPT_NAME daemonset all kube-system"
  echo ""
}


#===================================
# script entry point
#===================================

type=$1
name=$2

if [ $# -lt 2 ] || [ $# -gt 3 ]; then
  print_usage && exit 1
fi

if [ $# -eq 3 ] && [ "$2" != "all" ]; then
  print_usage && exit 1
fi

if [ $# -eq 2 ] && [ "$2" == "all" ]; then
  print_usage && exit 1
fi


if [[ "$type" =~ ^(deploy|deployment|deployments)$ ]]; then
  type="deployment"
elif [[ "$type" =~ ^(ds|daemonset|daemonsets)$ ]]; then
  type="daemonset"
elif [[ "$type" =~ ^(sts|statefulset|statefulsets)$ ]]; then
  type="statefulset"
else
  echo -e "[ERROR] Unsupported k8s resource type for restart: [$1]\n" && exit 1
fi


if [ $# -eq 3 ]; then
  namespace=$3
  kubectl get ns $namespace > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    valid_namespaces=$(kubectl get ns | awk 'NR>1' | awk '{print $1}' |tr '\n' ' ')
    echo -e "[ERROR] Invalid namespace [$namespace], valid namespaces are as follows:"
    echo "        [ $valid_namespaces ]"
    echo "" && exit 1
  fi
  
  if [ $namespace == "kube-system" ] && [ $allow_restart_kube_system_resource != "true" ]; then
    echo -e "=== [WARN] Do not allow restarting of ${type}s under namespace [kube-system]\n" && exit 1
  fi
  
  cmd_str="kubectl get $type | awk 'NR>1' | awk '{print $1}' | xargs -I {} kubectl rollout restart $type {}"

  if [ "$namespace" != "default" ]; then
    cmd_str="kubectl get $type -n $namespace | awk 'NR>1' | awk '{print \$1}' | xargs -I {} kubectl rollout restart $type -n $namespace {}"
  fi

  echo -e "=== [DEBUG] About to execute command after 3 seconds: [ $cmd_str ]\n"
  echo "--------------------------------- Command execution result ----------------------------------"
  echo ""

  sleep 3
  eval $cmd_str
  exit 0
fi

namespace="default"
res_name=$name

resolve_namespace_and_res_name "restart it"

if [ $namespace == "kube-system" ] && [ $allow_restart_kube_system_resource != "true" ]; then
  echo -e "=== [WARN] Do not allow restarting of ${type}s under namespace [kube-system]\n" && exit 1
fi

cmd_str="kubectl rollout restart"

if [ "$namespace" != "default" ]; then
  cmd_str="$cmd_str -n $namespace"
fi

cmd_str="$cmd_str $type/$res_name"

echo -e "=== [DEBUG] About to execute command after 3 seconds: [ $cmd_str ]\n"
echo "--------------------------------- Command execution result ----------------------------------"
echo ""

sleep 3
eval $cmd_str