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


print_usage() {
  echo ""
  echo "============================================"
  echo "# Setup aliases for common kubectl commands"
  echo "# "
  echo "# @author bianyun"
  echo "# @version 1.0.0"
  echo "# @date 2023/10/10"
  echo "============================================"
  echo ""
  echo "Usage:"
  echo "  ./$SCRIPT_NAME <init|list>"
  echo "  ./$SCRIPT_NAME get <alias_name>"
  echo ""
  echo "Examples:"
  echo "  ./$SCRIPT_NAME init"
  echo "  ./$SCRIPT_NAME list"
  echo "  ./$SCRIPT_NAME get ktn"
  echo "  ./$SCRIPT_NAME get kgn"
  echo "  ./$SCRIPT_NAME get kgp"
  echo "  ./$SCRIPT_NAME get kgs"
  echo "  ./$SCRIPT_NAME get kge"
  echo "  ./$SCRIPT_NAME get kgd"
  echo "  ./$SCRIPT_NAME get kgpu"
  echo "  ./$SCRIPT_NAME get kgpwa"
  echo ""
}


#===================================
# script entry point
#===================================

[ $# -lt 1 -o $# -gt 2 ] && print_usage && exit 1

if [ $# -eq 1 ]; then
  [ "$1" != "init" -a "$1" != "list" ] && print_usage && exit 1
elif [ $# -eq 2 ]; then
  [ "$1" != "get" ] && print_usage && exit 1
fi

command=$1

alias_script_src_filepath="$SCRIPT_DIR/_base/kubectl_alias.sh"
alias_script_target_filepath="/etc/profile.d/kubectl_alias.sh"

if [ "$command" == "init" ]; then
  cp -a -f $alias_script_src_filepath $alias_script_target_filepath
  echo "=== [WARN] Please log out and log in again for the alias settings to take effect."
elif [ ! -f $alias_script_target_filepath ]; then
  echo -e "=== [INFO] Please run './$SCRIPT_NAME init' at first!\n" && exit 1
fi


if [ "$command" == "list" ]; then
  cat $alias_script_target_filepath| grep -v __start_kubectl | grep -v type | grep -v '#' | sed 's/alias //g'
elif [ "$command" == "get" ]; then
  alias_name=$2
  search_keyword="alias ${alias_name}="
  search_count=$(cat $alias_script_target_filepath |grep "$search_keyword" |wc -l)
  
  [ $search_count -eq 0 ] && echo -e "=== [WARN] Alias [$alias_name] not found in common kubectl aliases!\n" && exit 1
  cat $alias_script_target_filepath |grep "$search_keyword" | sed 's/alias //g'
fi

echo ""