#!/bin/bash
export DOMAIN=example.com
export NETADDR=192.168.122
export NETMASK=255.255.255.0
export PASSWD=foobar
# Escaped for s|url|$SSHKEYS_URL|
export SSHKEYS_URL=https://launchpad.net/\\~foo/\\+sshkeys
