# Ubuntu 24.04

## prerequisite

- [wsl](../wsl)

## DNS

`/etc/resolv.conf`

```sh
sudo mkdir -p /etc/systemd/resolved.conf.d/
```

`/etc/systemd/resolved.conf.d/dns_servers.conf`

```sh
[Resolve]
DNS=8.8.8.8 8.8.4.4
```

reflect

```sh
sudo systemctl daemon-reload
sudo systemctl restart systemd-resolved
```

## setup

```sh
sudo apt update
sudo apt upgrade -y
sudo apt install -y ssh bash-completion curl man dnsutils wget
```

