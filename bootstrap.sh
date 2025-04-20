#!/bin/bash
set -e
source ./config.env

echo "[+] Creating Cloudflare secret..."
kubectl create namespace cert-manager || true
kubectl create secret generic cloudflare-api-token-secret \
  --from-literal=api-token="$CLOUDFLARE_API_TOKEN" \
  -n cert-manager

echo "[+] Generating YAML manifests from templates..."
envsubst < clusterissuer.yaml.template > clusterissuer.yaml
envsubst < rancher-cert.yaml.template > rancher-cert.yaml

echo "[+] Applying issuer and cert..."
kubectl apply -f clusterissuer.yaml
kubectl apply -f rancher-cert.yaml
