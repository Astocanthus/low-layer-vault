{{- with secret "acme/certs/prod-low-layer" "common_name=codermug.low-layer.com" -}}
{{ .Data.issuer_cert }}{{ .Data.cert }}{{ .Data.private_key }}
{{- .Data.issuer_cert | writeToFile "/codermug/ssl/ca.pem" "root" "root" "0644" -}}
{{- .Data.cert | writeToFile "/codermug/ssl/cert.pem" "root" "root" "0644" -}}
{{- .Data.private_key | writeToFile "/codermug/ssl/key.pem" "root" "root" "0600" -}}
{{- end -}}