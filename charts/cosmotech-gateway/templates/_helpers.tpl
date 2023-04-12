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
Create the name of the service account to use
*/}}
{{- define "cosmotech-gateway.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cosmotech-gateway.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Default Ingress path
*/}}
{{- define "cosmotech-gateway.apiBasePath" -}}
{{- if eq .Values.gateway.version "latest" }}
{{- printf "%s/" (printf "%s" .Values.gateway.servletContextPath | trimSuffix "/" ) }}
{{- else }}
{{- printf "%s/%s/" (printf "%s" .Values.gateway.servletContextPath | trimSuffix "/" ) (printf "%s" .Values.gateway.version | trimSuffix "/" ) }}
{{- end }}
{{- end }}

{{/*
Create Docker secrets for pulling images from a private container registry.
*/}}
{{- define "cosmotech-gateway.imagePullSecret" -}}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.imageCredentials.registry (printf "%s:%s" .Values.imageCredentials.username .Values.imageCredentials.password | b64enc) | b64enc }}
{{- end }}

{{/*
Construct authorizationURL from identity provider information
*/}}
{{- define "cosmotech-gateway.authorizationUrl" -}}
{{- printf "http://%s.%s.svc.cluster.local:%s/realms/cosmotech/protocol/openid-connect/auth" .Values.config.csm.platform.identityProvider.fullname .Values.config.csm.platform.identityProvider.namespace .Values.config.csm.platform.identityProvider.port }}
{{- end }}

{{/*
Construct tokenURL from identity provider information
*/}}
{{- define "cosmotech-gateway.tokenUrl" -}}
{{- printf "http://%s.%s.svc.cluster.local:%s/realms/cosmotech/protocol/openid-connect/token" .Values.config.csm.platform.identityProvider.fullname .Values.config.csm.platform.identityProvider.namespace .Values.config.csm.platform.identityProvider.port }}
{{- end }}

{{/*
Construct base configuration for cosmotech-gateway
*/}}
{{- define "cosmotech-gateway.baseConfig" -}}
spring:
  application:
    name: {{ include "cosmotech-gateway.fullname" . }}
  output:
    ansi:
      enabled: never

gateway:
  version: "{{ .Values.gateway.version }}"

server:
  servlet:
    context-path: {{ include "cosmotech-gateway.apiBasePath" . }}
  jetty:
    accesslog:
      ignore-paths:
        - /actuator/health/liveness
        - /actuator/health/readiness

management:
  endpoint:
    health:
      group:
        readiness:
          include: "readinessState"

csm:
  platform:
    identityProvider:
      code: {{- .Values.config.csm.platform.identityProvider.code | default "keycloak" }}
      {{- if .Values.config.csm.platform.identityProvider.authorizationUrl }}
      authorizationUrl: {{ .Values.config.csm.platform.identityProvider.authorizationUrl }}
      {{- else }}
      authorizationUrl: {{ include "cosmotech-gateway.authorizationUrl" . }}
      {{- end }}
      {{- if .Values.config.csm.platform.identityProvider.tokenUrl }}
      tokenUrl: {{ .Values.config.csm.platform.identityProvider.tokenUrl }}
      {{- else }}
      tokenUrl: {{ include "cosmotech-gateway.tokenUrl" . }}
      {{- end }}
      defaultScopes:
        openid: "OpenId Scope"
{{- end }}
