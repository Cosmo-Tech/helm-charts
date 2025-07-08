{{/*
SPDX-FileCopyrightText: Copyright (C) 2023-2024 Cosmo Tech
SPDX-License-Identifier: LicenseRef-CosmoTech

Expand the name of the chart.
*/}}
{{- define "cosmotech-modeling-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cosmotech-modeling-api.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cosmotech-modeling-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
App version
*/}}
{{- define "cosmotech-modeling-api.appVersion" -}}
{{- .Values.image.tag | default .Chart.AppVersion }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cosmotech-modeling-api.labels" -}}
helm.sh/chart: {{ include "cosmotech-modeling-api.chart" . }}
{{ include "cosmotech-modeling-api.selectorLabels" . }}
app.kubernetes.io/version: {{ include "cosmotech-modeling-api.appVersion" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cosmotech-modeling-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cosmotech-modeling-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create docker secret for pulling the image
*/}}
{{- define "cosmotech-modeling-api.imagePullSecret" -}}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.image.credentials.registry (printf "%s:%s" .Values.image.credentials.username .Values.image.credentials.password | b64enc) | b64enc }}
{{- end }}
