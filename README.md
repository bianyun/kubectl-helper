# kubectl-helper
kubectl-helper is a set of scripts that encapsulate common kubectl commands and is used to simplify common operations of kubectl commands.

## 1. Install
```bash
[root@localhost ~]# wget https://github.com/bianyun/kubectl-helper/releases/download/1.1.0/kubectl-helper_v1.1.0.tar.gz
[root@localhost ~]# tar zxf kubectl-helper_v1.1.0.tar.gz
[root@localhost ~]# cd kubectl-helper
[root@localhost kubectl-helper]# ls -l
total 36
drwxr-xr-x 2 root root   70 Nov  6 11:48 _base
-rwxr--r-- 1 root root 1908 Nov  7 16:17 batch_dump_describe_of_k8s_resources.sh
-rwxr--r-- 1 root root 2663 Nov  7 16:17 batch_dump_logs_of_k8s_resources.sh
-rwxr--r-- 1 root root 2627 Nov  7 16:17 describe_k8s_resource.sh
-rwxr--r-- 1 root root 2237 Nov  7 16:17 enter_into_k8s_pod.sh
-rwxr--r-- 1 root root 2495 Nov  7 16:17 execute_cmd_in_k8s_pod.sh
-rwxr--r-- 1 root root 4785 Nov  7 16:17 restart_k8s_resources.sh
-rwxr--r-- 1 root root 2563 Nov  7 16:17 setup_kubectl_aliases.sh
-rwxr--r-- 1 root root 3120 Nov  7 16:17 view_logs_of_k8s_resource.sh
[root@localhost kubectl-helper]# 
[root@localhost kubectl-helper]# ./setup_kubectl_aliases.sh init
=== [WARN] Please log out and log in again for the alias settings to take effect.

[root@localhost kubectl-helper]#
```

## 2. Aliases

```bash
[root@localhost kubectl-helper]# ./setup_kubectl_aliases.sh list

k='kubectl'

ktn='kubectl top node'

ktp='kubectl top pod'
ktpa='kubectl top pod -A'
ktpks='kubectl top pod -n kube-system'
ktpu='kubectl top pod -n uds'

kgns='kubectl get ns'

kgn='kubectl get node'
kgnw='kubectl get node -o wide'

kgpv='kubectl get pv'
kgpvw='kubectl get pv -o wide'

kgpvc='kubectl get pvc'
kgpvca='kubectl get pvc -A'
kgpvcks='kubectl get pvc -n kube-system'
kgpvcu='kubectl get pvc -n uds'

kgpvcw='kubectl get pvc -o wide'
kgpvcwa='kubectl get pvc -o wide -A'
kgpvcwks='kubectl get pvc -n kube-system'
kgpvcwu='kubectl get pvc -n uds'

kgds='kubectl get daemonset'
kgdsa='kubectl get daemonset -A'
kgdsks='kubectl get daemonset -n kube-system'
kgdsu='kubectl get daemonset -n uds'

kgdsw='kubectl get daemonset -o wide'
kgdswa='kubectl get daemonset -o wide -A'
kgdswks='kubectl get daemonset -o wide -n kube-system'
kgdswu='kubectl get daemonset -o wide -n uds'

kgsts='kubectl get statefulset'
kgstsa='kubectl get statefulset -A'
kgstsks='kubectl get statefulset -n kube-system'
kgstsu='kubectl get statefulset -n uds'

kgstsw='kubectl get statefulset -o wide'
kgstswa='kubectl get statefulset -o wide -A'
kgstswks='kubectl get statefulset -o wide -n kube-system'
kgstswu='kubectl get statefulset -o wide -n uds'

kgrs='kubectl get replicaset'
kgrsa='kubectl get replicaset -A'
kgrsks='kubectl get replicaset -n kube-system'
kgrsu='kubectl get replicaset -n uds'

kgrsw='kubectl get replicaset -o wide'
kgrswa='kubectl get replicaset -o wide -A'
kgrswks='kubectl get replicaset -o wide -n kube-system'
kgrswu='kubectl get replicaset -o wide -n uds'

kgp='kubectl get pod'
kgpa='kubectl get pod -A'
kgpks='kubectl get pod -n kube-system'
kgpu='kubectl get pod -n uds'

kgpw='kubectl get pod -o wide'
kgpwa='kubectl get pod -o wide -A'
kgpwks='kubectl get pod -o wide -n kube-system'
kgpwu='kubectl get pod -o wide -n uds'

kgep='kubectl get endpoints'
kgepa='kubectl get endpoints -A'
kgepks='kubectl get endpoints -n kube-system'
kgepu='kubectl get endpoints -n uds'

kgev='kubectl get event'
kgeva='kubectl get event -A'
kgevks='kubectl get event -n kube-system'
kgevu='kubectl get event -n uds'

kgevw='kubectl get event -o wide'
kgevwa='kubectl get event -o wide -A'
kgevwks='kubectl get event -o wide -n kube-system'
kgevwu='kubectl get event -o wide -n uds'

kgs='kubectl get svc'
kgsa='kubectl get svc -A'
kgsks='kubectl get svc -n kube-system'
kgsu='kubectl get svc -n uds'

kgsw='kubectl get svc -o wide'
kgswa='kubectl get svc -o wide -A'
kgswks='kubectl get svc -o wide -n kube-system'
kgswu='kubectl get svc -o wide -n uds'

kgd='kubectl get deploy'
kgda='kubectl get deploy -A'
kgdks='kubectl get deploy -n kube-system'
kgdu='kubectl get deploy -n uds'

kgdw='kubectl get deploy -o wide'
kgdwa='kubectl get deploy -o wide -A'
kgdwks='kubectl get deploy -o wide -n kube-system'
kgdwu='kubectl get deploy -o wide -n uds'

[root@localhost kubectl-helper]#
```

