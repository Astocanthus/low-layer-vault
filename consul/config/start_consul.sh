#!/bin/sh

# Retrieves the IP on the 'secret' network (adapt the interface name if needed)
IP=$(getent hosts $HOSTNAME | awk '{ print $1 }')

echo "Starting Consul with IP: $IP"

# Read encryption key in secret Docker Swarm
if [ -f /run/secrets/consul-encrypt-key ]; then
    ENCRYPT_KEY=$(cat $CONSUL_ENCRYPT_KEY_FILE)
    echo "Clé de chiffrement chargée depuis le secret"
else
    echo "ERREUR: Secret consul-encrypt-key non trouvé!"
    exit 1
fi

exec consul agent \
  -server \
  -ui \
  -client="0.0.0.0" \
  -bind="$IP" \
  -advertise="$IP" \
  -bootstrap-expect=1 \
  -data-dir="/consul/data" \
  -config-dir="/consul/config" \
  -log-level="INFO" \
  -encrypt="$ENCRYPT_KEY" \
  -datacenter="$CONSUL_DATACENTER" \
  -domain="$CONSUL_DOMAIN" \
  -node="$CONSUL_NODE_NAME" \
  -disable-host-node-id=true