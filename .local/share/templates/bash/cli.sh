#!/usr/bin/env bash

set -euo pipefail

# script base data
_DEPS=()
_VER="0.1.0"
_APP=$(basename "$0")

# option names (long and short)
_LONG_OPTS="help,version"
_OPTS="hv"

# global variables to store shell options
#OPT_[...]

# shows help documentation message
_usage() {
  cat <<EOF
${_APP} - Version ${_VER}

  [...]

  USAGE:
    ${_APP} [...OPTIONS] -- [ORIGIN] [DEST]

  OPTIONS:
    -h --help              Shows this help message.
    -v --version           Shows the script version.
    [...]

  EXAMPLES:
    ${_APP} [...]

  DEPENDENCIES:
    (${#_DEPS[@]}) ${_DEPS[@]}
EOF
}

# logs an error message and exit with a custom code
throw() {
  >&2 echo "${_APP}: $2"
  exit "$1"
}

# apply the options into usabe variables while filtering for the arguments
_ARGV=$(getopt -o "${_OPTS}" -l "${_LONG_OPTS}" -n "${_APP}" -- "$@")

eval "set -- ${_ARGV}"

while true
do
  case $1 in
    -h | --help)     _usage;          exit ;;
    -v | --version)  echo "${_VER}";  exit ;;
    --) shift; break; ;;
     *) throw 1 "invalid option -- '$1'" ;;
  esac
done

# dependency check before running the script body
for dep in "${_DEPS[@]}"
do
  command -v "${dep}" &>/dev/null ||
    throw 1 "dependency not satisfied -- '${dep}'"
done

unset _ARGV _DEPS _VER _OPTS _LONG_OPTS
