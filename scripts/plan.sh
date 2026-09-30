#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

ENVIRONMENT="${1:-dev}"

case "${ENVIRONMENT}" in
  dev|staging|production)
    ;;
  *)
    echo "ERROR: Invalid environment: ${ENVIRONMENT}"
    echo "Usage: ./scripts/plan.sh [dev|staging|production]"
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
echo " Terraform Plan"
echo " Environment: ${ENVIRONMENT}"
echo "========================================"

terraform init
terraform validate
terraform plan -var-file="terraform.tfvars"

echo ""
echo "Terraform plan completed successfully."