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

# include common functions
source $SCRIPT_DIR/common_func
# include common config
source $SCRIPT_DIR/common_config


print_usage() {
  echo ""
  echo "============================================================================================"
  echo "# View logs of k8s resource by specified type and name (as keyword to search resource name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0-SNAPSHOT"
  echo "# @date 2023/11/3"
  echo "============================================================================================"
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <type> <name> [tail_lines_count]"
  echo ""
  echo "Note:"
  echo "  Default value of optional parameter 'tail_lines_count': $default_tail_lines_count_for_view_logs"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME pod uds-es"
  echo "  ./$SCRIPT_NAME pods uds-es"
  echo "  ./$SCRIPT_NAME svc uds-es"
  echo "  ./$SCRIPT_NAME service uds-es"
  echo "  ./$SCRIPT_NAME services uds-es"
  echo "  ./$SCRIPT_NAME deploy job-executor"
  echo "  ./$SCRIPT_NAME deployment job-executor"
  echo "  ./$SCRIPT_NAME deployments job-executor"
  echo "  ./$SCRIPT_NAME pod uds-es 50"
  echo "  ./$SCRIPT_NAME pod uds-es 2000"
  echo ""
}


#===================================
# script entry point
#===================================

type=${1,,}
name=$2

[ $# -lt 2 -o $# -gt 3 ] && print_usage && exit 1

tail_lines_count=$default_tail_lines_count_for_view_logs

if [ $# -eq 3 ]; then
  if [[ ! $3 =~ ^[1-9][0-9]*$ ]]; then
    echo -e "[ERROR] Illegal argument 'tail_lines_count': [$3]\n" && exit 1
  else
    tail_lines_count=$3
  fi
fi


if [[ "$type" =~ ^(pod|pods)$ ]]; then
  type="pod"
elif [[ "$type" =~ ^(svc|service|services)$ ]]; then
  type="service"
elif [[ "$type" =~ ^(deploy|deployment|deployments)$ ]]; then
  type="deployment"
else
  echo -e "[ERROR] Unsupported k8s resource type for view logs: [$1]\n" && exit 1
fi

namespace="default"
res_name=$name

resolve_namespace_and_res_name "view its logs"

cmd_str="kubectl logs"

if [ "$namespace" != "default" ]; then
  cmd_str="$cmd_str -n $namespace"
fi

if [[ "$type" =~ ^(service|deployment)$ ]]; then
  cmd_str="${cmd_str} --prefix=true -f --tail=$tail_lines_count $type/$res_name"
elif [ "$type" == "pod" ]; then
  cmd_str="${cmd_str} -f --tail=$tail_lines_count $res_name"
fi

echo -e "=== [DEBUG] About to execute command after 3 seconds: [ $cmd_str ]\n"
echo "--------------------------------- Command execution result ----------------------------------"
echo ""

sleep 3

eval $cmd_str
