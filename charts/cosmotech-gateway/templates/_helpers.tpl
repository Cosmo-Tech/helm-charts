{{/*
SPDX-FileCopyrightText: Copyright (C) 2022-2026 Cosmo Tech
SPDX-License-Identifier: MIT
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "cosmotech-gateway.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cosmotech-gateway.fullname" -}}
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
{{- define "cosmotech-gateway.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cosmotech-gateway.labels" -}}
helm.sh/chart: {{ include "cosmotech-gateway.chart" . }}
{{ include "cosmotech-gateway.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cosmotech-gateway.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cosmotech-gateway.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Default Network policy
*/}}
{{- define "cosmotech-gateway.defaultNetworkPolicy" -}}
{{- if .Values.networkPolicy.enabled }}
networking/traffic-allowed: "yes"
{{- end }}
{{- end }}

{{/*
Create Docker secrets for pulling images from a private container registry.
*/}}
{{- define "cosmotech-gateway.imagePullSecret" -}}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.imageCredentials.registry (printf "%s:%s" .Values.imageCredentials.username .Values.imageCredentials.password | b64enc) | b64enc }}
{{- end }}

{{/*
Define cosmotech-gateway base configuration that'll be merged with values.
*/}}
{{- define "cosmotech-gateway.baseConfig" -}}
spring:
  application:
    name: {{ include "cosmotech-gateway.fullname" . }}
  output:
    ansi:
      enabled: never
{{- end }}

{{/*
Translate the chart's Spring-agnostic values (csm.platform.gateway.configuration)
into the Spring Cloud Gateway config format actually read by the deployed app.
*/}}
{{- define "cosmotech-gateway.translatedConfig" -}}
{{- $config := deepCopy .Values.config -}}
{{- $webflux := dig "csm" "platform" "gateway" "configuration" dict $config -}}
{{- $_ := unset $config.csm.platform.gateway "configuration" -}}
{{- $_ = set $config "spring" (dict "cloud" (dict "gateway" (dict "server" (dict "webflux" $webflux)))) -}}
{{- toYaml $config -}}
{{- end }}

{{/*
Name of the Secret holding the identity provider client secret.
*/}}
{{- define "cosmotech-gateway.identitySecretName" -}}
{{- include "cosmotech-gateway.fullname" . }}-idp-client-secret
{{- end }}

{{/*
Name of the env var the identity provider client secret is exposed under, and
which application-helm.yaml refers to via a "${...}" placeholder.
*/}}
{{- define "cosmotech-gateway.identityClientSecretEnvVarName" -}}
CSM_PLATFORM_GATEWAY_IDENTITY_CLIENT_SECRET
{{- end }}