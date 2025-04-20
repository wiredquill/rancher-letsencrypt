# Rancher Bootstrap Scripts

This repo contains scripts and manifests to provision a K3s cluster with Rancher and Cert-Manager using Let's Encrypt and Cloudflare DNS challenge.

## 📦 Components
- **K3s** (v1.31.6+k3s1) — no Traefik
- **Cert-Manager** (v1.17.1)
- **Rancher** — latest Helm chart
- **Let's Encrypt ClusterIssuer** using Cloudflare DNS
- **TLS Certificate** for `rancher.wiredquill.com`

## 🚀 Usage

Run these steps on a clean Linux node (SLES, Ubuntu, etc.):

```bash
chmod +x install-*.sh
./install-k3s.sh
./install-cert-manager.sh

# Manually create your Cloudflare secret
kubectl create ns cert-manager
kubectl create secret generic cloudflare-api-token-secret \
  --from-literal=api-token='YOUR_CLOUDFLARE_API_TOKEN' \
  -n cert-manager

# Apply issuer and Rancher certificate
kubectl apply -f clusterissuer.yaml
./install-rancher.sh
kubectl apply -f rancher-cert.yaml
```

## 💡 Notes
- Ensure DNS (e.g., Cloudflare) points `rancher.wiredquill.com` to the node IP
- Cert-Manager will handle TLS via DNS-01 challenge

## 📁 Cloud Init
You can use `cloud-init.yaml` for automatic provisioning in cloud environments.
