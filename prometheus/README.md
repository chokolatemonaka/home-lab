# prometheus

## documentation

[prometheus-operator getting-started.md](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/developer/getting-started.md)
[prometheus-operator API](https://prometheus-operator.dev/docs/api-reference/api/)

## environment

```mermaid
---
title: prometheus-operator summary
---
graph LR;
subgraph cluster[cluster]
    direction TB;
    subgraph operator[prometheus-operator]
        controller[controller]
        crd[CRD]
    end
    subgraph prometheus[prometheus]
        direction TB;
        subgraph deployment
            pod
        end
        subgraph service
            port[port/nodePort 9090]
        end
    end
    inPrometheusExporter[prometheus-exporters]
    operator -->|control| prometheus
end
outPrometheusExporter[prometheus-exporters]

prometheus --->|scrape| inPrometheusExporter
prometheus --->|scrape| outPrometheusExporter
```

## prerequisite

[prometheus-operator](../prometheus-operator/)

## setup

[ローカルKubernetesクラスター上でPrometheusのメトリクスをGrafanaダッシュボードで可視化する](https://zenn.dev/ring_belle/articles/prometheus-grafana-metrics)

### prometheus CRD

```sh
kubectl apply -f prometheus.yaml
```

### ServiceMonitor CRD

#### ServiceMonitor environment

```mermaid
---
title: ServiceMonitor summary
---
graph LR;
subgraph cluster[cluster]
    subgraph prometheus[prometheus]
        subgraph servicemonitor[Service Monitor]
        end
    end
    subgraph inPormetheusExporter[prometheus exporter]
        inPrometheusExporterService[Service]
        inPrometheusExporterPod[pod]
        inPrometheusExporterService --> inPrometheusExporterPod
    end
    subgraph outPrometheusExporterResources[out of prometheus exporter resources]
        outPrometheusExporterService[Service]
        outPrometheusExporterEndpoints[Endpoints]
    end

    servicemonitor --> inPrometheusExporterService
    servicemonitor --> outPrometheusExporterService
    outPrometheusExporterService --> outPrometheusExporterEndpoints
end

outPrometheusExporterEndpoints --> outPrometheusExporter[prometheus exporter]
```

#### in cluster

##### in cluster example

scrape prometheus-self

```sh
kubectl apply -f prometheus-servicemonitor-incluster-prometheus-self.yaml
```

#### out of cluster

##### out of cluster example

scrape prometheus-node-exporter

```sh
sed -i 's/SCRAPE_TARGET_IP/a.b.c.d/g' prometheus-servicemonitor-outcluster-prometheus-node-exporter.yaml
kubectl apply -f prometheus-servicemonitor-outcluster-prometheus-node-exporter.yaml
```

### Probe CRD

#### Probe environment

```mermaid
---
title: Probe summary
---
graph LR;
subgraph cluster[cluster]
    subgraph prometheus[prometheus]
        subgraph probe[Probe]
        end
    end
    subgraph PormetheusExporter[prometheus exporter]
    end
    probe --> PormetheusExporter
end

PormetheusExporter --> exportTarget[exporter target]
```

#### Probe example

scrape blackbox-exporter as ssh_probe

```sh
kubectl apply -f prometheus-probe-blackbox-exporter.yaml
```
