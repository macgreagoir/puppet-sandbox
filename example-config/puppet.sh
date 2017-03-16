#!/bin/bash
SANDBOX_DIR=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd)
source ${SANDBOX_DIR}/config/common.sh

# Host address of $NETADDR.$ADDR address
export ADDR=89
export NAME=puppet
