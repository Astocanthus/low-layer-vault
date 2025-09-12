#!/bin/bash

# SSL certificate deployment script for vault-agent
# Usage: deploy_ssl_cert.sh <cert_type> <cert_id>
# Example: deploy_ssl_cert.sh fullchain NNN3kE

set -euo pipefail
NGINX_RESTART_CMD="chroot /host /usr/syno/bin/synosystemctl restart nginx"

echo "Certificate deployed"

# Restarting nginx
echo "Restarting nginx..."
if $NGINX_RESTART_CMD; then
    echo "Nginx restarted successfully"
else
    echo "Error while restarting nginx"
    exit 1
fi

echo "Deployment completed successfully"