# Configuration de connexion à Vault
vault {
  address = "http://vault:8200"
  retry {
    num_retries = 5
  }
}

# Authentification automatique via AppRole
auto_auth {
  method "approle" {
    mount_path = "auth/approle"
    config = {
      role_id_file_path   = "/run/secrets/vault-role-id"
      secret_id_file_path = "/run/secrets/vault-secret-id"
      remove_secret_id_file_after_reading = false
    }
  }
}

# Activer mlock pour éviter le swap sur l'hôte
disable_mlock = true

template {
  source      = "/vault/templates/internal.tpl"
  destination = "/certs/myCert/all-certs"
  command     = "/bin/sh /vault/config/restart_service.sh"
}

template {
  source      = "/vault/templates/codermug-prod.tpl"
  destination = "/codermug/ssl/all-certs"
  command = "chroot /host docker restart codermug"
  wait {
    min = "20m"
    max = "1h"
  }
}

template {
  source      = "/vault/templates/codermug-prod.tpl"
  destination = "/codermug/ssl/all-certs"
  command = "chroot /host docker restart codermug"
  wait {
    min = "20m"
    max = "1h"
  }
}