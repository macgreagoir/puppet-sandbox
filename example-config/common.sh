#!/bin/bash
export DOMAIN=example.com
export NETMASK=255.255.255.0
export GW=192.168.122.1
export NS=192.168.122.1
export PASSWD=foobar
# Escaped for s|url|$SSHKEYS_URL|
export SSHKEYS_URL=https://launchpad.net/\\~foo/\\+sshkeys
