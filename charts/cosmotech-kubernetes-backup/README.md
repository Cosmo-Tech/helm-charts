# cosmotech-kubernetes-backup

![Version: 0.0.0](https://img.shields.io/badge/Version-0.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.0](https://img.shields.io/badge/AppVersion-0.0.0-informational?style=flat-square)

Cosmo Tech Kubernetes backup (bkup)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backup.cron | string | `""` |  |
| backup.failedJobsHistoryLimit | int | `5` |  |
| backup.successfulJobsHistoryLimit | int | `3` |  |
| clusterName | string | `""` |  |
| fullnameOverride | string | `""` |  |
| master.affinity | object | `{}` |  |
| master.image.pullPolicy | string | `"IfNotPresent"` |  |
| master.image.pullSecrets | list | `[]` |  |
| master.image.repository | string | `"ghcr.io/cosmo-tech/bkup"` |  |
| master.image.tag | string | `"latest"` |  |
| master.nodeSelector | object | `{}` |  |
| master.resources.limits.cpu | string | `"100m"` |  |
| master.resources.limits.ephemeral-storage | string | `"50Mi"` |  |
| master.resources.limits.memory | string | `"128Mi"` |  |
| master.resources.requests.cpu | string | `"100m"` |  |
| master.resources.requests.ephemeral-storage | string | `"2Gi"` |  |
| master.resources.requests.memory | string | `"128Mi"` |  |
| master.tolerations | list | `[]` |  |
| nameOverride | string | `""` |  |
| worker.affinity | object | `{}` |  |
| worker.image.pullPolicy | string | `"IfNotPresent"` |  |
| worker.image.pullSecrets | list | `[]` |  |
| worker.image.repository | string | `"ghcr.io/cosmo-tech/bkup"` |  |
| worker.image.tag | string | `"latest"` |  |
| worker.resources.limits.cpu | string | `"100m"` |  |
| worker.resources.limits.ephemeral-storage | string | `"50Mi"` |  |
| worker.resources.limits.memory | string | `"128Mi"` |  |
| worker.resources.requests.cpu | string | `"1000m"` |  |
| worker.resources.requests.ephemeral-storage | string | `"2Gi"` |  |
| worker.resources.requests.memory | string | `"512Mi"` |  |
| worker.tolerations | list | `[]` |  |
