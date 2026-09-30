.PHONY: init fmt validate lint docs

ENVIRONMENTS := dev staging production

init:
	@for env in $(ENVIRONMENTS); do \
		echo "Initializing $$env..."; \
		terraform -chdir=environments/$$env init; \
	done

fmt:
	terraform fmt -recursive

validate:
	@set -e; \
	for env in $(ENVIRONMENTS); do \
		echo "Validating $$env..."; \
		terraform -chdir=environments/$$env init -backend=false; \
		terraform -chdir=environments/$$env validate; \
	done

lint:
	tflint --recursive

docs:
	terraform-docs .
