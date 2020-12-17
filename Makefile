validate:
	sh scripts/validate.sh

install:
	sh scripts/install.sh


secret_name = "grafana-admin-credentials"
namespace = "monitoring"
password = "admin"
env = "lab"

seal-grafana-password: _sealed_secret_cert
	mkdir -p .secrets/generated

	echo ">> Generating plain Kubernetes secret"

	kubectl create secret generic $(secret_name)  -n $(namespace) \
		--from-literal=admin-user=admin \
		--from-literal=admin-password=$(password) \
		--dry-run \
		-o yaml > .secrets/$(secret_name).yaml

	echo ">> Sealing secret"
	
	kubeseal --format=yaml \
		--cert=.secrets/pub-cert.pem \
		--scope=strict \
		--namespace=$(namespace) < .secrets/$(secret_name).yaml > .secrets/generated/$(secret_name).yaml

	mv .secrets/generated/$(secret_name).yaml clusters/$(env)/$(secret_name).yaml
	rm .secrets/$(secret_name).yaml

_sealed_secret_cert:
	mkdir -p .secrets
	
	echo ">> Fetching public cert"

	kubeseal --fetch-cert \
	--controller-name=sealed-secrets \
	--controller-namespace=kube-system \
	> .secrets/pub-cert.pem
