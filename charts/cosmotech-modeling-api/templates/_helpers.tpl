{{/*
SPDX-FileCopyrightText: Copyright (C) 2022-2025 Cosmo Tech
SPDX-License-Identifier: MIT
*/}}

{{/*
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
Name of the image registry pull secret
*/}}
{{- define "cosmotech-modeling-api.imagePullSecretName" -}}
{{- if .Values.image.credentials.pullSecret }}
{{- .Values.image.credentials.pullSecret }}
{{- else }}
{{- include "cosmotech-modeling-api.fullname" . }}-image-registry
{{- end }}
{{- end }}

{{/*
Name of the simulator image registry push secret
*/}}
{{- define "cosmotech-modeling-api.simulatorRegistryPushSecretName" -}}
{{- if (((.Values.config.csm).modelingApi).simulatorRegistry).pushSecret }}
{{- .Values.config.csm.modelingApi.simulatorRegistry.pushSecret }}
{{- else }}
{{- include "cosmotech-modeling-api.fullname" . }}-simulator-registry
{{- end }}
{{- end }}

{{/*
Location of the persistence data
*/}}
{{- define "cosmotech-modeling-api.dataPersistencePath" -}}
/var/lib/cosmotech-modeling-api/data
{{- end }}
