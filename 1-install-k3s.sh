#!/bin/bash
set -e

# Install K3s without Traefik
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" INSTALL_K3S_VERSION="v1.31.6+k3s1" sh -

# Make the kubeconfig readable for user 'erin'
chmod +r /etc/rancher/k3s/k3s.yaml
mkdir -p /home/erin/.kube
cp /etc/rancher/k3s/k3s.yaml /home/erin/.kube/config
chown erin:erin /home/erin/.kube/config
chmod 600 /home/erin/.kube/config

# Add KUBECONFIG to erin's shell
grep -qxF 'export KUBECONFIG=$HOME/.kube/config' /home/erin/.bashrc || echo 'export KUBECONFIG=$HOME/.kube/config' >> /home/erin/.bashrc
