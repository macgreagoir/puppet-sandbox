#!/bin/bash
# Install puppet master and agent packages and configurations on the hosts.
# Assume to use a host named puppet as the puppet master, if it exists.

set +e
shopt -s extglob  # enable `ls !(puppet.sh)`

SANDBOX_DIR=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd)
MASTER_HOSTNAME=${1:-puppet}
MASTER_CONFIG=${SANDBOX_DIR}/config/${MASTER_HOSTNAME}.sh
SSHOPTS='-o StrictHostKeyChecking=no'

[[ -f $MASTER_CONFIG ]] || {
    echo "$MASTER_CONFIG does not exist. Please choose a puppet master from your configured hosts."
    echo "Usage: $0 <puppet master hostname>"
    exit 1
}

source $MASTER_CONFIG
echo Installing puppet master
scp $SSHOPTS artifacts/puppet_{base,master}.sh debian@${NETADDR}.${ADDR}:
ssh $SSHOPTS debian@${NETADDR}.${ADDR} 'sudo bash puppet_base.sh run; sudo bash puppet_master.sh run'

for agent_config in $(ls ${SANDBOX_DIR}/config/!(README|common.sh|${MASTER_HOSTNAME}.sh)); do
    source $agent_config
    echo Installing puppet agent $NAME
    scp $SSHOPTS artifacts/puppet_{base,agent}.sh debian@${NETADDR}.${ADDR}:
    ssh $SSHOPTS debian@${NETADDR}.${ADDR} 'sudo bash puppet_base.sh run; sudo bash puppet_agent.sh run'
done

source $MASTER_CONFIG
ssh $SSHOPTS debian@${NETADDR}.${ADDR} 'sudo /opt/puppetlabs/bin/puppet cert sign --all'
