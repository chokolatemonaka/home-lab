# ECK (Elastic Cloud on Kubernetes) operator

## documentation

- [Install ECK using the YAML manifests](https://www.elastic.co/docs/deploy-manage/deploy/cloud-on-k8s/install-using-yaml-manifest-quickstart)
- [Elastic Cloud on Kubernetes](https://www.elastic.co/docs/deploy-manage/deploy/cloud-on-k8s)

## environment

```mermaid
---
title: ECK operator summary
---
graph LR;
subgraph cluster[cluster]
    subgraph eck-operator
        subgraph eckOperatorStatefulset[statefulset]
            eckOperatorPod[pod]
            subgraph eckOperatorCRD[crd]
                agents.agent.k8s.elastic.co
                apmservers.apm.k8s.elastic.co
                beats.beat.k8s.elastic.co
                elasticmapsservers.maps.k8s.elastic.co
                elasticsearchautoscalers.autoscaling.k8s.elastic.co
                elasticsearches.elasticsearch.k8s.elastic.co
                enterprisesearches.enterprisesearch.k8s.elastic.co
                kibanas.kibana.k8s.elastic.co10Z
                logstashes.logstash.k8s.elastic.co
                stackconfigpolicies.stackconfigpolicy.k8s.elastic.co
            end
        end
    end
    eck-operator -->|control| kibana
    eck-operator -->|control| elasticsearch
    eck-operator -->|control| logstash
end
```

## setup

```sh
# setup crd
# https://download.elastic.co/downloads/eck/3.0.0/crds.yaml
kubectl create -f crds.yaml

# install operator
# https://download.elastic.co/downloads/eck/3.0.0/operator.yaml
kubectl apply -f operator.yaml
```

## teardown

```sh
# uninstall operator
kubectl delete -f operator.yaml

# teardown crd
kubectl delete -f crds.yaml
```
