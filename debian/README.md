# Debian

## prerequisite

- [wsl](../wsl)

## setup

```sh
sudo apt update
sudo apt upgrade -y
sudo apt install -y ssh bash-completion curl man dnsutils wget
```

`/etc/resolv.conf`

```sh
#nameserver 10.255.255.254
nameserver 8.8.8.8
nameserver 8.8.4.4
```