```bash
[root@localhost kubectl-helper]# ktn
NAME        CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
10.1.76.1   823m         20%    9070Mi          68%
10.1.76.2   587m         14%    6354Mi          69%
10.1.76.3   423m         10%    3255Mi          35%
[root@localhost kubectl-helper]# kgn
NAME        STATUS   ROLES    AGE   VERSION
10.1.76.1   Ready    master   29d   v1.19.14
10.1.76.2   Ready    master   29d   v1.19.14
10.1.76.3   Ready    node     29d   v1.19.14
[root@localhost kubectl-helper]# kgns
NAME              STATUS   AGE
default           Active   29d
kube-node-lease   Active   29d
kube-public       Active   29d
kube-system       Active   29d
uds               Active   29d
[root@localhost kubectl-helper]# kgp
NAME                                  READY   STATUS    RESTARTS   AGE
docker-registry-647dfbd4f8-4rjj4      1/1     Running   0          16h
docker-registry-ui-86b768fc47-bdp7l   1/1     Running   0          16h
nacos-675ff5894-4kb9c                 1/1     Running   0          16h
redis-7756bbdcb4-864lb                1/1     Running   0          16h
uds-es-master-0                       1/1     Running   0          16h
uds-es-master-1                       1/1     Running   0          16h
uds-es-master-2                       1/1     Running   0          16h
[root@localhost kubectl-helper]# kgpw
NAME                                  READY   STATUS    RESTARTS   AGE   IP            NODE     
docker-registry-647dfbd4f8-4rjj4      1/1     Running   0          16h   172.20.2.34   10.1.76.3
docker-registry-ui-86b768fc47-bdp7l   1/1     Running   0          16h   172.20.1.23   10.1.76.2
nacos-675ff5894-4kb9c                 1/1     Running   0          16h   172.20.1.24   10.1.76.2
redis-7756bbdcb4-864lb                1/1     Running   0          16h   172.20.1.25   10.1.76.2
uds-es-master-0                       1/1     Running   0          16h   172.20.0.35   10.1.76.1
uds-es-master-1                       1/1     Running   0          16h   172.20.2.35   10.1.76.3
uds-es-master-2                       1/1     Running   0          16h   172.20.1.26   10.1.76.2
[root@localhost kubectl-helper]# kgs
NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
docker-registry          NodePort    10.68.58.161    <none>        15000:15000/TCP                 29d
docker-registry-ui-svc   NodePort    10.68.88.110    <none>        15080:15080/TCP                 29d
kubernetes               ClusterIP   10.68.0.1       <none>        443/TCP                         29d
nacos-svc                NodePort    10.68.27.64     <none>        8848:18848/TCP                  29d
redis-svc                ClusterIP   10.68.178.213   <none>        6379/TCP                        29d
uds-es-master            NodePort    10.68.21.188    <none>        9200:30092/TCP,9300:25803/TCP   29d
uds-es-master-headless   ClusterIP   None            <none>        9200/TCP,9300/TCP               29d
[root@localhost kubectl-helper]# kgd
NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
docker-registry      1/1     1            1           29d
docker-registry-ui   1/1     1            1           29d
nacos                1/1     1            1           29d
redis                1/1     1            1           29d
[root@localhost kubectl-helper]# kgdsa
NAMESPACE     NAME                    DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-system   kube-flannel-ds-amd64   3         3         3       3            3           <none>          29d
kube-system   node-local-dns          3         3         3       3            3           <none>          29d
[root@localhost kubectl-helper]# kgsts
NAME            READY   AGE
uds-es-master   3/3     29d
[root@localhost kubectl-helper]# kgrs
NAME                            DESIRED   CURRENT   READY   AGE
docker-registry-647dfbd4f8      1         1         1       16h
docker-registry-789c879688      0         0         0       29d
docker-registry-ui-7c57784c4f   0         0         0       29d
docker-registry-ui-86b768fc47   1         1         1       16h
nacos-675ff5894                 1         1         1       16h
nacos-7d4885f7fb                0         0         0       21h
redis-67b8897c5c                0         0         0       29d
redis-7756bbdcb4                1         1         1       16h
redis-85f4b69747                0         0         0       28d
[root@localhost kubectl-helper]# kgep
NAME                     ENDPOINTS                                                        AGE
docker-registry          172.20.2.34:15000                                                29d
docker-registry-ui-svc   172.20.1.23:80                                                   29d
kubernetes               10.1.76.1:16443,10.1.76.2:16443                                  29d
nacos-svc                172.20.1.24:8848                                                 29d
redis-svc                172.20.1.25:6379                                                 29d
uds-es-master            172.20.0.35:9200,172.20.1.26:9200,172.20.2.35:9200 + 3 more...   29d
uds-es-master-headless   172.20.0.35:9200,172.20.1.26:9200,172.20.2.35:9200 + 3 more...   29d
[root@localhost kubectl-helper]# kgpu
NAME                             READY   STATUS    RESTARTS   AGE
uds-admin-5574975dbd-mx7tr       1/1     Running   0          5h32m
uds-auth-8b67fc4c4-8frkt         1/1     Running   0          5h32m
uds-gateway-7c8c7b5bc4-crnrv     1/1     Running   0          5h32m
uds-gateway-7c8c7b5bc4-m8sx2     1/1     Running   0          5h32m
uds-job-admin-85bcd647f7-knfqb   1/1     Running   0          5h32m
uds-metadata-dccb7ddf9-qx9lh     1/1     Running   0          5h32m
uds-webui-8544cf8fdd-k2t67       1/1     Running   0          5h32m
[root@localhost kubectl-helper]# kgpks
NAME                                         READY   STATUS    RESTARTS   AGE
coredns-766956944f-kdmk6                     1/1     Running   0          21h
dashboard-metrics-scraper-7fdfb7dc46-8r7cg   1/1     Running   0          21h
kube-flannel-ds-amd64-8td4j                  1/1     Running   0          16h
kube-flannel-ds-amd64-g7l8g                  1/1     Running   0          16h
kube-flannel-ds-amd64-qw9nb                  1/1     Running   0          16h
kubernetes-dashboard-766f6764d7-r5zld        1/1     Running   0          21h
metrics-server-bddd9b766-8kpbr               1/1     Running   0          21h
node-local-dns-cw5dg                         1/1     Running   0          16h
node-local-dns-lk7dg                         1/1     Running   0          16h
node-local-dns-pq7jr                         1/1     Running   0          16h
[root@localhost kubectl-helper]# kgdu
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
uds-admin       1/1     1            1           29d
uds-auth        1/1     1            1           29d
uds-gateway     2/2     2            2           29d
uds-job-admin   1/1     1            1           29d
uds-metadata    1/1     1            1           29d
uds-webui       1/1     1            1           29d
[root@localhost kubectl-helper]# kgdks
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
coredns                     1/1     1            1           29d
dashboard-metrics-scraper   1/1     1            1           29d
kubernetes-dashboard        1/1     1            1           29d
metrics-server              1/1     1            1           29d
[root@localhost kubectl-helper]# kgpa
NAMESPACE     NAME                                         READY   STATUS    RESTARTS   AGE
default       docker-registry-647dfbd4f8-4rjj4             1/1     Running   0          16h
default       docker-registry-ui-86b768fc47-bdp7l          1/1     Running   0          16h
default       nacos-675ff5894-4kb9c                        1/1     Running   0          16h
default       redis-7756bbdcb4-864lb                       1/1     Running   0          16h
default       uds-es-master-0                              1/1     Running   0          16h
default       uds-es-master-1                              1/1     Running   0          16h
default       uds-es-master-2                              1/1     Running   0          16h
kube-system   coredns-766956944f-kdmk6                     1/1     Running   0          21h
kube-system   dashboard-metrics-scraper-7fdfb7dc46-8r7cg   1/1     Running   0          21h
kube-system   kube-flannel-ds-amd64-8td4j                  1/1     Running   0          16h
kube-system   kube-flannel-ds-amd64-g7l8g                  1/1     Running   0          16h
kube-system   kube-flannel-ds-amd64-qw9nb                  1/1     Running   0          16h
kube-system   kubernetes-dashboard-766f6764d7-r5zld        1/1     Running   0          21h
kube-system   metrics-server-bddd9b766-8kpbr               1/1     Running   0          21h
kube-system   node-local-dns-cw5dg                         1/1     Running   0          16h
kube-system   node-local-dns-lk7dg                         1/1     Running   0          16h
kube-system   node-local-dns-pq7jr                         1/1     Running   0          16h
uds           uds-admin-5574975dbd-mx7tr                   1/1     Running   0          5h32m
uds           uds-auth-8b67fc4c4-8frkt                     1/1     Running   0          5h32m
uds           uds-gateway-7c8c7b5bc4-crnrv                 1/1     Running   0          5h32m
uds           uds-gateway-7c8c7b5bc4-m8sx2                 1/1     Running   0          5h32m
uds           uds-job-admin-85bcd647f7-knfqb               1/1     Running   0          5h32m
uds           uds-metadata-dccb7ddf9-qx9lh                 1/1     Running   0          5h32m
uds           uds-webui-8544cf8fdd-k2t67                   1/1     Running   0          5h32m
[root@localhost kubectl-helper]# kgda
NAMESPACE     NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
default       docker-registry             1/1     1            1           29d
default       docker-registry-ui          1/1     1            1           29d
default       nacos                       1/1     1            1           29d
default       redis                       1/1     1            1           29d
kube-system   coredns                     1/1     1            1           29d
kube-system   dashboard-metrics-scraper   1/1     1            1           29d
kube-system   kubernetes-dashboard        1/1     1            1           29d
kube-system   metrics-server              1/1     1            1           29d
uds           uds-admin                   1/1     1            1           29d
uds           uds-auth                    1/1     1            1           29d
uds           uds-gateway                 2/2     2            2           29d
uds           uds-job-admin               1/1     1            1           29d
uds           uds-metadata                1/1     1            1           29d
uds           uds-webui                   1/1     1            1           29d
[root@localhost kubectl-helper]#
```

