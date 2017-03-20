#!/bin/bash

set +e

SANDBOX_DIR=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd)
VM_NAME=${1?"Usage: $0 VM_NAME"}
DISK_PATH=${SANDBOX_DIR}/img/${VM_NAME}.qcow2
PRESEED_PATH=${SANDBOX_DIR}/preseeds/${VM_NAME}/preseed.cfg
CONFIG_PATH=${SANDBOX_DIR}/config/${VM_NAME}.sh

[[ -f $PRESEED_PATH ]] || {
    echo No preseed found at $PRESEED_PATH
    [[ -f $CONFIG_PATH ]] || {
        echo No config found at $CONFIG_PATH
        exit 1
    }
    echo Creating preseed from $CONFIG_PATH
    mkdir -p $(dirname $PRESEED_PATH)
    source $CONFIG_PATH
    sed -e '/^$/d' -e '/^#/d' \
        -e "s/@@DOMAIN@@/$DOMAIN/" \
        -e "s/@@NAME@@/$NAME/" \
        -e "s/@@NETADDR@@/$NETADDR/" \
        -e "s/@@ADDR@@/$ADDR/" \
        -e "s/@@NETMASK@@/$NETMASK/" \
        -e "s/@@PASSWD@@/$PASSWD/" \
        -e "s|@@SSHKEYS_URL@@|$SSHKEYS_URL|" \
        ${SANDBOX_DIR}/templates/preseed.cfg > $PRESEED_PATH
}

[[ -f $DISK_PATH ]] || {
    qemu-img create -f qcow2 $DISK_PATH 10G
}

virt-install --connect qemu:///system \
    --virt-type kvm \
    --name $VM_NAME \
    --cpu host-model-only \
    --vcpus 2 \
    --ram 2048 \
    --disk $DISK_PATH \
    --location http://ftp.debian.org/debian/dists/jessie/main/installer-amd64/ \
    --initrd-inject=${PRESEED_PATH} \
    --extra-args "console=tty0 console=ttyS0,115200 console=ttyS1,115200 panic=30 raid=noautodetect" \
    --network bridge=virbr0 \
    --graphics none \
    --os-type linux \
    --os-variant debian8

