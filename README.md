Puppet Sandbox
==============

Work with Debian KVM virtual machines to play with Puppet.

Procedure
---------

0. `cp example-config/* config/` and edit the VM configuration data

 * Each machine to be built needs a configuration file

0. `scripts/00_install_host.sh` to configure the host Debian machine

0. `scripts/01_create_vm.sh puppet` to build the puppet master VM

0. `scripts/01_create_vm.sh agent0` to build a puppet agent (agent0) VM
