# kibana

## documentation

- [kibana-instance-quickstart](https://www.elastic.co/docs/deploy-manage/deploy/cloud-on-k8s/kibana-instance-quickstart)

## environment

```mermaid
---
title: kibana summary
---
graph LR;
subgraph cluster[cluster]
    subgraph eck-operator
    end
    subgraph elasticsearch
    end
    subgraph kibana
        subgraph kibanaDeployment[deployment]
            kibanaPod[pod]
        end
        subgraph kibanaervice[service]
            kibanaPort[port 5601]
        end
    end
    eck-operator -->|control| kibana
    kibana -->|refer| elasticsearch
end

user[user] -->|login/refer| kibana

```

## setup

```sh
# install kibana
kubectl apply -f kibana.yaml

# get elastic user password
kubectl get secret elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo

# login
https://localhost:5601
```

## teardown

```sh
# uninstall kibana
kubectl delete -f kibana.yaml
```
