#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

ENVIRONMENT="${1:-}"

if [[ -z "${ENVIRONMENT}" ]]; then
  echo "ERROR: Environment is required."
  echo "Usage: ./scripts/apply.sh [dev|staging|production]"
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
echo " Terraform Apply"
echo " Environment: ${ENVIRONMENT}"
echo "========================================"

terraform init
terraform validate

echo ""
echo "Review the Terraform plan before continuing."

terraform plan -var-file="terraform.tfvars" -out="tfplan"

echo ""
read -r -p "Apply this plan? Type 'yes' to continue: " CONFIRM

if [[ "${CONFIRM}" != "yes" ]]; then
  echo "Apply cancelled."
  rm -f "tfplan"
  exit 0
fi

terraform apply "tfplan"

rm -f "tfplan"

echo ""
echo "Terraform apply completed successfully."