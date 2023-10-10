# kubectl-helper
kubectl-helper is a set of scripts that encapsulate common kubectl commands and is used to simplify common operations of kubectl commands.

## 1. Install
```bash
[root@localhost ~]# wget https://github.com/bianyun/kubectl-helper/releases/download/1.0.0/kubectl-helper_v1.0.0.tar.gz
[root@localhost ~]# tar zxf kubectl-helper_v1.0.0.tar.gz
[root@localhost ~]# cd kubectl-helper
[root@localhost kubectl-helper]# ./setup_kubectl_aliases.sh init
=== [WARN] Please log out and log in again for the alias settings to take effect.

[root@localhost kubectl-helper]#
```

## 2. Usage

### 2.1 Aliases

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
kgpvcw='kubectl get pvc -o wide'
kgpvcwa='kubectl get pvc -o wide -A'

kgds='kubectl get daemonset'
kgdsa='kubectl get daemonset -A'
kgdsw='kubectl get daemonset -o wide'
kgdswa='kubectl get daemonset -o wide -A'

kgp='kubectl get pod'
kgpa='kubectl get pod -A'
kgpks='kubectl get pod -n kube-system'
kgpu='kubectl get pod -n uds'

kgpw='kubectl get pod -o wide'
kgpwa='kubectl get pod -o wide -A'
kgpwks='kubectl get pod -o wide -n kube-system'
kgpwu='kubectl get pod -o wide -n uds'

kge='kubectl get endpoints'
kgea='kubectl get endpoints -A'
kgeks='kubectl get endpoints -n kube-system'
kgeu='kubectl get endpoints -n uds'

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
[root@localhost kubectl-helper]# kgp
NAME                                  READY   STATUS    RESTARTS   AGE
docker-registry-789c879688-q79sm      1/1     Running   0          21h
docker-registry-ui-7c57784c4f-r5hwn   1/1     Running   0          21h
nacos-fdc58599f-2z9gt                 1/1     Running   0          21h
redis-85f4b69747-pjb7w                1/1     Running   0          33m
uds-es-master-0                       1/1     Running   0          21h
uds-es-master-1                       1/1     Running   0          21h
uds-es-master-2                       1/1     Running   0          21h
[root@localhost kubectl-helper]# kgs
NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
docker-registry          NodePort    10.68.58.161    <none>        15000:15000/TCP                 21h
docker-registry-ui-svc   NodePort    10.68.88.110    <none>        15080:15080/TCP                 21h
kubernetes               ClusterIP   10.68.0.1       <none>        443/TCP                         21h
nacos-svc                NodePort    10.68.27.64     <none>        8848:18848/TCP                  21h
redis-svc                ClusterIP   10.68.178.213   <none>        6379/TCP                        21h
uds-es-master            NodePort    10.68.21.188    <none>        9200:30092/TCP,9300:25803/TCP   21h
uds-es-master-headless   ClusterIP   None            <none>        9200/TCP,9300/TCP               21h
[root@localhost kubectl-helper]# kgd
NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
docker-registry      1/1     1            1           21h
docker-registry-ui   1/1     1            1           21h
nacos                1/1     1            1           21h
redis                1/1     1            1           21h
[root@localhost kubectl-helper]# kgpks
NAME                                         READY   STATUS    RESTARTS   AGE
coredns-7897776644-vxmsw                     1/1     Running   0          21h
dashboard-metrics-scraper-79c5968bdc-6l5c6   1/1     Running   0          21h
kube-flannel-ds-amd64-8l57t                  1/1     Running   0          21h
kube-flannel-ds-amd64-9mlkw                  1/1     Running   0          21h
kube-flannel-ds-amd64-np2hs                  1/1     Running   0          21h
kubernetes-dashboard-79df5cdfd5-fc4wj        1/1     Running   0          21h
metrics-server-8568cf894b-49qd4              1/1     Running   0          21h
node-local-dns-jsjk5                         1/1     Running   0          22m
node-local-dns-l2kp5                         1/1     Running   0          22m
node-local-dns-xvmxp                         1/1     Running   0          22m
[root@localhost kubectl-helper]#
```

### 2.1 Describe k8s resource
```bash
[root@localhost kubectl-helper]# ./describe_k8s_resource.sh pod redis

