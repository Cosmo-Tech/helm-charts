# cosmotech-asset-investment-planning-api

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.0-dev](https://img.shields.io/badge/AppVersion-0.2.0--dev-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| alembic.script_location | string | `"cosmotech/aip/migrations"` |  |
| apiConfig.corsOrigin | list | `[]` |  |
| apiConfig.dataDir | string | `"/data"` |  |
| apiConfig.keycloakRealm | string | `"myrealm"` |  |
| apiConfig.rootUri | string | `"/"` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| database.reset | bool | `false` |  |
| extraEnvVars | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"registry.cosmotech.com/product/cosmotech-asset-investment-planning-api"` |  |
| image.tag | string | `"latest"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations."kubernetes.io/ingress.class" | string | `"traefik"` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls.enabled | bool | `false` |  |
| ingress.tls.hosts[0] | string | `"chart-example.local"` |  |
| ingress.tls.secretName | string | `""` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.size | string | `"4Gi"` |  |
| persistence.storageClass | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| postgres.database | string | `"mydatabase"` |  |
| postgres.enabled | bool | `false` |  |
| postgres.host | string | `"postgresql.host.url"` |  |
| postgres.password | string | `"CHANGEME"` |  |
| postgres.port | int | `5432` |  |
| postgres.schema | string | `"public"` |  |
| postgres.username | string | `"psql"` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"100m"` |  |
| resources.limits.ephemeral-storage | string | `"2Gi"` |  |
| resources.limits.memory | string | `"128Mi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.ephemeral-storage | string | `"50Mi"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| securityContext | object | `{}` |  |
| service.port | int | `8080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| webhookRestart.authToken | string | `""` |  |
| webhookRestart.enabled | bool | `false` |  |
| webhookRestart.harbor.credentials | string | `""` |  |
| webhookRestart.harbor.project | string | `""` |  |
| webhookRestart.harbor.url | string | `""` |  |
| webhookRestart.port | int | `9000` |  |
