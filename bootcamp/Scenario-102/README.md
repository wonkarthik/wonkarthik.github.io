Table of Contents
=================
<a href="https://www.dennyzhang.com"><img align="right" width="201" height="268" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/denny_201706.png"></a>

   * [Requirements](#requirements)
   * [Background &amp; Highlights](#background--highlights)
   * [Procedure](#procedure)
      * [Deployment](#deployment)
      * [Verify Deployment](#verify-deployment)
   * [More resources](#more-resources)

# Requirements
<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>

Scenario-102: 1-Node K8S Deployment II
- Objective: Single node deployment for stateful service
- Requirements:
```
1. Use yaml to start one mysql server service with 1 instance.
2. Use yaml to start one mysql client service with 2 instances.
3. Delete the db server instance, make sure a new one will be created automatically.
4. When db server is recreated, make sure no data loss.
```

See [kubernetes.yaml](kubernetes.yaml)

# Background & Highlights

- Use persistent volumes in 3 steps
```
Creating and using a persistent volume is a three step process:

1. Provision: Administrator provision a networked storage in the
cluster, such as AWS ElasticBlockStore volumes. This is called as
PersistentVolume.

2. Request storage: User requests storage for pods by using
claims. Claims can specify levels of resources (CPU and memory),
specific sizes and access modes (e.g. can be mounted once read/write
or many times write only).  This is called as PersistentVolumeClaim.

3. Use claim: Claims are mounted as volumes and used in pods for storage.

https://blog.couchbase.com/stateful-containers-kubernetes-amazon-ebs/
```

- Highlights
```
Q: How does the volume process work?
Q: How PersistentVolumeClaim know use which PersistentVolume?
```

# Procedure
## Deployment

To setup mysql service, here we use mysql image in [docker hub](https://hub.docker.com/_/mysql/).

- Start vm
```
# start a VM to host our deployment
minikube start

# Create k8s volume, deployment and service
kubectl create -f ./kubernetes.yaml
```
See [kubernetes.yaml](kubernetes.yaml)

## Verify Deployment
- Check k8s web UI Dashboard
```
minikube dashboard
```

- List k8s resources
```
# list deployments
kubectl get deployment

# list service
kubectl get services

# list pods
kubectl get pods
```
- Run functional test

Open mysql client to access the mysql server

Use phpmyadmin, create a database and a table 
TODO

phpmyadmin url:

```minikube service my-dbclient-service --url```

dbserver_url:

```"$(minikube service my-dbserver-service --url)"```

TODO: remove http, add screenshot

-  Mysql server resilient test
- If one instance is down, another will be started automatcially.

TODO

From Web UI, delete the mysql server Pod.

We should see ReplicationController will start a new one.

Confirm the database and table still persist, which were created in last step.

- Delete k8s resources
```
kubectl delete -f ./kubernetes.yaml
```

- Destroy env
```
minikube delete
```


# More resources
- minikube: https://kubernetes.io/docs/getting-started-guides/minikube/
- k8s local solutions: https://kubernetes.io/docs/setup/pick-right-solution/#local-machine-solutions
- k8s volume: https://blog.couchbase.com/stateful-containers-kubernetes-amazon-ebs/

<a href="https://www.dennyzhang.com"><img align="right" width="185" height="37" src="https://raw.githubusercontent.com/USDevOps/mywechat-slack-group/master/images/dns_small.png"></a>
