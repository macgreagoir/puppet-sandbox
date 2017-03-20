#!/bin/bash
# Create the required virtual machines.

set +e
shopt -s extglob  # enable `ls !(puppet.sh)`

SANDBOX_DIR=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd)

machines=$(ls ${SANDBOX_DIR}/config/!(README|common.sh)) || {
    echo No machine configurations found
    exit 1
}

for machine in $machines; do
    ${SANDBOX_DIR}/scripts/create_vm.sh $(basename $machine .sh)
done
