# dnsmasq

## environment

TODO

## prerequiste

- [kaniko](../kaniko)
- [image-registry](../image-registry)

## setup

### build

```sh
tar  -C build_context/ -cf - Dockerfile | gzip -9 | \
kubectl run kaniko --rm --stdin=true --image=gcr.io/kaniko-project/executor:latest \
--restart=Never \
-- --dockerfile=./Dockerfile --context=tar://stdin \
--destination=image-registry.default.svc.cluster.local:65000/dnsmasq:debian-bookworm-slim --insecure \
--insecure-registry=image-registry.default.svc.cluster.local:65000
```

### deploy

```sh
kubectl apply -k .
```

### undeploy

```sh
kubectl delete -k .
```

### prune

```sh
kubectl apply -k . --prune -l app=dnsmasq --prune-allowlist core/v1/ConfigMap
```
