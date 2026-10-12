# kubernetes-workload-scaler

![Version: 0.0.0](https://img.shields.io/badge/Version-0.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.6](https://img.shields.io/badge/AppVersion-0.0.6-informational?style=flat-square)

A Helm chart for Kubernetes workload scaler

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config.cache.configmapName | string | `"kws-cache"` |  |
| config.cache.configmapNamespace | string | `"default"` |  |
| config.cronjob.failedJobsHistoryLimit | int | `10` |  |
| config.cronjob.scaleDown | string | `"0 21 * * 1-5"` |  |
| config.cronjob.scaleUp | string | `"0 07 * * 1-5"` |  |
| config.cronjob.successfulJobsHistoryLimit | int | `10` |  |
| fullnameOverride | string | `""` |  |
| nameOverride | string | `""` |  |
| workload.affinity | object | `{}` |  |
| workload.image.pullPolicy | string | `"IfNotPresent"` |  |
| workload.image.pullSecrets | list | `[]` |  |
| workload.image.repository | string | `"registry.cosmotech.com/product/kubernetes-workload-scaler"` |  |
| workload.image.tag | string | `"latest"` |  |
| workload.nodeSelector | object | `{}` |  |
| workload.resources.limits.cpu | string | `"100m"` |  |
| workload.resources.limits.ephemeral-storage | string | `"2Gi"` |  |
| workload.resources.limits.memory | string | `"128Mi"` |  |
| workload.resources.requests.cpu | string | `"100m"` |  |
| workload.resources.requests.ephemeral-storage | string | `"50Mi"` |  |
| workload.resources.requests.memory | string | `"128Mi"` |  |
| workload.tolerations | list | `[]` |  |
