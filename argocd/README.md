# argocd

## environment

```mermaid
---
title: ArgoCD summary
---
graph LR;
subgraph cluster[cluster]
    subgraph argocd[ArgoCD]
    end
    subgraph apl[application]
        subgraph aplDeployment[deployment]
            aplPod[pod]
        end
        subgraph aplService[service]
            aplPort[port xxx]
        end
    end
    argocd -->|control| apl
end
```

## prerequisite

- [k3s](../k3s)

## documentation

[ArgoCD を使ってみた！](https://qiita.com/masamokkulu/items/e725113706a719175ae6)

## setup

```sh
# wget https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -k .
```

## teardown

```sh
kubectl delete -k .
```