## 3. Describe and dump k8s resource(s)

### 3.1 Describe single selected k8s resource

```bash
[root@localhost kubectl-helper]# ./describe_k8s_resource.sh pod uds

=== Found 10 pods with 'uds' in their names:

    NAMESPACE  NAME                            READY   STATUS    RESTARTS   AGE     IP            NODE     
 1: default    uds-es-master-0                 1/1     Running   0          16h     172.20.0.35   10.1.76.1
 2: default    uds-es-master-1                 1/1     Running   0          16h     172.20.2.35   10.1.76.3
 3: default    uds-es-master-2                 1/1     Running   0          16h     172.20.1.26   10.1.76.2
 4: uds        uds-admin-5574975dbd-mx7tr      1/1     Running   0          6h17m   172.20.1.27   10.1.76.2
 5: uds        uds-auth-8b67fc4c4-8frkt        1/1     Running   0          6h17m   172.20.0.36   10.1.76.1
 6: uds        uds-gateway-7c8c7b5bc4-crnrv    1/1     Running   0          6h17m   172.20.0.37   10.1.76.1
 7: uds        uds-gateway-7c8c7b5bc4-m8sx2    1/1     Running   0          6h17m   172.20.2.36   10.1.76.3
 8: uds        uds-job-admin-85bcd647f7-knfqb  1/1     Running   0          6h17m   172.20.1.28   10.1.76.2
 9: uds        uds-metadata-dccb7ddf9-qx9lh    1/1     Running   0          6h17m   172.20.0.38   10.1.76.1
10: uds        uds-webui-8544cf8fdd-k2t67      1/1     Running   0          6h17m   172.20.1.29   10.1.76.2

=== Please choose one pod to describe it [1~10] OR type 'q' to quit: 4

=== [INFO] About to execute following command in 1 seconds:
    [ kubectl describe -n uds pod/uds-admin-5574975dbd-mx7tr ]

--------------------------------- [ Command execution result ] ----------------------------------

Name:         uds-admin-5574975dbd-mx7tr
Namespace:    uds
Priority:     0
Node:         10.1.76.2/10.1.76.2
Start Time:   Tue, 07 Nov 2023 11:08:36 +0800
Labels:       app=uds-admin
              app.kubernetes.io/instance=uds
              app.kubernetes.io/name=uds-admin
              pod-template-hash=5574975dbd
Annotations:  kubectl.kubernetes.io/restartedAt: 2023-11-07T11:08:36+08:00
Status:       Running
IP:           172.20.1.27
IPs:
  IP:           172.20.1.27
Controlled By:  ReplicaSet/uds-admin-5574975dbd
Containers:
  uds-admin:
    Container ID:   docker://3a51179bdd5422c5106935787496b310200e3c8da12c8e44d52a8d6ac433d784
    Image:          docker-registry:15000/uds_cloud/uds-ms-admin:2.1.2
    Image ID:       docker-pullable://docker-registry:15000/uds_cloud/uds-ms-admin@sha256:8acbcde5da27f8de311a8a5907ca8ec91e226dfaa15c7aa165fe8a048a8bb962
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 07 Nov 2023 11:08:38 +0800
    Ready:          True
    Restart Count:  0
    Environment:
      spring.cloud.nacos.server-addr:  nacos-svc.default:8848
      JASYPT_ENCRYPTOR_PASSWORD:       Yiph@FZ3Nwg
      spring.cloud.nacos.username:     nacos
      spring.cloud.nacos.password:     pa44w0rd
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-rwlbs (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-rwlbs:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-rwlbs
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:          <none>

[root@localhost kubectl-helper]#
```

