#!/bin/bash
# Clean-up any files created by previous script runs.

set +e
shopt -s extglob  # enable `rm !(README)`

SANDBOX_DIR=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd)
CLEAN_UP='img/
preseeds/
artifacts/'

[[ $1 == "run" ]] || {
    echo "WARNING! This will clean-up your environment by deleting files created in"
    echo "${CLEAN_UP}"
    echo
    echo "Usage: $0 run"
    exit 1
}

for d in $CLEAN_UP; do
    rm -rf ${SANDBOX_DIR}/${d}!(README)
done