=== Found 1 pod with 'redis' in its name:

NAMESPACE     NAME                                         READY   STATUS    RESTARTS   AGE
default       redis-67b8897c5c-x2ps6                       1/1     Running   0          20h

=== Do you want to describe it [y/n]? : n

[root@localhost kubectl-helper]#
```

```bash
[root@localhost kubectl-helper]# ./describe_k8s_resource.sh pod uds-es

=== Found 3 pods with 'uds-es' in their names:

    NAMESPACE     NAME                                         READY   STATUS    RESTARTS   AGE
 1: default       uds-es-master-0                              1/1     Running   0          20h
 2: default       uds-es-master-1                              1/1     Running   0          20h
 3: default       uds-es-master-2                              1/1     Running   0          20h

=== Please choose one pod to describe it [1~3] or type 'q' to quit: q

[root@localhost kubectl-helper]#
```

### 3. Logs Related

#### 3.1 View Pod logs
```bash
[root@localhost kubectl-helper]# ./view_pod_logs.sh uds-es

=== Found 3 pods with 'uds-es' in their names:

    NAMESPACE     NAME                                         READY   STATUS    RESTARTS   AGE
 1: default       uds-es-master-0                              1/1     Running   0          20h
 2: default       uds-es-master-1                              1/1     Running   0          20h
 3: default       uds-es-master-2                              1/1     Running   0          20h

=== Please choose one pod to view its logs [1~3] or type 'q' to quit: q

[root@localhost kubectl-helper]#
```

#### 3.2 View Service logs

```bash
[root@localhost kubectl-helper]# ./view_svc_logs.sh uds-es

=== Found 2 svcs with 'uds-es' in their names:

    NAMESPACE     NAME                        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
 1: default       uds-es-master               NodePort    10.68.21.188    <none>        9200:30092/TCP,9300:25803/TCP   20h
 2: default       uds-es-master-headless      ClusterIP   None            <none>        9200/TCP,9300/TCP               20h

=== Please choose one svc to view its logs [1~2] or type 'q' to quit: q

[root@localhost kubectl-helper]#
```

#### 3.3 View deployment logs
```bash
[root@localhost kubectl-helper]# ./view_deploy_logs.sh nacos

=== Found 1 deployment with 'nacos' in its name:

NAMESPACE     NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
default       nacos                       1/1     1            1           20h

=== Do you want to view its logs [y/n]? : n

[root@localhost kubectl-helper]#
```

#### 3.4 Dump pod logs to local file
```bash
[root@localhost kubectl-helper]# ./dump_pod_logs_to_file.sh uds-es

=== Found 3 pods with 'uds-es' in their names:

    NAMESPACE     NAME                                         READY   STATUS    RESTARTS   AGE
 1: default       uds-es-master-0                              1/1     Running   0          20h
 2: default       uds-es-master-1                              1/1     Running   0          20h
 3: default       uds-es-master-2                              1/1     Running   0          20h

=== Please choose one pod to dump its logs to file [1~3] or type 'q' to quit: 2

=== Dumping pod logs to file for pod [uds-es-master-1]...
=== Pod logs has been successfully dumped to file:
    [/root/kubectl-helper/pod_logs_dump/uds-es-master-1_2023-10-10_0904.log]

[root@localhost kubectl-helper]#
```

### 4. Pod container related

#### 4.1 Enter the first container inside the Pod
```bash
[root@localhost kubectl-helper]# ./enter_into_k8s_pod.sh nacos

=== Found 1 pod with 'nacos' in its name:

NAMESPACE     NAME                                         READY   STATUS    RESTARTS   AGE
default       nacos-fdc58599f-2z9gt                        1/1     Running   0          20h

=== Do you want to enter in it [y/n]? : y

