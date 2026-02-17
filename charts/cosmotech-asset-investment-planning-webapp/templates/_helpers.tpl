{{/* Generates the name of the webapp server */}}
{{- define "asset-investment-planning-webapp.server-name" -}}
{{ .Values.name }}-server
{{- end }}
