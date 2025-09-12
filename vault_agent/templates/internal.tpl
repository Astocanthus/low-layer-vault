{{- with pkiCert "pki/issue/low-layer.internal" "common_name=internal" "alt_names=nas.internal,torrent.internal,radarr.internal,sonarr.internal,prowlarr.internal,overseerr.internal,artifactory.internal,unifi.internal,adminer.internal,rabbit.internal,consul.internal,vault.internal,codermug.internal" "ttl=2160h" -}}
{{ .Cert }}{{ .CA }}{{ .Key }}
{{- .Key | writeToFile "/certs/myCert/privkey.pem" "root" "root" "0600" -}}
{{- .Cert | writeToFile "/certs/myCert/cert.pem" "root" "root" "0644" -}}
{{- .Cert | writeToFile "/certs/myCert/fullchain.pem" "root" "root" "0644" -}}
{{- .CA | writeToFile "/certs/myCert/fullchain.pem" "root" "root" "0644" "append" -}}
{{- end -}}