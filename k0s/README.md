

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