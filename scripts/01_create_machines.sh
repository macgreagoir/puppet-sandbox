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
    (( counter+=1 ))
    names="$names $(basename $machine .sh)"
done

# Build the multiple machines concurrently.
# TODO wait seems not to be useful, I think because virsh may return
# asynchronously. Watching the last one build at least shows completion, but
# means interaction.
# for name in $names; do
#     sleep 5  # stagger them slightly
#     ${SANDBOX_DIR}/scripts/create_vm.sh $name & WAITPIDS="$WAITPIDS $!"
# done
# echo Waiting on $WAITPIDS
# wait -n $WAITPIDS
for name in $names; do
    sleep 5  # stagger them slightly
    if [[ $counter > 1 ]]; then
        (( counter-=1 ))
	${SANDBOX_DIR}/scripts/create_vm.sh $name &
    else
        ${SANDBOX_DIR}/scripts/create_vm.sh $name
    fi
done

echo Machines created