```bash
[root@localhost kubectl-helper]# ./describe_k8s_resource.sh node 10.1.76.

=== Found 3 nodes with '10.1.76.' in their names:

    NAME       STATUS  ROLES    AGE   VERSION    INTERNAL-IP  KERNEL-VERSION          CONTAINER-RUNTIME
 1: 10.1.76.1  Ready   master   29d   v1.19.14   10.1.76.1    3.10.0-957.el7.x86_64   docker://19.3.15
 2: 10.1.76.2  Ready   master   29d   v1.19.14   10.1.76.2    3.10.0-957.el7.x86_64   docker://19.3.15
 3: 10.1.76.3  Ready   node     29d   v1.19.14   10.1.76.3    3.10.0-957.el7.x86_64   docker://19.3.15

=== Please choose one node to describe it [1~3] OR type 'q' to quit: 1

=== [INFO] About to execute following command in 1 seconds:
    [ kubectl describe node/10.1.76.1 ]

--------------------------------- [ Command execution result ] ----------------------------------

Name:               10.1.76.1
Roles:              master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=10.1.76.1
                    kubernetes.io/os=linux
                    kubernetes.io/role=master
Annotations:        flannel.alpha.coreos.com/backend-data: {"VtepMAC":"42:8a:b7:0d:a9:d7"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 10.1.76.1
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Mon, 09 Oct 2023 11:48:49 +0800
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  10.1.76.1
  AcquireTime:     <unset>
  RenewTime:       Tue, 07 Nov 2023 17:32:32 +0800
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Tue, 07 Nov 2023 00:00:02 +0800   Tue, 07 Nov 2023 00:00:02 +0800   FlannelIsUp                  Flannel is running on this node
  MemoryPressure       False   Tue, 07 Nov 2023 17:32:25 +0800   Mon, 09 Oct 2023 11:48:49 +0800   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Tue, 07 Nov 2023 17:32:25 +0800   Mon, 09 Oct 2023 11:48:49 +0800   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Tue, 07 Nov 2023 17:32:25 +0800   Mon, 09 Oct 2023 11:48:49 +0800   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Tue, 07 Nov 2023 17:32:25 +0800   Fri, 03 Nov 2023 02:58:00 +0800   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  10.1.76.1
  Hostname:    10.1.76.1
Capacity:
  cpu:                4
  ephemeral-storage:  76899Mi
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             14183440Ki
  pods:               110
Allocatable:
  cpu:                4
  ephemeral-storage:  72571001122
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             13466640Ki
  pods:               110
System Info:
  Machine ID:                 063748ff53c741a093c85702f280e354
  System UUID:                7AE74D56-3969-66F5-C3E7-8D70E60C4AAC
  Boot ID:                    dffb9179-fff1-47bf-8699-5a6d1a288489
  Kernel Version:             3.10.0-957.el7.x86_64
  OS Image:                   CentOS Linux 7 (Core)
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  docker://19.3.15
  Kubelet Version:            v1.19.14
  Kube-Proxy Version:         v1.19.14
PodCIDR:                      172.20.0.0/24
PodCIDRs:                     172.20.0.0/24
Non-terminated Pods:          (7 in total)
 Namespace    Name                           CPU Requests  CPU Limits  Memory Requests  Memory Limits  AGE
 ---------    ----                           ------------  ----------  ---------------  -------------  ---
 default      uds-es-master-0                1 (25%)       2 (50%)     1Gi (7%)         2Gi (15%)      17h
 kube-system  kube-flannel-ds-amd64-qw9nb    100m (2%)     150m (3%)   100Mi (0%)       150Mi (1%)     17h
 kube-system  metrics-server-bddd9b766-8kpbr 0 (0%)        0 (0%)      0 (0%)           0 (0%)         22h
 kube-system  node-local-dns-pq7jr           25m (0%)      0 (0%)      5Mi (0%)         0 (0%)         17h
 uds          uds-auth-8b67fc4c4-8frkt       0 (0%)        0 (0%)      0 (0%)           0 (0%)         6h24m
 uds          uds-gateway-7c8c7b5bc4-crnrv   0 (0%)        0 (0%)      0 (0%)           0 (0%)         6h24m
 uds          uds-metadata-dccb7ddf9-qx9lh   0 (0%)        0 (0%)      0 (0%)           0 (0%)         6h24m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests     Limits
  --------           --------     ------
  cpu                1125m (28%)  2150m (53%)
  memory             1129Mi (8%)  2198Mi (16%)
  ephemeral-storage  0 (0%)       0 (0%)
  hugepages-1Gi      0 (0%)       0 (0%)
  hugepages-2Mi      0 (0%)       0 (0%)
Events:              <none>

[root@localhost kubectl-helper]#
```

### 3.2 Batch dump describe result of multiple selected k8s resources

```bash
[root@localhost kubectl-helper]# ./batch_dump_describe_of_k8s_resources.sh pod uds

=== Found 10 pods with 'uds' in their names:

    NAMESPACE  NAME                            READY   STATUS    RESTARTS   AGE     IP            NODE     
 1: default    uds-es-master-0                 1/1     Running   0          17h     172.20.0.35   10.1.76.1
 2: default    uds-es-master-1                 1/1     Running   0          17h     172.20.2.35   10.1.76.3
 3: default    uds-es-master-2                 1/1     Running   0          17h     172.20.1.26   10.1.76.2
 4: uds        uds-admin-5574975dbd-mx7tr      1/1     Running   0          6h28m   172.20.1.27   10.1.76.2
 5: uds        uds-auth-8b67fc4c4-8frkt        1/1     Running   0          6h28m   172.20.0.36   10.1.76.1
 6: uds        uds-gateway-7c8c7b5bc4-crnrv    1/1     Running   0          6h28m   172.20.0.37   10.1.76.1
 7: uds        uds-gateway-7c8c7b5bc4-m8sx2    1/1     Running   0          6h28m   172.20.2.36   10.1.76.3
 8: uds        uds-job-admin-85bcd647f7-knfqb  1/1     Running   0          6h28m   172.20.1.28   10.1.76.2
 9: uds        uds-metadata-dccb7ddf9-qx9lh    1/1     Running   0          6h28m   172.20.0.38   10.1.76.1
10: uds        uds-webui-8544cf8fdd-k2t67      1/1     Running   0          6h28m   172.20.1.29   10.1.76.2

=== Please select one or more pods (example: 1~2,4,5~7) to continue OR type 'q' to quit: 1~3,5,7,9~10
=== The final specified seq nums are: [ 1 2 3 5 7 9 10 ]

=== Dumping describe of pod [ default/uds-es-master-0 ] ...
=== Dumping describe of pod [ default/uds-es-master-1 ] ...
=== Dumping describe of pod [ default/uds-es-master-2 ] ...
=== Dumping describe of pod [ uds/uds-auth-8b67fc4c4-8frkt ] ...
=== Dumping describe of pod [ uds/uds-gateway-7c8c7b5bc4-m8sx2 ] ...
=== Dumping describe of pod [ uds/uds-metadata-dccb7ddf9-qx9lh ] ...
=== Dumping describe of pod [ uds/uds-webui-8544cf8fdd-k2t67 ] ...

=== All describe of selected pods have been dumped, the result file:
    [ /root/kubectl-helper/_out/k8s-describe-of-pods_[filtered-by_uds]_2023-11-07_173727.tar.gz ]

[root@localhost kubectl-helper]# 
```

## 4. View and dump logs of k8s resource(s)

### 4.1 View logs of single selected k8s resource

```bash
[root@localhost kubectl-helper]# ./view_logs_of_k8s_resource.sh

===========================================================================================
# View logs of k8s resources filtered by specified [k8s_resource_type] and [search_keyword]
#
# @author bianyun
# @version 1.1.0
# @date 2023/11/7
===========================================================================================

Usage:
  ./view_logs_of_k8s_resource.sh <k8s_resource_type> <search_keyword> [tail_size]

Note:
  - Supported resource types: [pod,service,deployment,statefulset,daemonset,job,cronjob]
  - tail_size: Used in (kubectl logs --tail $tail_size), default value: [ 500 ]

Examples:
  ./view_logs_of_k8s_resource.sh pod uds
  ./view_logs_of_k8s_resource.sh svc uds-es
  ./view_logs_of_k8s_resource.sh deploy gateway
  ./view_logs_of_k8s_resource.sh sts uds
  ./view_logs_of_k8s_resource.sh ds dns
  ./view_logs_of_k8s_resource.sh job uds
  ./view_logs_of_k8s_resource.sh cj uds

  ./view_logs_of_k8s_resource.sh pod uds-metadata 2000
  ./view_logs_of_k8s_resource.sh svc uds-gateway 5000

[root@localhost kubectl-helper]# 
```

