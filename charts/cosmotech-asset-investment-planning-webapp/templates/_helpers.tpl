{{/*
SPDX-FileCopyrightText: Copyright (C) 2022-2026 Cosmo Tech
SPDX-License-Identifier: MIT
*/}}
{{/* Generates the name of the webapp server */}}
{{- define "asset-investment-planning-webapp.server-name" -}}
{{ .Values.name }}-server
{{- end }}
{{/*
Create the name of the service account to use
*/}}
{{- define "asset-investment-planning-webapp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "asset-investment-planning-webapp.server-name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}