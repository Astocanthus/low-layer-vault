# Vault ACME Plugin Setup Guide

[![Vault Plugin](https://img.shields.io/badge/Vault%20Plugin-ACME-black?style=for-the-badge&logo=vault&logoColor=white)](https://github.com/Boostport/vault-plugin-secrets-acme)
[![Let's Encrypt](https://img.shields.io/badge/Let's%20Encrypt-003A70?style=for-the-badge&logo=letsencrypt&logoColor=white)](https://letsencrypt.org/)
[![Route53](https://img.shields.io/badge/Route53-FF9900?style=for-the-badge&logo=amazonroute53&logoColor=white)](https://aws.amazon.com/route53/)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Plugin Version](https://img.shields.io/github/v/release/Boostport/vault-plugin-secrets-acme)](https://github.com/Boostport/vault-plugin-secrets-acme/releases)

This guide shows how to install and configure the Vault ACME plugin for automated certificate management using Let's Encrypt and Route53 DNS validation.

**Note:** This configuration uses Route53 as an example, but the plugin supports many DNS providers. You can adapt the configuration for any supported provider by following the documentation at: [DNS Providers Configuration](https://github.com/Boostport/vault-plugin-secrets-acme/blob/main/website/source/docs/secrets/acme/dns-providers.html.md)

## 📥 Installation

### 1. Download the Plugin

For Synology systems, download the appropriate version:

```bash
# Download from GitHub releases
wget https://github.com/Boostport/vault-plugin-secrets-acme/releases/download/<version>/vault-plugin-secrets-acme_<version>_linux_amd64
```

Place the binary in your vault plugins directory: `/vault/plugins/vault-plugin-secrets-acme`

### 2. Set Permissions and Capabilities

```bash
# In the vault container
# Set executable permissions
chmod 750 /vault/plugins/vault-plugin-secrets-acme

# Set capabilities for vault and plugin
setcap cap_ipc_lock=+ep $(readlink -f $(which vault))
setcap cap_ipc_lock=+ep /vault/plugins/vault-plugin-secrets-acme
```

### 3. Register and Enable the Plugin

```bash
# Register the plugin in Vault's catalog
vault write sys/plugins/catalog/secret/acme \
  sha_256="$(sha256sum /vault/plugins/vault-plugin-secrets-acme | cut -d' ' -f1)" \
  command="vault-plugin-secrets-acme"

# Enable the secrets engine
vault secrets enable -path acme -plugin-name acme plugin

# Configure lease settings (8760h = 1 year)
vault secrets tune -max-lease-ttl=8760h acme
```

## ⚡ Resource Management

The ACME plugin can be resource-intensive during certificate revokation. To limit CPU usage:

```bash
# Install cpulimit
apk add --no-cache cpulimit

# Start vault with CPU limiting (400% = 4 cores max)
cpulimit -l 400 -p $(pidof vault) & vault server -config=/vault/config/vault.hcl
```

## 🚀 Manual configuration example

### 1. Create ACME Account (Staging Environment)

```bash
vault write acme/accounts/letsencrypt-staging \
  provider="route53" \
  server_url=https://acme-staging-v02.api.letsencrypt.org/directory \
  dns_resolvers="1.1.1.1" \
  contact="contact@low-layer.com" \
  terms_of_service_agreed=true
```

### 2. Create Certificate Role

```bash
vault write acme/roles/staging-low-layer \
  account=letsencrypt-staging \
  allowed_domains=low-layer.com \
  allow_bare_domains=false \
  allow_subdomains=true
```

## 🛠️ Terraform example
For automated provisioning using Terraform, refer to
[low-layer configuration project](https://github.com/Astocanthus/low-layer-platform/blob/main/terraform/vault/r_acme.tf)

## 🔐 AWS IAM Policy

Create an IAM user with the following policy for Route53 DNS validation:

```json
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Sid": "Route53RecordManagement",
           "Effect": "Allow",
           "Action": [
               "route53:GetChange",
               "route53:ChangeResourceRecordSets",
               "route53:ListResourceRecordSets"
           ],
           "Resource": [
               "arn:aws:route53:::hostedzone/*",
               "arn:aws:route53:::change/*"
           ]
       },
       {
           "Sid": "Route53ZoneListing",
           "Effect": "Allow",
           "Action": "route53:ListHostedZonesByName",
           "Resource": "*"
       }
   ]
}
```

## 📋 Usage Example

### Generate a Certificate

```bash
# Request a certificate for a subdomain
vault write acme/certs/staging-low-layer common_name=test.low-layer.com
```

### Production Environment

For production certificates, create a production account:

```bash
vault write acme/accounts/letsencrypt-prod \
  provider="route53" \
  server_url=https://acme-v02.api.letsencrypt.org/directory \
  dns_resolvers="1.1.1.1" \
  contact="contact@low-layer.com" \
  terms_of_service_agreed=true
```

## ⚠️ Important Notes

- Always test with Let's Encrypt staging environment first
- Ensure your AWS credentials have the minimum required permissions
- Monitor CPU usage during certificate generation
- Keep track of Let's Encrypt rate limits
- Regularly update the plugin to the latest version

## 🔗 References

- [Vault ACME Plugin GitHub](https://github.com/Boostport/vault-plugin-secrets-acme)
- [Let's Encrypt Documentation](https://letsencrypt.org/docs/)
- [AWS Route53 API Reference](https://docs.aws.amazon.com/route53/latest/APIReference/)
- [Vault Plugin Development](https://developer.hashicorp.com/vault/docs/plugins)