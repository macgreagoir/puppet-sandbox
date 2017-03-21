#!/bin/bash
# Clean-up any files created by previous script runs.

set +e
shopt -s extglob  # enable `rm !(README)`

SANDBOX_DIR=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd)
IMG_DIR='img'
CLEAN_UP="${IMG_DIR}/
preseeds/
artifacts/"

[[ $1 == "run" ]] || {
    echo "WARNING! This will clean-up your environment by removing the virtual machines and deleting files created in"
    echo "${CLEAN_UP}"
    echo
    echo "Usage: $0 run"
    exit 1
}

for disk in $(ls -1 ${SANDBOX_DIR}/${IMG_DIR}/!(README)); do
    domain=$(basename $disk .qcow2)
    virsh destroy $domain && virsh undefine $domain
done

for dir in $CLEAN_UP; do
    rm -rf ${SANDBOX_DIR}/${dir}!(README)
done
