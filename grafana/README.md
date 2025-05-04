# grafana

## documentation

[ローカルKubernetesクラスター上でPrometheusのメトリクスをGrafanaダッシュボードで可視化する](https://zenn.dev/ring_belle/articles/prometheus-grafana-metrics)

## environment

```mermaid
---
title: grafana summary
---
graph LR;
subgraph cluster[cluster]
    direction TB;
    subgraph grafana[grafana]
        subgraph grafanaDeployment[deployment]
            grafanaPod[pod]
        end
        subgraph grafanaService[service]
            grafanaNodePort[nodePort 3000]
        end
        grafanaPVC[PV]
    end
    subgraph prometheus[prometheus]
        subgraph prometheusDeployment[deployment]
            prometheusPod[pod]
        end
        subgraph prometheusService[service]
            prometheusPort[port 9090]
        end
    end
    grafana --- prometheus
end

user[grafana user] --- grafanaNodePort
```

## setup

1. start server

    ```sh
    kubectl apply -f grafana.yaml
    ```

1. connect prometheus

   - `Home->Connections->Add new connection->Prometheus`
     - Prometheus server URL
       - `http://prometheus:9090`
