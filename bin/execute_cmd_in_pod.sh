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
  echo "==============================================================================="
  echo "# Execute command inside pod by specified name (as keyword to search pod name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0-SNAPSHOT"
  echo "# @date 2023/11/3"
  echo "==============================================================================="
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <name> <\"command_str\">"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME uds-es \"date +'%Y-%m-%d %H:%M:%S'\""
  echo "  ./$SCRIPT_NAME uds-es \"cat /etc/os-release\""
  echo "  ./$SCRIPT_NAME uds-es \"cat /etc/hosts |grep 127.0.0.1\""
  echo "  ./$SCRIPT_NAME uds-es \"ls -l /usr\""
  echo "  ./$SCRIPT_NAME uds-es \"ls -l --color=auto / |grep usr\""
  echo "  ./$SCRIPT_NAME uds-es \"ps -ef |grep -v share\""
  echo ""
}


#===================================
# script entry point
#===================================

type=pod
name=$1
command="${@:2}"

if [ $# -lt 2 ] || [ "$command" == "" ]; then
  print_usage && exit 1
fi

namespace="default"
res_name=$name

resolve_namespace_and_res_name "execute your command"

cmd_str="kubectl exec -it"

if [ "$namespace" != "default" ]; then
  cmd_str="$cmd_str -n $namespace"
fi

cmd_str="$cmd_str $res_name -- $command"

echo -e "=== [DEBUG] About to execute command: [ $cmd_str ]\n"
echo "--------------------------------- Command execution result ----------------------------------"
echo ""

eval $cmd_str && echo ""
