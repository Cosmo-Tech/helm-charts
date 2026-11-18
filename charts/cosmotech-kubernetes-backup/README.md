# cosmotech-kubernetes-backup

![Version: 0.0.0](https://img.shields.io/badge/Version-0.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.0](https://img.shields.io/badge/AppVersion-0.0.0-informational?style=flat-square)

Cosmo Tech Kubernetes backup (bkup)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backup.cron | string | `""` |  |
| backup.destination.endpoint | string | `""` |  |
| backup.destination.passwordSecret.key | string | `""` |  |
| backup.destination.passwordSecret.name | string | `""` |  |
| backup.destination.protocol | string | `""` |  |
| backup.destination.root | string | `""` |  |
| backup.destination.username | string | `""` |  |
| backup.failedJobsHistoryLimit | int | `10` |  |
| backup.postgresql[0].address | string | `""` |  |
| backup.postgresql[0].database | string | `""` |  |
| backup.postgresql[0].image.pullPolicy | string | `""` |  |
| backup.postgresql[0].image.pullSecrets | list | `[]` |  |
| backup.postgresql[0].image.repository | string | `""` |  |
| backup.postgresql[0].image.tag | string | `""` |  |
| backup.postgresql[0].namespace | string | `""` |  |
| backup.postgresql[0].passwordSecret.key | string | `""` |  |
| backup.postgresql[0].passwordSecret.name | string | `""` |  |
| backup.postgresql[0].port | int | `5432` |  |
| backup.postgresql[0].username | string | `""` |  |
| backup.successfulJobsHistoryLimit | int | `10` |  |
| backup.timeZone | string | `"Europe/Paris"` |  |
| backup.volume.namespaces | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| nameOverride | string | `""` |  |
| workload.affinity | object | `{}` |  |
| workload.image.pullPolicy | string | `""` |  |
| workload.image.pullSecrets | list | `[]` |  |
| workload.image.repository | string | `"ghcr.io/cosmo-tech/bkup"` |  |
| workload.image.tag | string | `"latest"` |  |
| workload.nodeSelector | object | `{}` |  |
| workload.podSecurityContext.fsGroup | int | `65532` |  |
| workload.podSecurityContext.runAsGroup | int | `65532` |  |
| workload.podSecurityContext.runAsNonRoot | bool | `true` |  |
| workload.podSecurityContext.runAsUser | int | `65532` |  |
| workload.resources.limits.cpu | string | `"100m"` |  |
| workload.resources.limits.ephemeral-storage | string | `"2Gi"` |  |
| workload.resources.limits.memory | string | `"128Mi"` |  |
| workload.resources.requests.cpu | string | `"100m"` |  |
| workload.resources.requests.ephemeral-storage | string | `"50Mi"` |  |
| workload.resources.requests.memory | string | `"128Mi"` |  |
| workload.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| workload.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| workload.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| workload.securityContext.runAsGroup | int | `65532` |  |
| workload.securityContext.runAsNonRoot | bool | `true` |  |
| workload.securityContext.runAsUser | int | `65532` |  |
| workload.tolerations | list | `[]` |  |
