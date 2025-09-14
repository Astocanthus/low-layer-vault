# Low-Layer Vault

[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Docker Swarm](https://img.shields.io/badge/Docker%20Swarm-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/engine/swarm/)
[![HashiCorp Vault](https://img.shields.io/badge/vault-%23000000.svg?style=for-the-badge&logo=vault&logoColor=white)](https://www.vaultproject.io/)
[![Consul](https://img.shields.io/badge/consul-%23E03875.svg?style=for-the-badge&logo=consul&logoColor=white)](https://www.consul.io/)
[![Synology](https://img.shields.io/badge/synology-B6B6B6?style=for-the-badge&logo=synology&logoColor=white)](https://www.synology.com/)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/release/Astocanthus/low-layer-vault.svg)](https://github.com/Astocanthus/low-layer-vault/releases)
[![GitHub issues](https://img.shields.io/github/issues/Astocanthus/low-layer-vault.svg)](https://github.com/Astocanthus/low-layer-vault/issues)
[![DSM Version](https://img.shields.io/badge/DSM-%3E%3D%207-orange)](https://www.synology.com/dsm)
[![Docker Version](https://img.shields.io/badge/Docker-%3E%2024.0.0-blue)](https://www.docker.com/)

A comprehensive setup for deploying HashiCorp Vault, Consul, and Vault Agent on Synology NAS using Docker Swarm for automated certificate management.

## 📋 Project Overview

**Low-Layer Vault** is a base configuration for HashiCorp Vault and Consul, optimized for integration in Docker Swarm environments. This project aims to provide a secure and scalable infrastructure for secrets management and service discovery, specifically designed for Synology NAS systems with automated certificate management capabilities.

While this configuration is tailored for Synology environments, it can be easily adapted for deployment on any Docker Swarm cluster by adjusting paths, commands, and web server/reverse proxy configurations to match your specific infrastructure.

## ✨ Features

- **Automated Deployment**: Uses Docker Swarm for orchestration
- **Vault & Consul Integration**: Pre-configured for secure secrets management and efficient service discovery
- **Certificate Management**: Automated certificate handling with Vault Agent
- **Modular Configuration**: Easy to extend for various infrastructure needs
- **Production-Ready**: Configurations adapted for high availability and fault tolerance
- **Synology Optimized**: Specifically designed for Synology NAS environments

## 🏗️ Architecture

The project structure is as follows:

```
├── consul/
│   └── config/             # Consul configuration files
│   └── data/               # Consul persisted datas
├── vault/
│   └── config/             # Vault configuration files
│   └── plugins/            # Vault plugins extension modules folder
├── vault_agent/
│   └── config/             # Vault Agent configuration files
│   └── template/           # Vault Agent template generation files
├── swarm_consul_vault.yml  # Docker Swarm stack file for Consul and V
└── swarm_vault_agent.yml   # Docker Swarm stack file for Vault Agent
```

## ⚙️ Installation

### Prerequisites

Ensure the following are installed and configured:
- Docker Engine
- Docker Compose
- Docker Swarm initialized (`docker swarm init`)
- Synology NAS with Docker package installed

## 📚 Documentation

For complete setup details and advanced configuration, visit the full documentation:
[Synology Vault Setup Guide](https://codermug.low-layer.com/articles/synology-vault)

## 🧪 Usage

### Accessing Vault

Once deployed, Vault is accessible at:
```
http://<your-host-ip-address>:8200
```

Use the initial root token provided during deployment for authentication.

### Accessing Consul

The Consul web interface is available at:
```
http://<your-host-ip-address>:8500
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- [HashiCorp Vault Documentation](https://www.vaultproject.io/docs)
- [Consul Documentation](https://www.consul.io/docs)
- [Docker Swarm Documentation](https://docs.docker.com/engine/swarm/)
- [Complete Setup Guide](https://codermug.low-layer.com/articles/synology-vault)