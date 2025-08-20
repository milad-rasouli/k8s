## create namespace
```sh
k0s kubectl create namespace argocd

```
## install argocd
```sh

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

```

## quick test

```sh
k0s kubectl -n argocd port-forward svc/argocd-server 8080:80

```
```sh
k0s kubectl expose deployment argocd-server --port 80 --type NodePort -n argocd
```

## always create a backup

```sh
k0s kubectl -n argocd get svc argocd-server -o yaml > /root/argocd-server.svc.backup.yaml

```
### edit it 
```sh
k0s kubectl -n argocd edit svc argocd-server

```

### Replace Cluster spec with

```yaml
  type: NodePort
  selector:
    app.kubernetes.io/name: argocd-server
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 8080
      nodePort: 30080
    - name: https
      protocol: TCP
      port: 443
      targetPort: 8080
      nodePort: 30443
  sessionAffinity: None
```
### verify changes
```sh
k0s kubectl -n argocd get svc argocd-server -o wide
k0s kubectl -n argocd describe svc argocd-server

```

### get username and password

```sh
# prints the initial admin password (newline appended)
k0s kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo

# username is:
echo admin

```

# fully remove k0s

### 1. Stop and disable k0s services

```sh
systemctl stop k0scontroller k0sworker || true
systemctl disable k0scontroller k0sworker || true
systemctl daemon-reload
```

---

### 2. Remove systemd unit files

```sh
rm -f /etc/systemd/system/k0scontroller.service
rm -f /etc/systemd/system/k0sworker.service
systemctl daemon-reload
```

---

### 3. Clean up k0s binaries

```sh
rm -f /usr/local/bin/k0s
```

(If you installed from a package, also remove via package manager: `apt remove k0s -y` or equivalent.)

---

### 4. Remove runtime data and configs

```sh
rm -rf /etc/k0s
rm -rf /var/lib/k0s
rm -rf /var/lib/kubelet
rm -rf /var/lib/containerd
rm -rf /run/k0s
rm -rf /var/log/pods
rm -rf /var/log/containers
```

---

### 5. Optional (wipe CNI networking leftovers)

```sh
rm -rf /etc/cni
rm -rf /var/lib/cni
ip link delete cni0 || true
ip link delete flannel.1 || true
```

---

### 6. Verify cleanup

```sh
ps aux | egrep 'k0s|containerd' --color=auto
systemctl list-units | grep k0s
```

No processes or services should remain.

---


```sh
curl -sSLf https://get.k0s.sh | sh
k0s install controller --single
k0s start
```

