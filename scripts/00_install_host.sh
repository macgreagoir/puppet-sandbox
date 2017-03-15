#!/bin/bash
[[ $EUID -eq 0 ]] || {
    echo $0 must be run as root
    exit 1
}
apt-get install qemu-kvm libvirt-bin virtinst virt-manager virt-viewer
