#!/bin/bash
set -e

# Install k3s without Traefik
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" INSTALL_K3S_VERSION="v1.31.6+k3s1" sh -

# Symlink kubeconfig
mkdir -p ~/.kube
ln -sf /etc/rancher/k3s/k3s.yaml ~/.kube/config
chmod 600 ~/.kube/config
