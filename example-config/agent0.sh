#!/bin/bash
SANDBOX_DIR=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd)
source ${SANDBOX_DIR}/config/common.sh
export IPADDR=192.168.122.90
export NAME=agent0
