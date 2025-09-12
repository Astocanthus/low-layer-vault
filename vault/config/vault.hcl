ui = true

# Configuration du stockage Consul
storage "consul" {
  address = "consul:8500"
  path    = "vault/"
  scheme  = "http"
  
  # Configuration de session
  session_ttl = "15s"
  lock_wait_time = "15s"
}

# Listener HTTP - TLS géré par le reverse proxy Synology
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
  
  # Configuration simplifiée pour Synology
  x_forwarded_for_authorized_addrs = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  x_forwarded_for_hop_skips = 0
  x_forwarded_for_reject_not_authorized = false
  x_forwarded_for_reject_not_present = false
}

# Configuration pour reverse proxy HTTPS
api_addr = "https://vault.internal"
disable_clustering = true

# Activer mlock pour éviter le swap sur l'hôte
disable_mlock = false

# Configuration des plugins
plugin_directory = "/vault/plugins"

# Configuration des logs
log_level = "DEBUG"
log_format = "standard"  # Plus lisible pour Synology

# Configuration de performance
default_lease_ttl = "168h"
max_lease_ttl = "720h"