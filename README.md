# Rancher Bootstrap Scripts (Templated)

This project automates the setup of Rancher using K3s, Cert-Manager, and Let's Encrypt with Cloudflare DNS.

## 🧩 Files & Templates

- `config.env.example` – Copy this to `config.env` and edit for your domain
- `1-install-k3s.sh` – Installs K3s (no Traefik) and sets up kubeconfig for user 'erin'
- `2-install-cert-manager.sh` – Installs cert-manager v1.17.1
- `3-install-rancher.sh` – Installs Rancher via Helm using the hostname from config
- `clusterissuer.yaml.template` – Cert-Manager issuer using Cloudflare DNS challenge
- `rancher-cert.yaml.template` – TLS cert for Rancher ingress
- `bootstrap.sh` – Optional script to render YAMLs and apply everything

## 🚀 Quick Start

1. Copy and edit your configuration:
   ```bash
   cp config.env.example config.env
   nano config.env
   ```

2. Run scripts in order:
   ```bash
   chmod +x *.sh
   ./1-install-k3s.sh
   ./2-install-cert-manager.sh
   ./bootstrap.sh
   ./3-install-rancher.sh
   ```

## 🔧 Hardcoding Instead?

If you prefer **not to use templates**, just replace values like domain and email directly inside:
- `clusterissuer.yaml`
- `rancher-cert.yaml`
- Helm commands in `3-install-rancher.sh`

Then skip the `.env` and `envsubst` steps entirely.

## 📎 Requirements

- Cloudflare API token with DNS edit permissions
- DNS A record pointing your domain (e.g. rancher.example.com) to the node IP
