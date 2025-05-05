# metallb

## documentation

- [Installation by manifest](https://metallb.universe.tf/installation/#installation-by-manifest)
- [k3s+MetalLBの環境を構築してKubernetes-Dashboardをデプロイする](https://qiita.com/ussvgr/items/b98ada65563edf77f12b)
- [ADVANCED ADDRESSPOOL CONFIGURATION](https://metallb.universe.tf/configuration/_advanced_ipaddresspool_configuration/)

## prerequisite

- [k3s](../k3s)

## setup

### disable servicelb

`/etc/systemd/system/k3s.service`

```sh
ExecStart=/usr/local/bin/k3s \
    server \
(snip)
        '--disable' \
        'servicelb' \
```

reflect

```sh
sudo systemctl daemon-reload
sudo systemctl restart k3s
```

### apply metallb

```sh
# wget https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
kubectl apply -f metallb-native.yaml
```

### setup ip range

```sh
# assigned range is 192.168.10.0/24
kubectl apply -f ip-allocation.yaml
```

## use in service

`xxx.yaml`

```sh
apiVersion: v1
kind: Service
(snip)
spec:
  type: LoadBalancer
  loadBalancerIP: 192.168.10.100
```

reflect

```sh
kubectl apply -f xxx.yaml
```
