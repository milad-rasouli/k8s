

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