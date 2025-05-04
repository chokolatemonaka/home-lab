# prometheus-operator

## documentation

- [prometheus official procedure](https://grafana.com/docs/grafana-cloud/monitor-infrastructure/kubernetes-monitoring/configuration/config-other-methods/prometheus/prometheus-operator/)
- [prometheus-operator official](https://prometheus-operator.dev/)
- [prometheus-operator github](https://github.com/prometheus-operator/prometheus-operator/tree/main)

## environment

```mermaid
---
title: prometheus-operator summary
---
graph LR;
subgraph cluster[cluster]
    subgraph prometheus-operator
        subgraph deployment
            pod
        end
        subgraph crds[CRDs]
            alertmanagerconfigs
            alertmanagers
            podmonitors
            probes
            prometheusagents
            prometheuses
            prometheusrules
            scrapeconfigs
            servicemonitors
            thanosrulers
        end
        subgraph service
            operatorPort[operator port 8080]
            operatedPort[operated port 9090]
        end
    end
    prometheus-operator -->|control| prometheus
end
```

## setup

[ローカルKubernetesクラスター上でPrometheusのメトリクスをGrafanaダッシュボードで可視化する](https://zenn.dev/ring_belle/articles/prometheus-grafana-metrics)

```sh
# install prometheus operator
kubectl create -f bundle.yaml

# setup prometheus operator rbac
kubectl apply -f prometheus_rbac.yaml
```

## teardown

```sh
# teardown prometheus operator rbac
kubectl delete -f prometheus_rbac.yaml

# uninstall prometheus operator
kubectl delete -f bundle.yaml
```