```bash
[root@localhost kubectl-helper]# ./view_logs_of_k8s_resource.sh pod uds

=== Found 10 pods with 'uds' in their names:

    NAMESPACE  NAME                            READY   STATUS    RESTARTS   AGE     IP            NODE     
 1: default    uds-es-master-0                 1/1     Running   0          17h     172.20.0.35   10.1.76.1
 2: default    uds-es-master-1                 1/1     Running   0          17h     172.20.2.35   10.1.76.3
 3: default    uds-es-master-2                 1/1     Running   0          17h     172.20.1.26   10.1.76.2
 4: uds        uds-admin-5574975dbd-mx7tr      1/1     Running   0          6h43m   172.20.1.27   10.1.76.2
 5: uds        uds-auth-8b67fc4c4-8frkt        1/1     Running   0          6h43m   172.20.0.36   10.1.76.1
 6: uds        uds-gateway-7c8c7b5bc4-crnrv    1/1     Running   0          6h43m   172.20.0.37   10.1.76.1
 7: uds        uds-gateway-7c8c7b5bc4-m8sx2    1/1     Running   0          6h43m   172.20.2.36   10.1.76.3
 8: uds        uds-job-admin-85bcd647f7-knfqb  1/1     Running   0          6h43m   172.20.1.28   10.1.76.2
 9: uds        uds-metadata-dccb7ddf9-qx9lh    1/1     Running   0          6h43m   172.20.0.38   10.1.76.1
10: uds        uds-webui-8544cf8fdd-k2t67      1/1     Running   0          6h43m   172.20.1.29   10.1.76.2

=== Please choose one pod to view its logs [1~10] OR type 'q' to quit: 1

=== [INFO] About to execute following command in 1 seconds:
    [ kubectl logs -f --tail=500 uds-es-master-0 ]

--------------------------------- [ Command execution result ] ----------------------------------

Created elasticsearch keystore in /usr/share/elasticsearch/config
[2023-11-06T16:32:22,566][INFO ][o.e.e.NodeEnvironment    ] [uds-es-master-0] using [1] data paths, mounts [[/usr/share/elasticsearch/data (/dev/mapper/centos-root)]], net usable_space [41gb], net total_space [75gb], types [xfs]
[2023-11-06T16:32:22,571][INFO ][o.e.e.NodeEnvironment    ] [uds-es-master-0] heap size [1gb], compressed ordinary object pointers [true]
[2023-11-06T16:32:22,684][INFO ][o.e.n.Node               ] [uds-es-master-0] node name [uds-es-master-0], node ID [-wPDVujdRieXfZbSkK5FSg]
[2023-11-06T16:32:22,684][INFO ][o.e.n.Node               ] [uds-es-master-0] version[6.8.23], pid[1], build[default/docker/4f67856/2022-01-06T21:30:50.087716Z], OS[Linux/3.10.0-957.el7.x86_64/amd64], JVM[AdoptOpenJDK/OpenJDK 64-Bit Server VM/15.0.1/15.0.1+9]
[2023-11-06T16:32:22,685][INFO ][o.e.n.Node               ] [uds-es-master-0] JVM arguments [-Xms1g, -Xmx1g, -XX:+UseG1GC, -XX:G1ReservePercent=25, -XX:InitiatingHeapOccupancyPercent=30, -Des.networkaddress.cache.ttl=60, -Des.networkaddress.cache.negative.ttl=10, -XX:+AlwaysPreTouch, -Xss1m, -Djava.awt.headless=true, -Dfile.encoding=UTF-8, -Djna.nosys=true, -XX:-OmitStackTraceInFastThrow, -XX:+ShowCodeDetailsInExceptionMessages, -Dio.netty.noUnsafe=true, -Dio.netty.noKeySetOptimization=true, -Dio.netty.recycler.maxCapacityPerThread=0, -Dlog4j.shutdownHookEnabled=false, -Dlog4j2.disable.jmx=true, -Dlog4j2.formatMsgNoLookups=true, -Djava.io.tmpdir=/tmp/elasticsearch-13109902201936545823, -XX:+HeapDumpOnOutOfMemoryError, -XX:HeapDumpPath=data, -XX:ErrorFile=logs/hs_err_pid%p.log, -Xlog:gc*,gc+age=trace,safepoint:file=logs/gc.log:utctime,pid,tags:filecount=32,filesize=64m, -Djava.locale.providers=COMPAT, -XX:UseAVX=2, -Des.cgroups.hierarchy.override=/, -Xmx1g, -Xms1g, -Dlog4j2.formatMsgNoLookups=true, -Des.allow_insecure_settings=true, -Des.path.home=/usr/share/elasticsearch, -Des.path.conf=/usr/share/elasticsearch/config, -Des.distribution.flavor=default, -Des.distribution.type=docker]
[2023-11-06T16:32:27,153][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [aggs-matrix-stats]
[2023-11-06T16:32:27,153][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [analysis-common]
[2023-11-06T16:32:27,154][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [ingest-common]
[2023-11-06T16:32:27,154][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [ingest-geoip]
[2023-11-06T16:32:27,154][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [ingest-user-agent]
[2023-11-06T16:32:27,154][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [lang-expression]
[2023-11-06T16:32:27,155][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [lang-mustache]
[2023-11-06T16:32:27,155][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [lang-painless]
[2023-11-06T16:32:27,155][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [mapper-extras]
[2023-11-06T16:32:27,155][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [parent-join]
[2023-11-06T16:32:27,155][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [percolator]
[2023-11-06T16:32:27,156][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [rank-eval]
[2023-11-06T16:32:27,156][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [reindex]
[2023-11-06T16:32:27,156][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [repository-url]
[2023-11-06T16:32:27,156][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [transport-netty4]
[2023-11-06T16:32:27,156][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [tribe]
[2023-11-06T16:32:27,156][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-ccr]
[2023-11-06T16:32:27,157][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-core]
[2023-11-06T16:32:27,157][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-deprecation]
[2023-11-06T16:32:27,157][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-graph]
[2023-11-06T16:32:27,157][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-ilm]
[2023-11-06T16:32:27,158][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-logstash]
[2023-11-06T16:32:27,158][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-ml]
[2023-11-06T16:32:27,158][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-monitoring]
[2023-11-06T16:32:27,158][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-rollup]
[2023-11-06T16:32:27,158][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-security]
[2023-11-06T16:32:27,158][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-sql]
[2023-11-06T16:32:27,158][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-upgrade]
[2023-11-06T16:32:27,159][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded module [x-pack-watcher]
[2023-11-06T16:32:27,160][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded plugin [analysis-ik]
[2023-11-06T16:32:27,160][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded plugin [elasticsearch-repository-oss]
[2023-11-06T16:32:27,160][INFO ][o.e.p.PluginsService     ] [uds-es-master-0] loaded plugin [repository-s3]
[2023-11-06T16:32:34,083][INFO ][o.e.x.s.a.s.FileRolesStore] [uds-es-master-0] parsed [0] roles from file [/usr/share/elasticsearch/config/roles.yml]
[2023-11-06T16:32:35,166][INFO ][o.e.x.m.p.l.CppLogMessageHandler] [uds-es-master-0] [controller/296] [Main.cc@114] controller (64 bit): Version 6.8.23 (Build 31256deab94add) Copyright (c) 2022 Elasticsearch BV
[2023-11-06T16:32:36,778][INFO ][o.e.d.DiscoveryModule    ] [uds-es-master-0] using discovery type [zen] and host providers [settings]
[2023-11-06T16:32:38,380][INFO ][o.e.n.Node               ] [uds-es-master-0] initialized
[2023-11-06T16:32:38,381][INFO ][o.e.n.Node               ] [uds-es-master-0] starting ...
[2023-11-06T16:32:38,608][INFO ][o.e.t.TransportService   ] [uds-es-master-0] publish_address {172.20.0.35:9300}, bound_addresses {0.0.0.0:9300}
[2023-11-06T16:32:38,662][INFO ][o.e.b.BootstrapChecks    ] [uds-es-master-0] bound or publishing to a non-loopback address, enforcing bootstrap checks
[2023-11-06T16:32:43,392][INFO ][o.e.c.s.ClusterApplierService] [uds-es-master-0] detected_master {uds-es-master-2}{xqhVyNrZQ9yCIyjg-bWyug}{rp28aQ3ISUmUfU0BZhiTAQ}{172.20.1.26}{172.20.1.26:9300}{ml.machine_memory=2147483648, ml.max_open_jobs=20, xpack.installed=true, ml.enabled=true}, added {{uds-es-master-1}{y7bl6CBKQ4aYIfB3PkOs0A}{1fGLddPiTnixKCXiXyv6TA}{172.20.2.35}{172.20.2.35:9300}{ml.machine_memory=2147483648, ml.max_open_jobs=20, xpack.installed=true, ml.enabled=true},{uds-es-master-2}{xqhVyNrZQ9yCIyjg-bWyug}{rp28aQ3ISUmUfU0BZhiTAQ}{172.20.1.26}{172.20.1.26:9300}{ml.machine_memory=2147483648, ml.max_open_jobs=20, xpack.installed=true, ml.enabled=true},}, reason: apply cluster state (from master [master {uds-es-master-2}{xqhVyNrZQ9yCIyjg-bWyug}{rp28aQ3ISUmUfU0BZhiTAQ}{172.20.1.26}{172.20.1.26:9300}{ml.machine_memory=2147483648, ml.max_open_jobs=20, xpack.installed=true, ml.enabled=true} committed version [105]])
[2023-11-06T16:32:44,468][INFO ][o.e.x.s.a.TokenService   ] [uds-es-master-0] refresh keys
[2023-11-06T16:32:44,769][INFO ][o.e.x.s.a.TokenService   ] [uds-es-master-0] refreshed keys
[2023-11-06T16:32:44,833][INFO ][o.e.l.LicenseService     ] [uds-es-master-0] license [c9fd231f-10f6-400f-a463-2e58c35d11fb] mode [basic] - valid
[2023-11-06T16:32:44,880][INFO ][o.e.h.n.Netty4HttpServerTransport] [uds-es-master-0] publish_address {172.20.0.35:9200}, bound_addresses {0.0.0.0:9200}
[2023-11-06T16:32:44,881][INFO ][o.e.n.Node               ] [uds-es-master-0] started
[2023-11-06T16:32:44,977][INFO ][o.w.a.d.Monitor          ] [uds-es-master-0] try load config from /usr/share/elasticsearch/config/analysis-ik/IKAnalyzer.cfg.xml
[2023-11-06T16:32:44,979][INFO ][o.w.a.d.Monitor          ] [uds-es-master-0] try load config from /usr/share/elasticsearch/plugins/ik/config/IKAnalyzer.cfg.xml
^C
[root@localhost kubectl-helper]# 
```

