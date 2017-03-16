Puppet Sandbox
==============

Work with Debian KVM virtual machines to play with Puppet.


Procedure
---------

WIP! This can all be automated after the config scripts are written.

0. `cp example-config/* config/` and edit the VM configuration data

   * Each machine to be built needs a configuration file
   * `common.sh` is sourced by each for common configuration

0. `scripts/00_install_host.sh` to configure the host Debian machine

0. Build the VMs

   * `scripts/01_create_vm.sh puppet` to build the puppet master (puppet) VM
   * `scripts/01_create_vm.sh agent0` to build a puppet agent (agent0) VM

0. `scripts/02_create_artifacts.sh` to write out the scripts to provision puppet machines

0. Copy the provisioning scripts to the VMs

   * `scp artifacts/puppet_{base,master}.sh debian@<puppet master>:` to move artifacts to machines
   * `scp artifacts/puppet_{base,agent}.sh debian@<agent>:`

0. Run the base and specific puppet scripts on the master and agent machines

   * `ssh debian@<puppet master> 'sudo bash puppet_base.sh run; sudo bash puppet_master.sh run'`
   * `ssh debian@<agent> 'sudo bash puppet_base.sh run; sudo bash puppet_agent.sh run'`

0. `ssh debian@<puppet master> 'sudo /opt/puppetlabs/bin/puppet cert sign --all'` to sign the agent certs

