set -e

if [[ ! -x "$(command -v kubectl)" ]]; then
    echo "kubectl not found"
    exit 1
fi

if [[ ! -x "$(command -v helm)" ]]; then
    echo "helm not found"
    exit 1
fi

echo ">> Delete Sealed Secrets"
helm delete sealed-secrets --namespace kube-system

echo ">> Delete Helm Operator"
helm delete helm-operator --namespace flux-system
kubectl delete -f https://raw.githubusercontent.com/fluxcd/helm-operator/1.1.0/deploy/crds.yaml

echo ">> Delete Flux"
helm delete flux --namespace flux-system

echo ">> Delete namespace flux-system"
kubectl delete ns flux-system