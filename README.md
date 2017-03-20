Puppet Sandbox
==============

Work with Debian KVM virtual machines to play with Puppet.


Procedure
---------

0. `cp example-config/* config/` and edit the VM configuration data

   * Each machine to be built needs a configuration file
   * `common.sh` is sourced by each for common configuration

0. `scripts/00_install_host.sh` to configure the host Debian machine

0. `scripts/01_create_machines.sh` to build the VMs

0. `scripts/02_create_artifacts.sh` to write out the scripts used to configure the VMs as puppet machines

   * This includes creating an example site.pp, which will enforce the configuration defined in the Debian preseeds

0. `scripts/03_install_puppet.sh` to copy the configuration scripts to the VMs, and run them to install and configure puppet

   * With no options, this script assumes to use a host named puppet as the puppet master

