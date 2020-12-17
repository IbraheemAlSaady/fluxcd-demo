check:
	sh scripts/kustomize-check.sh

install:
	sh scripts/install.sh

seal-grafana-password:
	mkdir -p .secrets/generated

	echo ">> Generating Kubernetes Secret"

	secret_name = "grafana-admin-credentials"
	namespace = "monitoring"

	kubectl -n $(namespace) create secret generic $(secret_name) \
		--from-literal=admin-user=admin \
		--from-literal=admins-password=$(pass) \
		--dry-run \
		-o json > .secrets/$(secret_name).json

	echo ">> 
	
	kubeseal --format=yaml \
		--scope=strict \
		--namespace=$(namespace) < .secrets/$(secret_name).json > .secrets/generated/$(secret_name).yaml