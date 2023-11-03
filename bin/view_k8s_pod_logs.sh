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


print_usage() {
  echo ""
  echo "========================================================================"
  echo "# View logs of k8s pod by specified name (as keyword to search pod name)"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.1.0-SNAPSHOT"
  echo "# @date 2023/11/3"
  echo "========================================================================"
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <name> [tail_lines_count]"
  echo ""
  echo "Note:"
  echo "  Default value of optional parameter 'tail_lines_count': $default_tail_lines_for_view_logs"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME nacos"
  echo "  ./$SCRIPT_NAME redis"
  echo "  ./$SCRIPT_NAME uds-es"
  echo "  ./$SCRIPT_NAME uds-es 50"
  echo "  ./$SCRIPT_NAME uds-es 2000"
  echo ""
}


#===================================
# script entry point
#===================================

type=pod
name=$1

[ $# -lt 1 -o $# -gt 2 ] && print_usage && exit 1

if [ $# -eq 2 ]; then
  if [[ ! $2 =~ ^[1-9][0-9]*$ ]]; then
    echo -e "[ERROR] Illegal value for optional argument 'tail_lines_count': [$2]\n" && exit 1
  fi
fi

$SCRIPT_DIR/_base/do_view_k8s_resource_logs.sh $type $name $2