### 4.2 View logs of single selected k8s resource with tail-size specified

```bash
[root@localhost kubectl-helper]# ./view_logs_of_k8s_resource.sh pod uds 5

=== Found 10 pods with 'uds' in their names:

    NAMESPACE  NAME                            READY   STATUS    RESTARTS   AGE    IP            NODE     
 1: default    uds-es-master-0                 1/1     Running   0          17h    172.20.0.35   10.1.76.1
 2: default    uds-es-master-1                 1/1     Running   0          17h    172.20.2.35   10.1.76.3
 3: default    uds-es-master-2                 1/1     Running   0          17h    172.20.1.26   10.1.76.2
 4: uds        uds-admin-5574975dbd-mx7tr      1/1     Running   0          7h5m   172.20.1.27   10.1.76.2
 5: uds        uds-auth-8b67fc4c4-8frkt        1/1     Running   0          7h5m   172.20.0.36   10.1.76.1
 6: uds        uds-gateway-7c8c7b5bc4-crnrv    1/1     Running   0          7h5m   172.20.0.37   10.1.76.1
 7: uds        uds-gateway-7c8c7b5bc4-m8sx2    1/1     Running   0          7h5m   172.20.2.36   10.1.76.3
 8: uds        uds-job-admin-85bcd647f7-knfqb  1/1     Running   0          7h5m   172.20.1.28   10.1.76.2
 9: uds        uds-metadata-dccb7ddf9-qx9lh    1/1     Running   0          7h5m   172.20.0.38   10.1.76.1
10: uds        uds-webui-8544cf8fdd-k2t67      1/1     Running   0          7h5m   172.20.1.29   10.1.76.2

=== Please choose one pod to view its logs [1~10] OR type 'q' to quit: 10

=== [INFO] About to execute following command in 1 seconds:
    [ kubectl logs -n uds -f --tail=5 uds-webui-8544cf8fdd-k2t67 ]

--------------------------------- [ Command execution result ] ----------------------------------

2023/11/07 11:08:40 [notice] 7#7: sched_setaffinity(): using cpu #1
2023/11/07 11:08:40 [notice] 8#8: sched_setaffinity(): using cpu #2
2023/11/07 11:08:40 [notice] 8#8: sched_setaffinity(): using cpu #2
2023/11/07 11:08:40 [notice] 6#6: sched_setaffinity(): using cpu #0
2023/11/07 11:08:40 [notice] 6#6: sched_setaffinity(): using cpu #0
^C
[root@localhost kubectl-helper]# 
```

### 4.3 Batch dump logs of multiple selected k8s resources

```bash
[root@localhost kubectl-helper]# ./batch_dump_logs_of_k8s_resources.sh

=================================================================================================
# Batch dump logs of k8s resources filtered by specified [k8s_resource_type] and [search_keyword]
#
# @author bianyun
# @version 1.1.0
# @date 2023/11/7
=================================================================================================

Usage:
  ./batch_dump_logs_of_k8s_resources.sh <k8s_resource_type> <search_keyword> [tail_size]

Note:
  - Supported resource types: [pod, service, deployment, statefulset, daemonset, job, cronjob]
  - tail_size: Used in (kubectl logs --tail $tail_size), default value: [ 500000 ]

Examples:
  ./batch_dump_logs_of_k8s_resources.sh pod uds
  ./batch_dump_logs_of_k8s_resources.sh svc uds-es
  ./batch_dump_logs_of_k8s_resources.sh deploy gateway
  ./batch_dump_logs_of_k8s_resources.sh sts uds
  ./batch_dump_logs_of_k8s_resources.sh ds dns
  ./batch_dump_logs_of_k8s_resources.sh job uds
  ./batch_dump_logs_of_k8s_resources.sh cj uds

  ./batch_dump_logs_of_k8s_resources.sh pod uds-metadata 2000
  ./batch_dump_logs_of_k8s_resources.sh svc uds-gateway 2000000

[root@localhost kubectl-helper]# 
```

