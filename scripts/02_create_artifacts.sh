#!/bin/bash
# Creates the artifacts required to complete the provisioning of puppet machines.

SANDBOX_DIR=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd)
BASE=${SANDBOX_DIR}/artifacts/puppet_base.sh
MASTER=${SANDBOX_DIR}/artifacts/puppet_master.sh
AGENT=${SANDBOX_DIR}/artifacts/puppet_agent.sh

etc_hosts=''
for f in ${SANDBOX_DIR}/config/*.sh; do
    source $f
    etc_hosts+=" \"192.168.122.$ADDR $NAME.macgreagoir.org $NAME\" "
done

echo Writing $BASE
cat ${SANDBOX_DIR}/templates/puppet_base.tmpl > $BASE
sed -i "s/@@ETC_HOSTS@@/$etc_hosts/" $BASE

# This is really static, but is included here for consistency.
echo Writing $MASTER
cat ${SANDBOX_DIR}/templates/puppet_server.tmpl > $MASTER

echo Writing $AGENT
cat ${SANDBOX_DIR}/templates/puppet_agent.tmpl > $AGENT
