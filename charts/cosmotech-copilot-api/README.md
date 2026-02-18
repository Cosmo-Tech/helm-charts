# cosmotech-copilot-api

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

Cosmo Tech Copilot API

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cosmotech-api.version | string | `nil` |  |
| envConfig.adxSettings.AAD_TENANT_ID | string | `""` |  |
| envConfig.adxSettings.ADX_AAD_APP_ID | string | `""` |  |
| envConfig.adxSettings.ADX_AAD_SECRET | string | `""` |  |
| envConfig.adxSettings.ADX_RETRIEVED_ROW_NB | string | `""` |  |
| envConfig.adxSettings.KUSTO_CLUSTER_URL | string | `""` |  |
| envConfig.adxSettings.KUSTO_DATABASE | string | `""` |  |
| envConfig.botSettings.AZURE_BOT_APP_ID | string | `""` |  |
| envConfig.botSettings.AZURE_BOT_DIRECTLINE_SECRET | string | `""` |  |
| envConfig.botSettings.AZURE_BOT_PASSWORD | string | `""` |  |
| envConfig.cosmotechApi.COMOSTECH_API_HOST | string | `""` |  |
| envConfig.cosmotechApi.COMOSTECH_API_TENANT_ID | string | `""` |  |
| envConfig.cosmotechApi.COSMOTECH_API_CLIENT_ID | string | `""` |  |
| envConfig.cosmotechApi.COSMOTECH_API_CLIENT_SECRET | string | `""` |  |
| envConfig.cosmotechApi.COSMOTECH_API_SCOPE | string | `""` |  |
| envConfig.cosmotechApi.ORGANIZATION | string | `""` |  |
| envConfig.cosmotechApi.WORKSPACE | string | `""` |  |
| envConfig.modeSettings.AI_PROVIDER | string | `""` |  |
| envConfig.modeSettings.MODE | string | `""` |  |
| envConfig.modeSettings.PORT | string | `""` |  |
| envConfig.openAiSettings.AZURE_OPEN_AI_API_KEY | string | `""` |  |
| envConfig.openAiSettings.AZURE_OPEN_AI_API_TYPE | string | `"azure"` |  |
| envConfig.openAiSettings.AZURE_OPEN_AI_API_VERSION | string | `""` |  |
| envConfig.openAiSettings.AZURE_OPEN_AI_ENDPOINT | string | `""` |  |
| envConfig.openAiSettings.EMBEDDINGS_DEPLOYMENT_NAME | string | `""` |  |
| envConfig.openAiSettings.LLM_DEPLOYMENT_NAME | string | `""` |  |
| envConfig.openAiSettings.MAX_TOKEN | string | `""` |  |
| envConfig.openAiSettings.STREAMING | string | `""` |  |
| envConfig.openAiSettings.TEMPERATURE | string | `""` |  |
| envConfig.searchSettings.CHUNK_OVERLAP | string | `""` |  |
| envConfig.searchSettings.CHUNK_SIZE | string | `""` |  |
| envConfig.searchSettings.INDEX_NAME | string | `""` |  |
| envConfig.searchSettings.RETRIEVED_DOCUMENT_NB | string | `"5"` |  |
| envConfig.searchSettings.SEARCH_API_KEY | string | `""` |  |
| envConfig.searchSettings.SEARCH_ENDPOINT_URL | string | `""` |  |
| envConfig.vectorStore.CONTEXT_FILE_PATH | string | `""` |  |
| envConfig.vectorStore.IS_VECTOR_STORE_LOCAL | string | `""` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/cosmo-tech/cosmotech-copilot-api"` |  |
| image.tag | string | `"latest"` |  |
| ingress.appPath | string | `"copilot"` |  |
| ingress.certManagerClusterIssuer | string | `"letsencrypt-prod"` |  |
| ingress.email | string | `"platform@cosmotech.com"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.host | string | `"example.api.cosmotech.com"` |  |
| ingress.name | string | `"cosmotech-copilot-api"` |  |
| ingress.serviceName | string | `"cosmotech-copilot-api"` |  |
| ingress.tlsSecretName | string | `"letsencrypt-prod"` |  |
| nameOverride | string | `""` |  |
| networkPolicy.enabled | bool | `true` |  |
| replicaCount | int | `1` |  |
| service.port | int | `8082` |  |
| service.targetPort | string | `"http"` |  |
| service.type | string | `"ClusterIP"` |  |
