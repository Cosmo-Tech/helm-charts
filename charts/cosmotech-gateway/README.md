# cosmotech-gateway

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

Cosmo Tech Gateway

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| deploymentStrategy | object | `{"rollingUpdate":{"maxSurge":1,"maxUnavailable":"50%"},"type":"RollingUpdate"}` | Deployment strategy |
| deploymentStrategy.rollingUpdate.maxSurge | int | `1` | maximum number of Pods that can be created over the desired number of Pods |
| deploymentStrategy.rollingUpdate.maxUnavailable | string | `"50%"` | maximum number of Pods that can be unavailable during the update process |
| fullnameOverride | string | `""` | value overriding the full name of the Chart. If not set, the value is computed from `nameOverride`. Truncated at 63 chars because some Kubernetes name fields are limited to this. |
| gateway.contextPath | string | `"/"` |  |
| gateway.probes.liveness.failureThreshold | int | `5` |  |
| gateway.probes.liveness.timeoutSeconds | int | `10` |  |
| gateway.probes.readiness.failureThreshold | int | `5` |  |
| gateway.probes.readiness.timeoutSeconds | int | `10` |  |
| gateway.probes.startup.failureThreshold | int | `50` |  |
| gateway.probes.startup.initialDelaySeconds | int | `60` |  |
| gateway.serviceMonitor.additionalLabels | object | `{}` |  |
| gateway.serviceMonitor.enabled | bool | `true` |  |
| gateway.serviceMonitor.namespace | string | `""` |  |
| image.pullPolicy | string | `"Always"` | [policy](https://kubernetes.io/docs/concepts/containers/images/#updating-images) for pulling the image |
| image.repository | string | `"ghcr.io/cosmo-tech/cosmotech-gateway"` | container image to use for deployment |
| image.tag | string | `""` | container image tag. Defaults to the Chart `appVersion` if empty or missing |
| imageCredentials.password | string | `""` | password for registry to use for pulling the Deployment image. Useful if you are using a private registry |
| imageCredentials.registry | string | `""` | container registry to use for pulling the Deployment image. Useful if you are using a private registry |
| imageCredentials.username | string | `""` | username for the container registry to use for pulling the Deployment image. Useful if you are using a private registry |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` | value overriding the name of the Chart. Defaults to the Chart name. Truncated at 63 chars because some Kubernetes name fields are limited to this. |
| networkPolicy.enabled | bool | `true` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` | annotations to set the Deployment pod |
| podSecurityContext | object | `{"runAsNonRoot":true}` | the pod security context, i.e. applicable to all containers part of the pod |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"1000m"` |  |
| resources.limits.ephemeral-storage | string | `"2Gi"` |  |
| resources.limits.memory | string | `"1024Mi"` |  |
| resources.requests.cpu | string | `"500m"` |  |
| resources.requests.ephemeral-storage | string | `"50Mi"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| securityContext | object | `{"readOnlyRootFilesystem":true}` | the security context at the pod container level |
| service.managementPort | int | `8081` | service management port |
| service.port | int | `8080` | service port |
| service.type | string | `"ClusterIP"` | service type. See [this page](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) for the possible values |
| tolerations | list | `[]` |  |
