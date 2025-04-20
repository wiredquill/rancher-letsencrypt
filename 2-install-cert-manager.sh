#!/bin/bash
set -e

echo "Installing cert-manager v1.17.1..."

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.17.1/cert-manager.yaml

echo "Waiting for cert-manager to be ready..."
kubectl rollout status deploy/cert-manager -n cert-manager --timeout=120s
kubectl rollout status deploy/cert-manager-webhook -n cert-manager --timeout=120s
