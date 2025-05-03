# apt-cacher-ng

## environment

```mermaid
---
title: apt-cacher-ng build
---
graph LR;
subgraph cluster[cluster]
    subgraph kaniko
        subgraph apt-cacher-ng image
            Dockerfile
            build_context
        end
    end
    subgraph imageRegistry[image-registry]
    end
end
kaniko -->|push| imageRegistry
```

```mermaid
---
title: apt-cacher-ng run
---
graph LR;
subgraph k3s[k3s]
    subgraph cluster[cluster]
        direction TB;
        subgraph deploy[apt-cacher-ng deployment]
            subgraph pod[apt-cacher-ng pod]
                apt-cacher-ng-config
            end
        end
        pod --- targetPort[targetPort 3142]
        subgraph service[apt-cacher-ng service]
            targetPort --- port[port 3142]
            targetPort --- nodePort[nodePort 3142]
        end
    end
end
subgraph imageRegistry[image registry]
    aptCacherNgImage[apt-cacher-ng:ubuntu image]
end
nodePort --- aptCacherNgUser[apt-cacher-ng user]
imageRegistry -->|pull| k3s
```

## prerequiste

### [image-registry](../image-registry/)

- for push registry
  - image-registry.default.svc.cluster.local:65000
- for pull registry
  - localhost:65000

### [k3s](../k3s)

`/etc/rancher/k3s/registries.yaml`

```sh
configs:
  "localhost:65000":
    tls:
      insecure_skip_verify: true
```

reflect

```sh
sudo systemctl restart k3s
```

### [kaniko](../kaniko)

## build

```sh
tar -C build_context/ -cf - Dockerfile | gzip -9 | \
kubectl run kaniko --rm --stdin=true --image=gcr.io/kaniko-project/executor:latest \
--restart=Never \
-- --dockerfile=./Dockerfile --context=tar://stdin \
--destination=image-registry.default.svc.cluster.local:65000/apt-cacher-ng:ubuntu \
--insecure \
--insecure-registry=image-registry.default.svc.cluster.local:65000
```

## setup

```sh
kubectl apply -k .
```

## teardown

```sh
kubectl delete -k .
```

## prune

```sh
kubectl apply -k . --prune -l app=apt-cacher-ng --prune-allowlist core/v1/ConfigMap
```
