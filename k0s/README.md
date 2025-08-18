

## generate config

```sh
k0sctl init > k0sctl.yaml

```

## apply configs

```sh
k0sctl apply --config k0sctl.yaml

k0sctl apply --config k0sctl.yaml verbose

```

## To access the cluster you can now fetch the admin kubeconfig using: 

```sh
k0sctl kubeconfig 

```

## validate

```sh

k0s config validate --config k0s

```

## Zip

```sh
sudo apt update
sudo apt install -y pigz
# if unpigz missing, make a symlink
sudo ln -s /usr/bin/pigz /usr/bin/unpigz 2>/dev/null || true

```

## make a node

```sh
k0s kubectl create deployment green --image jpetazzo/color --replicas 1
k0s kubectl expose deployment green --port 80 --type NodePort --namespace blue

```

## disk limit
if encounter any disk limit you can bypass it using this:
```sh
      tolerations:
      - key: "node.kubernetes.io/disk-pressure"
        operator: "Exists"
        effect: "NoSchedule"
      dnsPolicy: ClusterFirst
```

## test the pod

```sh
curl http://192.227.184.126:30878/
🟢This is pod default/green-84545c56ff-k448z on linux/amd64, serving / for 10.244.0.1:13497.
```