#!/bin/bash
set -e

# Install k3s without Traefik
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" INSTALL_K3S_VERSION="v1.31.6+k3s1" sh -

# Make the k3s config world-readable
sudo chmod +r /etc/rancher/k3s/k3s.yaml

# Set up kubeconfig for current user (assumes it's 'erin')
mkdir -p /home/erin/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/erin/.kube/config
sudo chown erin:erin /home/erin/.kube/config
chmod 600 /home/erin/.kube/config
