#!/bin/bash
set -e

# Install K3s without Traefik
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" INSTALL_K3S_VERSION="v1.31.6+k3s1" sh -

# Make the kubeconfig readable for erin
sudo chmod +r /etc/rancher/k3s/k3s.yaml
sudo mkdir -p /home/erin/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/erin/.kube/config
sudo chown erin:erin /home/erin/.kube/config
sudo chmod 600 /home/erin/.kube/config

# Add KUBECONFIG to erin's shell
grep -qxF 'export KUBECONFIG=$HOME/.kube/config' /home/erin/.bashrc || echo 'export KUBECONFIG=$HOME/.kube/config' >> /home/erin/.bashrc