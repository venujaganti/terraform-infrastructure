#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${PROJECT_ROOT}"

echo "========================================"
echo " Terraform Security Scan"
echo "========================================"

echo ""
echo "[1/4] Terraform formatting check..."
terraform fmt -check -recursive

echo ""
echo "[2/4] Terraform initialization and validation..."
for ENVIRONMENT in dev staging production; do
  echo ""
  echo "Checking environment: ${ENVIRONMENT}"
  terraform -chdir="environments/${ENVIRONMENT}" init -backend=false -input=false
  terraform -chdir="environments/${ENVIRONMENT}" validate -no-color
done

echo ""
echo "[3/4] TFLint..."
if command -v tflint >/dev/null 2>&1; then
  tflint --init
  tflint --recursive
else
  echo "WARNING: TFLint is not installed."
  echo "Skipping TFLint scan."
fi

echo ""
echo "[4/4] Trivy..."
if command -v trivy >/dev/null 2>&1; then
  trivy config     --severity HIGH,CRITICAL     --exit-code 1     "${PROJECT_ROOT}"
else
  echo "WARNING: Trivy is not installed."
  echo "Skipping Trivy scan."
fi

echo ""
echo "Security scan completed successfully."
