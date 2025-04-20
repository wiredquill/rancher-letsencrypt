#!/bin/bash
set -e

echo "Creating namespace for Rancher..."
kubectl create namespace cattle-system || true

echo "Adding Rancher Helm repo..."
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update

echo "Installing Rancher..."
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.wiredquill.com \
  --set ingress.tls.source=secret \
  --set ingress.ingressClassName=nginx \
  --set privateCA=false \
  --set replicas=1 \
  --set global.cattle.psp.enabled=false

echo "Waiting for Rancher deployment to complete..."
kubectl rollout status deploy/rancher -n cattle-system --timeout=300s
