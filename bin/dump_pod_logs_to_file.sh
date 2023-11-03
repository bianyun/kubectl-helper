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

# include common config
source $SCRIPT_DIR/_base/common_config

print_usage() {
  echo ""
  echo "=========================================================================="
  echo "# Dump pod logs to file by specified name (as keyword to search pod name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0-SNAPSHOT"
  echo "# @date 2023/11/3"
  echo "=========================================================================="
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <name> [tail_lines_count]"
  echo ""
  echo "Note:"
  echo "  Default value of optional parameter 'tail_lines_count': $default_tail_lines_count_for_dump_logs"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME nacos"
  echo "  ./$SCRIPT_NAME redis"
  echo "  ./$SCRIPT_NAME uds-gateway"
  echo "  ./$SCRIPT_NAME uds-gateway 100"
  echo "  ./$SCRIPT_NAME uds-gateway 2000"
  echo "  ./$SCRIPT_NAME uds-gateway 2000000"
  echo ""
}


#===================================
# script entry point
#===================================

type=pod
name=$1
tail_lines_count=$default_tail_lines_count_for_dump_logs

[ $# -lt 1 -o $# -gt 2 ] && print_usage && exit 1

if [ $# -eq 2 ]; then
  if [[ ! $2 =~ ^[1-9][0-9]*$ ]]; then
    echo -e "[ERROR] Illegal value for optional argument 'tail_lines_count': [$2]\n" && exit 1
  else
    tail_lines_count=$2
  fi
fi



namespace="default"
res_name=$name

resolve_namespace_and_res_name "dump its logs to file"

out_dir="${SCRIPT_DIR}/_out"
mkdir -p $out_dir

log_filepath="${out_dir}/pod-logs_${res_name}_$(date +'%Y-%m-%d_%H%M%S').log"

echo "=== Dumping pod logs to file for pod '$res_name' ... "
echo ""

cmd_str="kubectl logs"

if [ "$namespace" != "default" ]; then
  cmd_str="$cmd_str -n $namespace"
fi

cmd_str="$cmd_str --tail=$tail_lines_count $res_name > $log_filepath"

echo "=== [DEBUG] About to execute following command: "
echo "[ ${cmd_str} ]"
echo ""
echo "--------------------------------- Command execution result ----------------------------------"
echo ""

eval $cmd_str

echo "=== Pod logs has been successfully dumped to file: "
echo "    [ $log_filepath ]"
echo ""
