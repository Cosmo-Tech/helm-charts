{{- /*
SPDX-FileCopyrightText: Copyright (C) 2022-2026 Cosmo Tech
SPDX-License-Identifier: MIT
*/ -}}
{{- define "cosmotech-asset-agentic-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "cosmotech-asset-agentic-app.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "cosmotech-asset-agentic-app.labels" -}}
{{ include "cosmotech-asset-agentic-app.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | quote }}
{{- end -}}
