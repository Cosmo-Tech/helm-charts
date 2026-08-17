# cosmotech-gateway

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

Cosmo Tech Gateway

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| config.csm.platform.gateway.configuration.defaultFilters[0] | string | `"TokenRelay="` |  |
| config.csm.platform.gateway.configuration.failOnRouteDefinitionError | bool | `true` |  |
| config.csm.platform.gateway.configuration.routeFilterCacheEnabled | bool | `false` |  |
| config.csm.platform.gateway.configuration.routes[0].filters[0] | string | `"RewritePath=/changeme/(?<segment>.*),/$\\{segment}"` |  |
| config.csm.platform.gateway.configuration.routes[0].id | string | `"my-route-id"` |  |
| config.csm.platform.gateway.configuration.routes[0].predicates[0] | string | `"Path=/changeme/**"` |  |
| config.csm.platform.gateway.configuration.routes[0].uri | string | `"http://localhost:8080"` |  |
| config.csm.platform.gateway.configuration.trustedProxies | string | `""` |  |
| config.csm.platform.gateway.contextPath | string | `"/"` |  |
| config.csm.platform.gateway.identityProvider.authorizationGrantType | string | `"authorization_code"` |  |
| config.csm.platform.gateway.identityProvider.identity.clientId | string | `"gateway-client-id"` |  |
| config.csm.platform.gateway.identityProvider.identity.clientSecret | string | `"gateway-client-secret"` |  |
| config.csm.platform.gateway.identityProvider.identity.tenantId | string | `"my-tenant-id"` |  |
| config.csm.platform.gateway.identityProvider.scopes[0] | string | `"openid"` |  |
| config.csm.platform.gateway.identityProvider.serverBaseUrl | string | `"http://changeme"` |  |
| config.csm.platform.gateway.port | int | `8060` |  |
| deploymentStrategy | object | `{"rollingUpdate":{"maxSurge":1,"maxUnavailable":"50%"},"type":"RollingUpdate"}` | Deployment strategy |
| deploymentStrategy.rollingUpdate.maxSurge | int | `1` | maximum number of Pods that can be created over the desired number of Pods |
| deploymentStrategy.rollingUpdate.maxUnavailable | string | `"50%"` | maximum number of Pods that can be unavailable during the update process |
| fullnameOverride | string | `""` | value overriding the full name of the Chart. If not set, the value is computed from `nameOverride`. Truncated at 63 chars because some Kubernetes name fields are limited to this. |
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
| probes.liveness.failureThreshold | int | `5` |  |
| probes.liveness.timeoutSeconds | int | `10` |  |
| probes.readiness.failureThreshold | int | `5` |  |
| probes.readiness.timeoutSeconds | int | `10` |  |
| probes.startup.failureThreshold | int | `50` |  |
| probes.startup.initialDelaySeconds | int | `60` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"1000m"` |  |
| resources.limits.ephemeral-storage | string | `"2Gi"` |  |
| resources.limits.memory | string | `"1024Mi"` |  |
| resources.requests.cpu | string | `"500m"` |  |
| resources.requests.ephemeral-storage | string | `"50Mi"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| securityContext | object | `{"readOnlyRootFilesystem":true}` | the security context at the pod container level |
| service.port | int | `8060` | service port |
| service.type | string | `"ClusterIP"` | service type. See [this page](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) for the possible values |
| tolerations | list | `[]` |  |
