# libvirt

## setup

```sh
# install packages
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst libosinfo-bin

# get cloud image
sudo wget https://cdimage.debian.org/images/cloud/bookworm/20250428-2096/debian-12-generic-amd64-20250428-2096.qcow2 -O /var/lib/libvirt/images/debian-12-generic-amd64-20250428-2096.qcow2

# enable default network
sudo virsh net-define /etc/libvirt/qemu/networks/default.xml

# setup
./setup.sh debian12

# qemu-imag resize
sudo qemu-img resize /var/lib/libvirt/images/debian12.qcow2 10G

# install
sudo virt-install --name debian12 --vcpus 1 --memory 512 --osinfo debian12  --disk path=/var/lib/libvirt/images/debian12.qcow2 --network network=default --import  --cloud-init meta-data=iso/meta-data,user-data=iso/user-data

# confirm lease
virsh net-dhcp-leases default

# set dnsmasq hostname
virsh net-update default add dns-host "<host ip='YOURIP'><hostname>debian12</hostname></host>"

# connect
ping debian12
```
