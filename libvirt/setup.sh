#!/bin/bash

virsh destroy $1
virsh undefine $1
virsh vol-delete $1.qcow2 --pool default
sudo cp /var/lib/libvirt/images/debian-12-generic-amd64-20250428-2096.qcow2 /var/lib/libvirt/images/$1.qcow2
