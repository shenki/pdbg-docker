#!/usr/bin/env bash

set -eu

setup_variables() {
  while [[ ${#} -ge 1 ]]; do
    case ${1} in
      "-c"|"--clean") cleanup=true ;;
      "-j"|"--jobs") shift; jobs=$1 ;;
      "-H"|"--host") shift; HOST="--host=$1" ;;
      "-j"*) jobs=${1/-j} ;;
      "-h"|"--help")
        cat usage.txt
        exit 0 ;;
    esac

    shift
  done

  # Turn on debug mode after parameters in case -h was specified
  set -x

  export ${HOST:=""}

  case ${REPO:=upstream} in
    "upstream")
      url=https://github.com/open-power/pdbg
      ;;
    * )
      url="https://github.com/$REPO/pdbg"
      ;;
  esac
}

check_dependencies() {
  command -v nproc
  command -v git
}

build_pdbg() {
  [[ ! -d pdbg ]] && git clone --depth=1 -b ${branch:=master} --single-branch "${url}" pdbg
  cd pdbg

  git show -s | cat

  ./bootstrap.sh
  ./configure "${HOST}"
  [[ -n "${cleanup:-}" ]] && make clean
  make -j"${jobs:-$(nproc)}"

  cd "${OLDPWD}"
}

setup_variables "${@}"
check_dependencies
build_pdbg
