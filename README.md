Puppet Sandbox
==============

Work with Debian KVM virtual machines to play with Puppet.


Procedure
---------

WIP!

0. `cp example-config/* config/` and edit the VM configuration data

   * Each machine to be built needs a configuration file

0. `scripts/00_install_host.sh` to configure the host Debian machine

0. `scripts/01_create_vm.sh puppet` to build the puppet master VM

0. `scripts/01_create_vm.sh agent0` to build a puppet agent (agent0) VM

0. `scripts/02_create_artifacts.sh` to write out the scripts to provision puppet machines

   * `scp artifacts/puppet_{base,master}.sh puppet:` to move artifacts to machines, for exmaple
   * TODO We need ssh keys in place, and sudo for the debian user, to automate this

0. Run the base and specific puppet scripts on the master and agent machines

0. Sign the agent certs, on the pupper master:
```
    /opt/puppetlabs/bin/puppet cert list
    /opt/puppetlabs/bin/puppet cert sign <agent name>
```
