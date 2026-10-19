# cosmotech-kubernetes-workload-scaler

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.7](https://img.shields.io/badge/AppVersion-0.0.7-informational?style=flat-square)

A Helm chart for Cosmo Tech Kubernetes workload scaler

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config.cache.configmapName | string | `"kws-cache"` |  |
| config.cache.configmapNamespace | string | `"default"` |  |
| config.cronjob.failedJobsHistoryLimit | int | `10` |  |
| config.cronjob.scaleDown | string | `"0 21 * * 1-5"` |  |
| config.cronjob.scaleUp | string | `"0 07 * * 1-5"` |  |
| config.cronjob.successfulJobsHistoryLimit | int | `10` |  |
| config.cronjob.timeZone | string | `"Europe/Paris"` |  |
| fullnameOverride | string | `""` |  |
| nameOverride | string | `""` |  |
| workload.affinity | object | `{}` |  |
| workload.image.pullPolicy | string | `"IfNotPresent"` |  |
| workload.image.pullSecrets | list | `[]` |  |
| workload.image.repository | string | `"registry.cosmotech.com/product/cosmotech-kubernetes-workload-scaler"` |  |
| workload.image.tag | string | `""` |  |
| workload.nodeSelector | object | `{}` |  |
| workload.resources.limits.cpu | string | `"100m"` |  |
| workload.resources.limits.ephemeral-storage | string | `"2Gi"` |  |
| workload.resources.limits.memory | string | `"128Mi"` |  |
| workload.resources.requests.cpu | string | `"100m"` |  |
| workload.resources.requests.ephemeral-storage | string | `"50Mi"` |  |
| workload.resources.requests.memory | string | `"128Mi"` |  |
| workload.tolerations | list | `[]` |  |
