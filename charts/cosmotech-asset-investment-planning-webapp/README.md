# asset-investment-planning-webapp

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.2.0-dev](https://img.shields.io/badge/AppVersion-0.2.0--dev-informational?style=flat-square)

Cosmo Tech Asset Investment Planning Web Application

- [Homepage](https://cosmotech.com)
- [Changelog](CHANGELOG.md)

## Source Code

* <https://github.com/Cosmo-Tech/asset-investment-planning-webapp>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api.baseUrl | string | `""` |  |
| api.scope | string | `""` |  |
| api.sourceUrl | string | `""` |  |
| ingress.enabled | bool | `true` | whether to deploy the ingress for the webapp server |
| keycloak.clientId | string | `""` |  |
| keycloak.realm | string | `""` |  |
| keycloak.rolesClaim | string | `""` |  |
| name | string | `"asset-investment-planning-webapp"` | prefix of the deployments, ingress and services that will be created |
| resources | object | `{"limits":{"cpu":"1000m","memory":"256Mi"},"requests":{"cpu":"200m","memory":"128Mi"}}` | resource limits for the webapp server pod |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| webapp.domainName | string | `""` | domain name to use to host the webapp server (e.g. mytenant.cosmotech.com) |
| webapp.publicUrl | string | `""` | URL path to use as root of the webapp (e.g. /cosmotech-webapp/aip) |
| webapp.server.image.pullPolicy | string | `"Always"` | [policy](https://kubernetes.io/docs/concepts/containers/images/#updating-images) to pull the image |
| webapp.server.image.pullSecret | string | `""` | name of the secret containing registry credentials to pull private images (e.g. asset-investment-planning-webapp-registry) |
| webapp.server.image.repository | string | `""` | container image to use as webapp server (e.g. ghcr.io/cosmo-tech/azure-sample-webapp/webapp-server) |
| webapp.server.image.tag | string | `"latest"` | container image tag |
| webapp.server.nodeSelector | object | `{}` | node selector for webapp server deployment |
| webapp.server.tolerations | list | `[]` | tolerations for webapp server deployment |
| webhookRestart.authToken | string | `""` |  |
| webhookRestart.enabled | bool | `false` |  |
| webhookRestart.harbor.credentials | string | `""` |  |
| webhookRestart.harbor.project | string | `""` |  |
| webhookRestart.harbor.url | string | `""` |  |
| webhookRestart.port | int | `9000` |  |