[root@nacos-fdc58599f-2z9gt nacos]# ll
total 28
-rw-r--r-- 1  502 games 16583 Dec 15  2020 LICENSE
-rw-r--r-- 1  502 games  1305 May 14  2020 NOTICE
drwxr-xr-x 1 root root     31 Jan 16  2021 bin
drwxr-xr-x 1  502 games    36 Jan 16  2021 conf
drwxr-xr-x 4 root root     39 Oct  9 12:28 data
drwxr-xr-x 2 root root     31 Jan 16  2021 init.d
drwxr-xr-x 1 root root   4096 Oct 10 08:09 logs
drwxr-xr-x 2 root root     30 Jan 16  2021 target
drwxr-xr-x 3 root root     20 Oct  9 12:27 work
[root@nacos-fdc58599f-2z9gt nacos]# exit
exit
[root@localhost kubectl-helper]#
```

#### 4.2 Directly execute commands in the internal container of the Pod
```bash
[root@localhost kubectl-helper]# ./execute_cmd_in_pod.sh nacos cat /etc/os-release

=== Found 1 pod with 'nacos' in its name:

NAMESPACE     NAME                                         READY   STATUS    RESTARTS   AGE
default       nacos-fdc58599f-2z9gt                        1/1     Running   0          20h

=== Do you want to execute your command [y/n]? : y

NAME="CentOS Linux"
VERSION="7 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="7"
PRETTY_NAME="CentOS Linux 7 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:7"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-7"
CENTOS_MANTISBT_PROJECT_VERSION="7"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="7"


[root@localhost kubectl-helper]#
```


### 5. Restart k8s resources

By default, resources under the namespace kube-system are not allowed to be restarted. 
You can set the variable `allow_restart_kube_system_resource` (defined in the script `_base/do_restart_k8s_resource.sh`) to true to allow resources under the kube-system namespace to be restarted.

#### 5.1 Restart deployment
```bash
[root@localhost kubectl-helper]# ./restart_k8s_deployment.sh redis

=== Found 1 deployment with 'redis' in its name:

NAMESPACE     NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
default       redis                       1/1     1            1           20h

=== Do you want to restart it [y/n]? : y

deployment.apps/redis restarted

[root@localhost kubectl-helper]#
```

#### 5.2 Restart daemonset

```bash
[root@localhost kubectl-helper]# ./restart_k8s_daemonset.sh dns

=== Found 1 daemonset with 'dns' in its name:

NAMESPACE     NAME                    DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-system   node-local-dns          3         3         3       3            3           <none>          21h

=== Do you want to restart it [y/n]? : y

=== [WARN] Do not allow restarting of daemonsets under namespace [kube-system]

[root@localhost kubectl-helper]#
```

After setting value of variable `allow_restart_kube_system_resource` to true, then you can restart daemonset under namespace `kube-system`
```bash
[root@localhost kubectl-helper]# ./restart_k8s_daemonset.sh dns

=== Found 1 daemonset with 'dns' in its name:

NAMESPACE     NAME                    DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-system   node-local-dns          3         3         3       3            3           <none>          21h

=== Do you want to restart it [y/n]? : y

daemonset.apps/node-local-dns restarted

[root@localhost kubectl-helper]# kgpks
NAME                                         READY   STATUS        RESTARTS   AGE
coredns-7897776644-vxmsw                     1/1     Running       0          21h
dashboard-metrics-scraper-79c5968bdc-6l5c6   1/1     Running       0          21h
kube-flannel-ds-amd64-8l57t                  1/1     Running       0          21h
kube-flannel-ds-amd64-9mlkw                  1/1     Running       0          21h
kube-flannel-ds-amd64-np2hs                  1/1     Running       0          21h
kubernetes-dashboard-79df5cdfd5-fc4wj        1/1     Running       0          21h
metrics-server-8568cf894b-49qd4              1/1     Running       0          21h
node-local-dns-89nbw                         0/1     Terminating   0          21h
node-local-dns-l2kp5                         1/1     Running       0          11s
node-local-dns-qnhgq                         1/1     Running       0          21h
[root@localhost kubectl-helper]#
```

#### 5.3 Restart statefulset

```bash
[root@localhost kubectl-helper]# ./restart_k8s_statefulset.sh dns

=== No statefulsets with 'dns' in the name were found.

[root@localhost kubectl-helper]#
```
