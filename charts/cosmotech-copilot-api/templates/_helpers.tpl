{{/*
SPDX-FileCopyrightText: Copyright (C) 2022-2026 Cosmo Tech
SPDX-License-Identifier: MIT
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "cosmotech-copilot-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "cosmotech-copilot-api.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cosmotech-copilot-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cosmotech-copilot-api.labels" -}}
helm.sh/chart: {{ include "cosmotech-copilot-api.chart" . }}
{{ include "cosmotech-copilot-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cosmotech-copilot-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cosmotech-copilot-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Default Network policy
*/}}
{{- define "cosmotech-copilot-api.defaultNetworkPolicy" -}}
{{- if .Values.networkPolicy.enabled }}
"networking/traffic-allowed": "yes"
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cosmotech-copilot-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cosmotech-copilot-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Context path:
This path will follow the pattern /{namespace}/{apiVersion}/{appPath}
E.g:
- /phoenix/v3-1/copilot
*/}}
{{- define "cosmotech-api.contextPath" -}}
{{- printf "/%s/%s/%s" .Release.Namespace (index .Values "cosmotech-api" "version") .Values.ingress.appPath }}
{{- end }}
