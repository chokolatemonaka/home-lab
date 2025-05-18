# home-lab

This repository describes how to setup home laboratory.

## base environment

- [wsl](wsl)
- [debian](debian)

## lab service

- kubernetes
  - [k3s](k3s)
  - [metallb](metallb)
- build environment
  - [kaniko](kaniko)
- apt-cach
  - [apt-cacher-ng](apt-cacher-ng)
- proxy
  - [squid](squid)
- registry
  - docker-mirror
    - [docker-mirror](docker-mirror)
  - image-registry
    - [image-registry](image-registry)
- DNS
  - [dnsmasq](dnsmasq)
  - [systemd-resolved](systemd-resolved)
- DHCP
  - [dnsmasq](dnsmasq)
- metrics monitoring
  - [grafana](grafana)
  - [prometheus-operator](prometheus-operator)
  - [prometheus](prometheus)
  - prometheus-exporter
    - [prometheus-node-exporter](prometheus-exporter/prometheus-node-exporter)
- log monitoring
  - [eck-operator](eck-operator)
  - [kibana](kibana)
  - [elasticsearch](elasticsearch)
  - [logstash](logstash)
  - beats
    - [filebeat](beats/filebeat)
- vm
  - [libvirt](libvirt)