```bash
[root@localhost kubectl-helper]# ./batch_dump_logs_of_k8s_resources.sh pod uds

=== Found 10 pods with 'uds' in their names:

    NAMESPACE  NAME                            READY   STATUS    RESTARTS   AGE     IP            NODE     
 1: default    uds-es-master-0                 1/1     Running   0          18h     172.20.0.35   10.1.76.1
 2: default    uds-es-master-1                 1/1     Running   0          18h     172.20.2.35   10.1.76.3
 3: default    uds-es-master-2                 1/1     Running   0          18h     172.20.1.26   10.1.76.2
 4: uds        uds-admin-5574975dbd-mx7tr      1/1     Running   0          7h32m   172.20.1.27   10.1.76.2
 5: uds        uds-auth-8b67fc4c4-8frkt        1/1     Running   0          7h32m   172.20.0.36   10.1.76.1
 6: uds        uds-gateway-7c8c7b5bc4-crnrv    1/1     Running   0          7h32m   172.20.0.37   10.1.76.1
 7: uds        uds-gateway-7c8c7b5bc4-m8sx2    1/1     Running   0          7h32m   172.20.2.36   10.1.76.3
 8: uds        uds-job-admin-85bcd647f7-knfqb  1/1     Running   0          7h32m   172.20.1.28   10.1.76.2
 9: uds        uds-metadata-dccb7ddf9-qx9lh    1/1     Running   0          7h32m   172.20.0.38   10.1.76.1
10: uds        uds-webui-8544cf8fdd-k2t67      1/1     Running   0          7h32m   172.20.1.29   10.1.76.2

=== Please select one or more pods (example: 1~2,4,5~7) to continue OR type 'q' to quit: 1~2,4,6,8~10
=== The final specified seq nums are: [ 1 2 4 6 8 9 10 ]

=== Dumping logs of pod [ default/uds-es-master-0 ] ...
=== Dumping logs of pod [ default/uds-es-master-1 ] ...
=== Dumping logs of pod [ uds/uds-admin-5574975dbd-mx7tr ] ...
=== Dumping logs of pod [ uds/uds-gateway-7c8c7b5bc4-crnrv ] ...
=== Dumping logs of pod [ uds/uds-job-admin-85bcd647f7-knfqb ] ...
=== Dumping logs of pod [ uds/uds-metadata-dccb7ddf9-qx9lh ] ...
=== Dumping logs of pod [ uds/uds-webui-8544cf8fdd-k2t67 ] ...

=== All logs of selected pods have been dumped, the result file:
    [ /root/kubectl-helper/_out/k8s-logs-of-pods_[filtered-by_uds]_2023-11-07_184128.tar.gz ]

[root@localhost kubectl-helper]# 
```

## 5. Container related operations in pod

### 5.1 Enter the first container in the pod
```bash
[root@localhost kubectl-helper]# ./enter_into_k8s_pod.sh uds-es

=== Found 3 pods with 'uds-es' in their names:

    NAMESPACE  NAME             READY   STATUS    RESTARTS   AGE     IP            NODE     
 1: default    uds-es-master-0  1/1     Running   0          18h     172.20.0.35   10.1.76.1
 2: default    uds-es-master-1  1/1     Running   0          18h     172.20.2.35   10.1.76.3
 3: default    uds-es-master-2  1/1     Running   0          18h     172.20.1.26   10.1.76.2

=== Please choose one pod to enter in it [1~3] OR type 'q' to quit: 1

=== [INFO] About to execute following command:
    [ kubectl exec -it uds-es-master-0 -- bash ]

----------------------------- [ NOTE: The part below is inside the container ] -----------------------------

[elasticsearch@uds-es-master-0 ~]$ ls -l
total 460
-rw-r--r--  1 elasticsearch root           13675 Jan  6  2022 LICENSE.txt
-rw-r--r--  1 elasticsearch root          427502 Jan  6  2022 NOTICE.txt
-rw-r--r--  1 elasticsearch root            8534 Jan  6  2022 README.textile
drwxr-xr-x  3 elasticsearch root            4096 Jan  6  2022 bin
drwxrwxr-x  1 elasticsearch root              49 Nov  6 16:32 config
drwxrwsr-x  3 root          elasticsearch     19 Jun 29 07:00 data
drwxr-xr-x  3 elasticsearch root            4096 Jan  6  2022 lib
drwxrwxr-x  1 elasticsearch root              20 Nov  6 16:32 logs
drwxr-xr-x 31 elasticsearch root            4096 Jan  6  2022 modules
drwxr-xr-x  1 elasticsearch root              73 Feb 10  2022 plugins
[elasticsearch@uds-es-master-0 ~]$
exit

[root@localhost kubectl-helper]# 
```

### 5.2 Execute commands directly in the pod container
```bash
[root@localhost kubectl-helper]# ./execute_cmd_in_k8s_pod.sh

================================================================================
# Execute command inside selected k8s pod filtered by specified [search_keyword]
#
# @author bianyun
# @version 1.1.0
# @date 2023/11/7
================================================================================

Usage:
  ./execute_cmd_in_k8s_pod.sh <search_keyword> <"quoted_command_str">

Examples:
  ./execute_cmd_in_k8s_pod.sh uds-es "date +'%Y-%m-%d %H:%M:%S'"
  ./execute_cmd_in_k8s_pod.sh uds-es "cat /etc/os-release"
  ./execute_cmd_in_k8s_pod.sh uds-es "cat /etc/hosts |grep 127.0.0.1"
  ./execute_cmd_in_k8s_pod.sh uds-es "ls -l / --color=always"
  ./execute_cmd_in_k8s_pod.sh uds-es "ls -l / |grep usr --color=auto"
  ./execute_cmd_in_k8s_pod.sh uds-es "ps -ef |grep netty --color=auto"

[root@localhost kubectl-helper]# 
```

