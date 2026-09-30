#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${PROJECT_ROOT}"

echo "========================================"
echo " Terraform Validation"
echo "========================================"

terraform fmt -check -recursive

for ENVIRONMENT in dev staging production; do
  echo ""
  echo "Validating environment: ${ENVIRONMENT}"
  terraform -chdir="environments/${ENVIRONMENT}" init -backend=false -input=false
  terraform -chdir="environments/${ENVIRONMENT}" validate -no-color
done

echo ""
echo "Terraform validation completed successfully."
