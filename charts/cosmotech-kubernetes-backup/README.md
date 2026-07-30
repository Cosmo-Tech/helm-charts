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
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/cosmo-tech/bkup"` |  |
| image.tag | string | `"latest"` |  |
| imagePullSecrets | string | `""` |  |
| master.affinity | object | `{}` |  |
| master.nodeSelector | object | `{}` |  |
| master.resources.limits.cpu | string | `"100m"` |  |
| master.resources.limits.memory | string | `"128Mi"` |  |
| master.resources.requests.cpu | string | `"100m"` |  |
| master.resources.requests.memory | string | `"128Mi"` |  |
| master.tolerations | list | `[]` |  |
| nameOverride | string | `""` |  |