```bash
[root@localhost kubectl-helper]# ./execute_cmd_in_k8s_pod.sh uds-es "ls -l / --color=always"

=== Found 3 pods with 'uds-es' in their names:

    NAMESPACE  NAME             READY   STATUS    RESTARTS   AGE   IP            NODE     
 1: default    uds-es-master-0  1/1     Running   0          18h   172.20.0.35   10.1.76.1
 2: default    uds-es-master-1  1/1     Running   0          18h   172.20.2.35   10.1.76.3
 3: default    uds-es-master-2  1/1     Running   0          18h   172.20.1.26   10.1.76.2

=== Please choose one pod to execute your command [1~3] OR type 'q' to quit: 1

=== [INFO] About to execute following command:
    [ kubectl exec -i uds-es-master-0 -- ls -l / --color=always ]

--------------------------------------- [ Command execution result ] ---------------------------------------

total 12
-rw-r--r--   1 root root 12114 Nov 13  2020 anaconda-post.log
lrwxrwxrwx   1 root root     7 Nov 13  2020 bin -> usr/bin
drwxr-xr-x   5 root root   360 Nov  6 16:32 dev
drwxr-xr-x   1 root root    66 Nov  6 16:32 etc
drwxr-xr-x   2 root root     6 Apr 11  2018 home
lrwxrwxrwx   1 root root     7 Nov 13  2020 lib -> usr/lib
lrwxrwxrwx   1 root root     9 Nov 13  2020 lib64 -> usr/lib64
drwxr-xr-x   2 root root     6 Apr 11  2018 media
drwxr-xr-x   2 root root     6 Apr 11  2018 mnt
drwxr-xr-x   1 root root    26 Jan  6  2022 opt
dr-xr-xr-x 276 root root     0 Nov  6 16:32 proc
dr-xr-x---   2 root root   114 Nov 13  2020 root
drwxr-xr-x   1 root root    21 Nov  6 16:32 run
lrwxrwxrwx   1 root root     8 Nov 13  2020 sbin -> usr/sbin
drwxr-xr-x   2 root root     6 Apr 11  2018 srv
dr-xr-xr-x  13 root root     0 Nov  3 00:55 sys
drwxrwxrwt   1 root root   227 Nov  6 16:32 tmp
drwxr-xr-x   1 root root    19 Nov 13  2020 usr
drwxr-xr-x   1 root root    30 Nov 13  2020 var

[root@localhost kubectl-helper]# 
```

## 6. Restart k8s resource(s)

```bash
[root@localhost kubectl-helper]# ./restart_k8s_resources.sh

=====================================================================================
# Restart k8s resource filtered by specified [k8s_resource_type] and [search_keyword]
#
# @author bianyun
# @version 1.1.0
# @date 2023/11/7
=====================================================================================

Usage:
  ./restart_k8s_resources.sh <k8s_resource_type> <search_keyword>
  ./restart_k8s_resources.sh <k8s_resource_type> all <namespace>

Note:
  - Supported k8s resource types: [deployment, daemonset, statefulset]
  - Restarting k8s resources under namespace [kube-system] is prohibited by default

Examples:
  ./restart_k8s_resources.sh deploy nacos
  ./restart_k8s_resources.sh deploy redis
  ./restart_k8s_resources.sh deploy uds
  ./restart_k8s_resources.sh daemonset dns
  ./restart_k8s_resources.sh statefulset uds
  ./restart_k8s_resources.sh deploy all uds
  ./restart_k8s_resources.sh daemonset all kube-system

[root@localhost kubectl-helper]# 
```

### 6.1 Restart single selected k8s resource

```bash
[root@localhost kubectl-helper]# ./restart_k8s_resources.sh deploy uds

=== Found 6 deployments with 'uds' in their names:

    NAMESPACE     NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
 1: uds           uds-admin                   1/1     1            1           29d
 2: uds           uds-auth                    1/1     1            1           29d
 3: uds           uds-gateway                 2/2     2            2           29d
 4: uds           uds-job-admin               1/1     1            1           29d
 5: uds           uds-metadata                1/1     1            1           29d
 6: uds           uds-webui                   1/1     1            1           29d

=== Please choose one deployment to restart it [1~6] OR type 'q' to quit: 1

=== [INFO] About to execute following command:
    [ kubectl rollout restart -n uds deployment/uds-admin ]

--------------------------------------- [ Command execution result ] ---------------------------------------

deployment.apps/uds-admin restarted

[root@localhost kubectl-helper]# 
```

### 6.2 Batch restart k8s resources filtered by type and namespace

```bash
[root@localhost kubectl-helper]# ./restart_k8s_resources.sh deploy all uds

=== Do you want to restart all the deployments under [uds] namespace? [y/n]: y

=== [INFO] About to execute following command:
    [ kubectl get deployment -n uds | awk 'NR>1' | awk '{print $1}' | xargs -I {} kubectl rollout restart deployment -n uds {} ]

--------------------------------------- [ Command execution result ] ---------------------------------------

deployment.apps/uds-admin restarted
deployment.apps/uds-auth restarted
deployment.apps/uds-gateway restarted
deployment.apps/uds-job-admin restarted
deployment.apps/uds-metadata restarted
deployment.apps/uds-webui restarted

[root@localhost kubectl-helper]# 
```

### 6.3 Enable restart k8s resources under `kube-system` namespace

By default, resources under the namespace `kube-system` are not allowed to be restarted. 

```bash
[root@localhost kubectl-helper]# ./restart_k8s_resources.sh daemonset kube-system

=== Found 2 daemonsets with 'kube-system' in their names:

    NAMESPACE    NAME                    DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
 1: kube-system  kube-flannel-ds-amd64   3        3        3      3           3          <none>         29d
 2: kube-system  node-local-dns          3        3        3      3           3          <none>         29d

=== Please choose one daemonset to restart it [1~2] OR type 'q' to quit: 1
=== [WARN] Do not allow restart of daemonsets under namespace [kube-system]

[root@localhost kubectl-helper]# 
```

If you want to remove this limit, you need to change the value of `allow_restart_kube_system_resource` (defined in `_base/common_config`) to `true` in order to allow restarting resources under `kube-system` namespace.

```bash
[root@localhost kubectl-helper]# vi ./_base/common_config

debug="false"
global_out_dir_name="_out"
default_tail_size_for_logs_view=500
default_tail_size_for_logs_dump=500000
allow_restart_kube_system_resource="true"

[root@localhost kubectl-helper]# 
```

After making this change, you can try again.

```bash
[root@localhost kubectl-helper]# ./restart_k8s_resources.sh daemonset kube-system

=== Found 2 daemonsets with 'kube-system' in their names:

    NAMESPACE    NAME                   DESIRED  CURRENT READY UP-TO-DATE AVAILABLE NODE SELECTOR AGE
 1: kube-system  kube-flannel-ds-amd64  3        3       3     3          3         <none>        29d
 2: kube-system  node-local-dns         3        3       3     3          3         <none>        29d

=== Please choose one daemonset to restart it [1~2] OR type 'q' to quit: 1

=== [INFO] About to execute following command:
    [ kubectl rollout restart -n kube-system daemonset/kube-flannel-ds-amd64 ]

--------------------------------------- [ Command execution result ] ---------------------------------------

daemonset.apps/kube-flannel-ds-amd64 restarted

[root@localhost kubectl-helper]# kgpks
NAME                                         READY   STATUS        RESTARTS   AGE
coredns-766956944f-kdmk6                     1/1     Running       0          26h
dashboard-metrics-scraper-7fdfb7dc46-8r7cg   1/1     Running       0          26h
kube-flannel-ds-amd64-btjmh                  1/1     Running       0          33s
kube-flannel-ds-amd64-g7l8g                  1/1     Terminating   0          21h
kube-flannel-ds-amd64-qw9nb                  1/1     Running       0          21h
kubernetes-dashboard-766f6764d7-r5zld        1/1     Running       0          26h
metrics-server-bddd9b766-8kpbr               1/1     Running       0          26h
node-local-dns-cw5dg                         1/1     Running       0          21h
node-local-dns-lk7dg                         1/1     Running       0          21h
node-local-dns-pq7jr                         1/1     Running       0          21h
[root@localhost kubectl-helper]#
```
