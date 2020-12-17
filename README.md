![Kustomize Validate](https://github.com/IbraheemAlSaady/fluxcd-demo/workflows/validate/badge.svg)

# FluxCD Demo
A FluxCD repo used for demo purposes

## Prerequisites

1. Minikube or k3d to create kubernetes clusters
2. Kubectl
3. Helm
4. Kubeseal 
5. Kustomize

## Installing
Before installing make sure that you have a Kubernetes instance running and your `~/.kube/config` is set.

1. **Fork** this repo and then clone it
2. Run `make install`
3. Keep an eye on the logs, you will be given prompted with a public key, this key needs to be added as an SSH key in your Github. After adding the SSH key, give it a minute for the installation to complete
4. Run `make seal-grafana-password` to generate a SealedSecret version of the Grafana password
5. Push the changes to master