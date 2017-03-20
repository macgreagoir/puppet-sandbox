#!/bin/bash
# Creates the artifacts required to complete the configuration of the VMs as
# puppet machines.

set +e

SANDBOX_DIR=$(cd $(dirname ${BASH_SOURCE[0]})/..; pwd)
BASE=${SANDBOX_DIR}/artifacts/puppet_base.sh
MASTER=${SANDBOX_DIR}/artifacts/puppet_master.sh
AGENT=${SANDBOX_DIR}/artifacts/puppet_agent.sh

etc_hosts=''
for f in ${SANDBOX_DIR}/config/*.sh; do
    # NOTE magic name alert!
    [[ $(basename $f) == "common.sh" ]] && continue
    source $f
    etc_hosts+=" \"${NETADDR}.${ADDR} ${NAME}.${DOMAIN} $NAME\" "
done

PASSWD_CRYPT=$(mkpasswd -m sha-512 -s <<<"$PASSWD")
read KEY_TYPE KEY KEY_NAME <<<$(wget -q -O - ${SSHKEYS_URL//\\/})

: ${etc_hosts:?} ${PASSWD_CRYPT:?} ${KEY_TYPE:?} ${KEY:?} ${KEY_NAME:?}

echo Writing $BASE
cat ${SANDBOX_DIR}/templates/puppet_base.tmpl > $BASE
sed -i "s/@@ETC_HOSTS@@/$etc_hosts/" $BASE

echo Writing $MASTER
cat ${SANDBOX_DIR}/templates/puppet_server.tmpl > $MASTER
sed -i -e "s|@@PASSWD_CRYPT@@|${PASSWD_CRYPT//\$/\\\\\$}|" \
    -e "s|@@KEY_NAME@@|$KEY_NAME|" \
    -e "s|@@KEY_TYPE@@|$KEY_TYPE|" \
    -e "s|@@KEY@@|$KEY|" \
    $MASTER

# This is really static, but is included here for consistency.
echo Writing $AGENT
cat ${SANDBOX_DIR}/templates/puppet_agent.tmpl > $AGENT
