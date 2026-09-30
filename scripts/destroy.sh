#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

ENVIRONMENT="${1:-}"

if [[ -z "${ENVIRONMENT}" ]]; then
  echo "ERROR: Environment is required."
  echo "Usage: ./scripts/destroy.sh [dev|staging|production]"
  exit 1
fi

case "${ENVIRONMENT}" in
  dev|staging|production)
    ;;
  *)
    echo "ERROR: Invalid environment: ${ENVIRONMENT}"
    echo "Allowed values: dev, staging, production"
    exit 1
    ;;
esac

ENVIRONMENT_DIR="${PROJECT_ROOT}/environments/${ENVIRONMENT}"

if [[ ! -d "${ENVIRONMENT_DIR}" ]]; then
  echo "ERROR: Environment directory does not exist:"
  echo "${ENVIRONMENT_DIR}"
  exit 1
fi

cd "${ENVIRONMENT_DIR}"

echo "========================================"
echo " Terraform Destroy"
echo " Environment: ${ENVIRONMENT}"
echo "========================================"

if [[ "${ENVIRONMENT}" == "production" ]]; then
  echo ""
  echo "WARNING: You are attempting to destroy PRODUCTION."
fi

terraform init
terraform validate

echo ""
echo "Generating destroy plan..."

terraform plan \
  -destroy \
  -var-file="terraform.tfvars" \
  -out="destroy.tfplan"

echo ""
read -r -p "Type 'destroy-${ENVIRONMENT}' to continue: " CONFIRM

if [[ "${CONFIRM}" != "destroy-${ENVIRONMENT}" ]]; then
  echo "Destroy cancelled."
  rm -f "destroy.tfplan"
  exit 0
fi

terraform apply "destroy.tfplan"

rm -f "destroy.tfplan"

echo ""
echo "Terraform destroy completed successfully."