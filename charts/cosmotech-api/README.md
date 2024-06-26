# cosmotech-api

![Version: 3.2.6](https://img.shields.io/badge/Version-3.2.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.2.6](https://img.shields.io/badge/AppVersion-3.2.6-informational?style=flat-square)

Cosmo Tech Platform API


# How to Deploy the Cosmo Tech Platform on a Kubernetes Cluster

This guide provides instructions to deploy the Cosmo Tech platform on a Kubernetes cluster using Helm charts. The deployment includes several services in the following order: Minio, PostgreSQL, Argo Workflows, RabbitMQ, Redis, and finally, the Cosmo Tech API.

## Prerequisites

Before starting the deployment, ensure you have the following:
- A Kubernetes cluster
- Helm installed
- Access to the Kubernetes cluster (e.g., `kubectl` configured)
- Required environment variables set up
- A Kubernetes namespace for this deployment

## 1. Deploy Minio

Deploy Minio using the Bitnami Helm chart:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install --namespace ${NAMESPACE} ${MINIO_RELEASE_NAME} bitnami/minio --version "12.1.3" --values - <<EOF
fullnameOverride: ${MINIO_RELEASE_NAME}
defaultBuckets: "${BUCKET_NAMES}"
persistence:
  enabled: true
  size: ${ARGO_MINIO_PERSISTENCE_SIZE}
  existingClaim: ${MINIO_PVC_NAME}
resources:
  requests:
    memory: ${ARGO_MINIO_REQUESTS_MEMORY}
    cpu: "100m"
  limits:
    memory: ${ARGO_MINIO_REQUESTS_MEMORY}
    cpu: "1"
service:
  type: ClusterIP
podLabels:
  networking/traffic-allowed: "yes"
tolerations:
- key: "vendor"
  operator: "Equal"
  value: "cosmotech"
  effect: "NoSchedule"
nodeSelector:
  "cosmotech.com/tier": "services"
auth:
  rootUser: ${ARGO_MINIO_ACCESS_KEY}
  rootPassword: ${ARGO_MINIO_SECRET_KEY}
metrics:
  serviceMonitor:
    enabled: true
    namespace: ${MONITORING_NAMESPACE}
    interval: 30s
    scrapeTimeout: 10s
EOF
```

## 2. Deploy PostgreSQL

Deploy PostgreSQL using the Bitnami Helm chart:

```bash
helm install --namespace ${NAMESPACE} ${POSTGRES_RELEASE_NAME} bitnami/postgresql --version "11.6.12" --values - <<EOF
image:
  debug: true
auth:
  enablePostgresUser: true
  database: postgres
  existingSecret: ${POSTGRESQL_SECRET_NAME}
  secretKeys:
    adminPasswordKey: postgres-password
primary:
  podLabels:
    "networking/traffic-allowed": "yes"
  tolerations:
  - key: "vendor"
    operator: "Equal"
    value: "cosmotech"
    effect: "NoSchedule"
  nodeSelector:
    "cosmotech.com/tier": "db"
  persistence:
    enabled: true
    size: ${PERSISTENCE_SIZE}
    existingClaim: ${PVC_NAME}
  initdb:
    user: postgres
    password: ${POSTGRESQL_PASSWORD}
    scriptsSecret: ${POSTGRESQL_INITDB_SECRET}
resources:
  requests:
    memory: "64Mi"
    cpu: "250m"
  limits:
    memory: "256Mi"
    cpu: "1"
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
    namespace: ${MONITORING_NAMESPACE}
    interval: 30s
    scrapeTimeout: 10s
EOF
```

## 3. Deploy Argo Workflows

Deploy Argo Workflows using the Argo Helm chart:

```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm install --namespace ${NAMESPACE} ${ARGO_RELEASE_NAME} argo/argo-workflows --version "0.16.6" --values - <<EOF
singleNamespace: true
createAggregateRoles: false
crds:
  install: false
  keep: true
images:
  pullPolicy: IfNotPresent
workflow:
  serviceAccount:
    create: true
    name: ${ARGO_SERVICE_ACCOUNT}
  rbac:
    create: true
executor:
  env:
  - name: RESOURCE_STATE_CHECK_INTERVAL
    value: 1s
  - name: WAIT_CONTAINER_STATUS_CHECK_INTERVAL
    value: 1s
useDefaultArtifactRepo: true
artifactRepository:
  archiveLogs: true
  s3:
    bucket: ${ARGO_BUCKET_NAME}
    endpoint: ${MINIO_RELEASE_NAME}.${NAMESPACE}.svc.cluster.local:9000
    insecure: true
    accessKeySecret:
      name: ${MINIO_RELEASE_NAME}
      key: root-user
    secretKeySecret:
      name: ${MINIO_RELEASE_NAME}
      key: root-password
server:
  clusterWorkflowTemplates:
    enabled: false
  extraArgs:
  - --auth-mode=server
  secure: false
  podLabels:
    networking/traffic-allowed: "yes"
  tolerations:
  - key: "vendor"
    operator: "Equal"
    value: "cosmotech"
    effect: "NoSchedule"
  nodeSelector:
    "cosmotech.com/tier": "services"
  resources:
    requests:
      memory: "256Mi"
      cpu: "100m"
    limits:
      memory: "512Mi"
      cpu: "1"
controller:
  extraArgs:
  - "--managed-namespace"
  - "${NAMESPACE}"
  clusterWorkflowTemplates:
    enabled: false
  extraEnv:
  - name: DEFAULT_REQUEUE_TIME
    value: ${REQUEUE_TIME}
  podLabels:
    networking/traffic-allowed: "yes"
  serviceMonitor:
    enabled: true
    namespace: ${MONITORING_NAMESPACE}
  tolerations:
  - key: "vendor"
    operator: "Equal"
    value: "cosmotech"
    effect: "NoSchedule"
  nodeSelector:
    "cosmotech.com/tier": "services"
  resources:
    requests:
      memory: "256Mi"
      cpu: "100m"
    limits:
      memory: "512Mi"
      cpu: "1"
  containerRuntimeExecutor: k8sapi
  metricsConfig:
    enabled: true
  workflowDefaults:
    spec:
      activeDeadlineSeconds: 604800
      ttlStrategy:
        secondsAfterSuccess: 86400
        secondsAfterCompletion: 259200
      podGC:
        strategy: OnWorkflowSuccess
      volumeClaimGC:
        strategy: OnWorkflowCompletion
  persistence:
    archive: true
    archiveTTL: ${ARCHIVE_TTL}
    postgresql:
      host: "${POSTGRES_RELEASE_NAME}-postgresql"
      database: ${ARGO_DATABASE}
      tableName: workflows
      userNameSecret:
        name: ${ARGO_POSTGRESQL_SECRET_NAME}
        key: argo-username
      passwordSecret:
        name: ${ARGO_POSTGRESQL_SECRET_NAME}
        key: argo-password
mainContainer:
  imagePullPolicy: IfNotPresent
EOF
```

## 4. Deploy RabbitMQ

Deploy RabbitMQ using the Bitnami Helm chart:

```bash
helm install --namespace ${NAMESPACE} ${RABBITMQ_RELEASE_NAME} bitnami/rabbitmq --version "13.0.3" --values - <<EOF
nodeSelector:
  cosmotech.com/tier: services
tolerations:
  - key: vendor
    operator: Equal
    value: cosmotech
    effect: NoSchedule
auth:
  existingPasswordSecret: ${INSTANCE_NAME}-secret
  existingSecretPasswordKey: admin-password
extraPlugins: "rabbitmq_amqp1_0 rabbitmq_prometheus"
extraSecrets:
  ${INSTANCE_NAME}-load-definition:
    load_definition.json: |
      {
        "users": [
          {
            "name": "admin",
            "password": "${ADMIN_PASSWORD}",
            "tags": "administrator"
          },
          {
            "name": "${LISTENER_USERNAME}",
            "password": "${LISTENER_PASSWORD}",
            "tags": ""
          },
          {
            "name": "${SENDER_USERNAME}",
            "password": "${SENDER_PASSWORD}",
            "tags": ""
          }
        ],
        "vhosts": [
          {
            "name": "/"
          }
        ],
        "permissions": [
          {
            "user": "admin",
            "vhost": "/",
            "configure": ".*",
            "write": ".*",
            "read": ".*"
          },
          {
            "user": "${LISTENER_USERNAME}",
            "vhost": "/",
            "configure": ".*",
            "write": ".*",
            "read": ".*"
          },
          {
            "user": "${SENDER_USERNAME}",
            "vhost": "/",
            "configure": ".*",
            "write": ".*",
            "read": ".*"
          }
        ]
      }
loadDefinition:
  enabled: true
  existingSecret: ${INSTANCE_NAME}-load-definition
extraConfiguration: |
  load_definitions = /app/load_definition.json
persistence:
  enabled: true
  size: ${PERSISTENCE_SIZE}
  existingClaim: ${PVC_NAME}
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
    namespace: ${MONITORING_NAMESPACE}
    interval: 30s
    scrapeTimeout: 10s
EOF
```

## 5. Deploy Redis

Deploy Redis using the Bitnami Helm chart:

```bash
helm install --namespace ${NAMESPACE} ${REDIS_RELEASE_NAME} bitnami/redis --version "17.8.0" --values - <<EOF
auth:
  password: ${REDIS_PASSWORD}
serviceBindings: 
  enabled: true
image:
  registry: ghcr.io
  repository: cosmo-tech/cosmotech-redis
  tag: ${VERSION_REDIS_COSMOTECH}
volumePermissions:
  enabled: true
  image:
    registry: docker.io
    repository: bitnami/os-shell
    tag: latest
    pullPolicy: IfNotPresent
sysctl:
  image:
    registry: docker.io
    repository: bitnami/os-shell
    tag: latest
    pullPolicy: IfNotPresent
master:
  persistence:
    enabled: true
    size: ${REDIS_DISK_SIZE}
    existingClaim: ${REDIS_MASTER_NAME_PVC}
  podLabels:
    networking/traffic-allowed: "yes"
  tolerations:
  - key: "vendor"
    operator: "Equal"
    value: "cosmotech"
    effect: "NoSchedule"
  nodeSelector:
    cosmotech.com/tier: "db"
  resources:
    requests:
      cpu: 500m
      memory: 4Gi
    limits:
      cpu: 1000m
      memory: 4Gi
replica:
  replicaCount: 1
  podLabels:
    networking/traffic-allowed: "yes"
  persistence:
    enabled: true
    size: ${REDIS_DISK_SIZE}
    existingClaim: ${REDIS_REPLICA_NAME_PVC}
  tolerations:
  - key: "vendor"
    operator: "Equal"
    value: "cosmotech"
    effect: "NoSchedule"
  nodeSelector:
    "cosmotech.com/tier": "db"
  resources:
    requests:
      cpu: 500m
      memory: 4Gi
    limits:
      cpu: 1000m
      memory: 4Gi
commonConfiguration: |-
  loadmodule /opt/bitnami/redis/modules/redisgraph.so
  loadmodule /opt/bitnami/redis/modules/redistimeseries.so DUPLICATE_POLICY LAST
  loadmodule /opt/bitnami/redis/modules/rejson.so
  loadmodule /opt/bitnami/redis/modules/redisearch.so
EOF
```


## 6. Deploy Cosmo Tech API


### Step 1: Add Helm Repository

If you haven't already added the Helm repository for Cosmo Tech API, execute the following command:

```bash
helm repo add cosmotech https://cosmotech.github.io/helm-charts
helm repo update
```

### Step 2: Deploy Cosmo Tech API

Deploy the Cosmo Tech API using the Helm chart with the specified values:

```bash
helm install ${RELEASE_NAME} cosmotech/cosmotech-api --namespace ${NAMESPACE} --version "3.2.6" --values - <<EOF
replicaCount: ${API_REPLICAS}
api:
  version: ${API_VERSION_PATH}
  multiTenant: ${MULTI_TENANT}
  servletContextPath: /cosmotech-api
image:
  repository: ghcr.io/cosmo-tech/cosmotech-api
  tag: ${API_VERSION}
argo:
  imageCredentials:
    password: ${ACR_LOGIN_PASSWORD}
    registry: ${ACR_LOGIN_SERVER}
    username: ${ACR_LOGIN_USERNAME}
config:
  api:
    serviceMonitor:
      enabled: ${MONITORING_ENABLED}
      namespace: ${MONITORING_NAMESPACE}
  logging:
    level:
      com.cosmotech: DEBUG
      web: WARN
      org.springframework: WARN
      com.redis: WARN
  server:
    error:
      include-stacktrace: always
  csm:
    platform:
      containerRegistry:
        # Add your container registry configuration here
      identityProvider:
        code: azure
        authorizationUrl: "https://login.microsoftonline.com/${TENANT_ID}/oauth2/v2.0/authorize"
        tokenUrl: "https://login.microsoftonline.com/${TENANT_ID}/oauth2/v2.0/token"
        defaultScopes:
          "[${APP_ID_URI}/platform]": "${TENANT_RESOURCE_GROUP} scope"
        containerScopes:
          "[${APP_ID_URI}/.default]": "${TENANT_RESOURCE_GROUP} scope"
      namespace: ${NAMESPACE}
      loki:
        baseUrl: http://loki.${MONITORING_NAMESPACE}.svc.cluster.local:3100
      argo:
        base-uri: "http://${ARGO_RELEASE_NAME}-argo-workflows-server.${NAMESPACE}.svc.cluster.local:2746"
        workflows:
          namespace: ${NAMESPACE}
          service-account-name: ${ARGO_SERVICE_ACCOUNT}
      s3:
        endpointUrl: ${S3_ENDPOINT_URL}
        bucketName: ${S3_BUCKET_NAME}
        accessKeyId: ${S3_ACCESS_KEY_ID}
        secretAccessKey: ${S3_SECRET_ACCESS_KEY}
      authorization:
        allowedApiKeyConsumers: ${ALLOWED_API_KEY_CONSUMERS}
        allowed-tenants: ${TENANT_ID}
      azure:
        appIdUri: ${APP_ID_URI}
        containerRegistries:
          solutions: ${ACR_LOGIN_SERVER}
        cosmos:
          key: ${COSMOS_KEY}
          uri: ${COSMOS_URI}
        credentials:
          clientId: ${CLIENT_ID}
          clientSecret: ${CLIENT_SECRET}
          customer:
            clientId: ${NETWORK_ADT_CLIENTID}
            clientSecret: ${NETWORK_ADT_PASSWORD}
            tenantId: ${TENANT_ID}
          tenantId: ${TENANT_ID}
        dataWarehouseCluster:
          baseUri: ${ADX_URI}
          options:
            ingestionUri: ${ADX_INGESTION_URI}
        eventBus:
          baseUri: ${EVENTBUS_URI}
        storage:
          account-key: ${STORAGE_ACCOUNT_KEY}
          account-name: ${STORAGE_ACCOUNT_NAME}
      internalResultServices:
        enabled: ${USE_INTERNAL_RESULT_SERVICES}
        storage:
          host: "${POSTGRESQL_RELEASE_NAME}-postgresql.${NAMESPACE}.svc.cluster.local"
          port: 5432
          reader:
            username: ${POSTGRESQL_READER_USERNAME}
            password: ${POSTGRESQL_READER_PASSWORD}
          writer:
            username: ${POSTGRESQL_WRITER_USERNAME}
            password: ${POSTGRESQL_WRITER_PASSWORD}
          admin:
            username: ${POSTGRESQL_ADMIN_USERNAME}
            password: ${POSTGRESQL_ADMIN_PASSWORD}
        eventBus:
          host: "${RABBITMQ_RELEASE_NAME}.${NAMESPACE}.svc.cluster.local"
          port: 5672
          listener:
            username: ${RABBITMQ_LISTENER_USERNAME}
            password: ${RABBITMQ_LISTENER_PASSWORD}
          sender:
            username: ${RABBITMQ_SENDER_USERNAME}
            password: ${RABBITMQ_SENDER_PASSWORD}
      twincache:
        host: "cosmotechredis-${NAMESPACE}-master.${NAMESPACE}.svc.cluster.local"
        port: ${REDIS_PORT}
        username: "default"
        password: ${REDIS_PASSWORD}
ingress:
  enabled: ${COSMOTECH_API_INGRESS_ENABLED}
  annotations:
    cert-manager.io/cluster-issuer: ${TLS_SECRET_NAME}
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
    nginx.ingress.kubernetes.io/proxy-connect-timeout: "30"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "30"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "30"
    nginx.org/client-max-body-size: "0"
  hosts:
    - host: ${COSMOTECH_API_DNS_NAME}
  tls:
    - secretName: ${TLS_SECRET_NAME}
      hosts: ["${COSMOTECH_API_DNS_NAME}"]
resources:
  limits:
    memory: 2048Mi
  requests:
    memory: 1024Mi
tolerations:
- key: "vendor"
  operator: "Equal"
  value: "cosmotech"
  effect: "NoSchedule"
nodeSelector:
  "cosmotech.com/tier": "services"
EOF
```

### Step 3: Verify Deployment

Check the deployment status using:

```bash
kubectl get pods -n ${NAMESPACE}
```

### Step 4: Access Cosmo Tech API

Once deployed, access the Cosmo Tech API using the configured ingress hostname (${COSMOTECH_API_DNS_NAME}).

## Conclusion

You have successfully deployed the Cosmo Tech API on Kubernetes using Helm charts. Ensure all environment variables are correctly set and adjust configurations as needed for your environment.


This markdown guide provides a comprehensive walkthrough for deploying the Cosmo Tech API using Helm charts, ensuring clarity and completeness in the deployment process. Adjust the placeholders (${...}) with your actual values before executing the commands.



## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | default behavior is a pod anti-affinity, which prevents pods from co-locating on a same node |
| api.multiTenant | bool | `true` |  |
| api.probes.liveness.failureThreshold | int | `5` |  |
| api.probes.liveness.timeoutSeconds | int | `10` |  |
| api.probes.readiness.failureThreshold | int | `5` |  |
| api.probes.readiness.timeoutSeconds | int | `10` |  |
| api.probes.startup.failureThreshold | int | `50` |  |
| api.probes.startup.initialDelaySeconds | int | `60` |  |
| api.serviceMonitor.additionalLabels | object | `{}` |  |
| api.serviceMonitor.enabled | bool | `true` |  |
| api.serviceMonitor.namespace | string | `"cosmotech-monitoring"` |  |
| api.servletContextPath | string | `"/"` |  |
| api.version | string | `"latest"` |  |
| argo.imageCredentials.password | string | `""` | password for registry to use for pulling the Workflow images. Useful if you are using a private registry |
| argo.imageCredentials.registry | string | `""` | container registry to use for pulling the Workflow images. Useful if you are using a private registry |
| argo.imageCredentials.username | string | `""` | username for the container registry to use for pulling the Workflow images. Useful if you are using a private registry |
| argo.storage.class | object | `{"install":true,"mountOptions":["dir_mode=0777","file_mode=0777","uid=0","gid=0","mfsymlinks","cache=strict","actimeo=30"],"parameters":{"skuName":"Premium_LRS"},"provisioner":"kubernetes.io/azure-file"}` | storage class used by Workflows submitted to Argo |
| argo.storage.class.install | bool | `true` | whether to install the storage class |
| argo.storage.class.mountOptions | list | `["dir_mode=0777","file_mode=0777","uid=0","gid=0","mfsymlinks","cache=strict","actimeo=30"]` | mount options, depending on the volume plugin configured. If the volume plugin does not support mount options but mount options are specified, provisioning will fail. |
| argo.storage.class.parameters | object | `{"skuName":"Premium_LRS"}` | Parameters describe volumes belonging to the storage class. Different parameters may be accepted depending on the provisioner. |
| argo.storage.class.provisioner | string | `"kubernetes.io/azure-file"` | volume plugin used for provisioning Persistent Volumes |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| config.csm.platform.argo.base-uri | string | `"http://argo-server:2746"` |  |
| config.csm.platform.argo.workflows.access-modes[0] | string | `"ReadWriteMany"` | Any in the following list: ReadWriteOnce, ReadOnlyMany, ReadWriteMany, ReadWriteOncePod (K8s 1.22+). ReadWriteMany is recommended, as we are likely to have parallel pods accessing the volume |
| config.csm.platform.argo.workflows.requests.storage | string | `"100Gi"` |  |
| config.csm.platform.argo.workflows.storage-class | string | `nil` | Name of the storage class for Workflows volumes. Useful if you want to use a different storage class, installed and managed externally. In this case, you should set argo.storage.class.install to false. |
| config.csm.platform.authorization.allowed-tenants | list | `[]` |  |
| config.csm.platform.azure.containerRegistries.solutions | string | `""` |  |
| config.csm.platform.azure.credentials.clientId | string | `"changeme"` | Core App Registration Client ID. Deprecated. Use `config.csm.platform.azure.credentials.core.clientId` instead |
| config.csm.platform.azure.credentials.clientSecret | string | `"changeme"` | Core App Registration Client Secret. Deprecated. Use `config.csm.platform.azure.credentials.core.clientSecret` instead |
| config.csm.platform.azure.credentials.customer.clientId | string | `"changeme"` | Customer-provided App Registration Client ID. Workaround for connecting to Azure Digital Twins in the context of a Managed App |
| config.csm.platform.azure.credentials.customer.clientSecret | string | `"changeme"` | Customer-provided App Registration Client Secret. Workaround for connecting to Azure Digital Twins in the context of a Managed App |
| config.csm.platform.azure.credentials.customer.tenantId | string | `"changeme"` | Customer-provided App Registration Tenant ID. Workaround for connecting to Azure Digital Twins in the context of a Managed App |
| config.csm.platform.azure.credentials.tenantId | string | `"changeme"` | Core App Registration Tenant ID. Deprecated. Use `config.csm.platform.azure.credentials.core.tenantId` instead |
| config.csm.platform.azure.dataWarehouseCluster.baseUri | string | `"changeme"` |  |
| config.csm.platform.azure.dataWarehouseCluster.options.ingestionUri | string | `"changeme"` |  |
| config.csm.platform.azure.eventBus.baseUri | string | `"changeme"` |  |
| config.csm.platform.s3.accessKeyId | string | `"changeme"` |  |
| config.csm.platform.s3.bucketName | string | `"changeme"` |  |
| config.csm.platform.s3.endpointUrl | string | `"http://s3-server:9000"` |  |
| config.csm.platform.s3.secretAccessKey | string | `"changeme"` |  |
| config.csm.platform.vendor | string | `"azure"` |  |
| deploymentStrategy | object | `{"rollingUpdate":{"maxSurge":1,"maxUnavailable":"50%"},"type":"RollingUpdate"}` | Deployment strategy |
| deploymentStrategy.rollingUpdate.maxSurge | int | `1` | maximum number of Pods that can be created over the desired number of Pods |
| deploymentStrategy.rollingUpdate.maxUnavailable | string | `"50%"` | maximum number of Pods that can be unavailable during the update process |
| fullnameOverride | string | `""` | value overriding the full name of the Chart. If not set, the value is computed from `nameOverride`. Truncated at 63 chars because some Kubernetes name fields are limited to this. |
| image.pullPolicy | string | `"Always"` | [policy](https://kubernetes.io/docs/concepts/containers/images/#updating-images) for pulling the image |
| image.repository | string | `"ghcr.io/cosmo-tech/cosmotech-api"` | container image to use for deployment |
| image.tag | string | `""` | container image tag. Defaults to the Chart `appVersion` if empty or missing |
| imageCredentials.password | string | `""` | password for registry to use for pulling the Deployment image. Useful if you are using a private registry |
| imageCredentials.registry | string | `""` | container registry to use for pulling the Deployment image. Useful if you are using a private registry |
| imageCredentials.username | string | `""` | username for the container registry to use for pulling the Deployment image. Useful if you are using a private registry |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` | value overriding the name of the Chart. Defaults to the Chart name. Truncated at 63 chars because some Kubernetes name fields are limited to this. |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` | annotations to set the Deployment pod |
| podSecurityContext | object | `{"runAsNonRoot":true}` | the pod security context, i.e. applicable to all containers part of the pod |
| replicaCount | int | `3` | number of pods replicas |
| resources | object | `{"limits":{"cpu":"1000m","memory":"1024Mi"},"requests":{"cpu":"500m","memory":"512Mi"}}` | resources limits and requests for the pod placement |
| securityContext | object | `{"readOnlyRootFilesystem":true}` | the security context at the pod container level |
| service.managementPort | int | `8081` | service management port |
| service.port | int | `8080` | service port |
| service.type | string | `"ClusterIP"` | service type. See [this page](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) for the possible values |
| serviceAccount.annotations | object | `{}` | annotations to add to the service account |
| serviceAccount.create | bool | `true` | whether a service account should be created |
| serviceAccount.name | string | `""` | the name of the service account to use. If not set and `serviceAccount.create` is `true`, a name is generated using the `fullname` template |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
