<!--
SPDX-FileCopyrightText: Copyright (C) 2022-2026 Cosmo Tech
SPDX-License-Identifier: MIT
-->
# PostgreSQL Configuration

This document describes how to configure PostgreSQL database connection for the Asset Investment Planning API.

## Security Model

For enhanced security, the PostgreSQL password is **not stored in the ConfigMap**. Instead, it is:

1. **Stored in a Kubernetes Secret** (`<release-name>-secrets`)
2. **Mounted as a file** in the container at `/app/secrets/postgres-password`
3. **Read by the application** at runtime from the secret file

This approach provides better security because:
- Secrets are encrypted at rest in etcd (if configured)
- Secrets have more granular RBAC controls than ConfigMaps
- The password is not exposed in plain text in the ConfigMap
- The password is isolated from other configuration parameters

## Configuration

### Helm Values

Configure PostgreSQL connection in your `values.yaml`:

```yaml
postgres:
  enabled: "true"
  host: "postgresql.example.com"
  port: 5432
  database: "mydatabase"
  schema: "public"
  username: "myuser"
  password: "YOUR_SECURE_PASSWORD"
```

### How It Works

1. **Secret Creation**: When `postgres.enabled` is set to `"true"`, the Helm chart automatically creates a Secret containing the password:
   ```yaml
   apiVersion: v1
   kind: Secret
   metadata:
     name: <release-name>-secrets
   data:
     postgres-password: <base64-encoded-password>
   ```

2. **Volume Mount**: The Secret is mounted as a volume in the deployment at `/app/secrets/`:
   ```yaml
   volumes:
     - name: postgres-password
       secret:
         secretName: <release-name>-secrets
   volumeMounts:
     - name: postgres-password
       mountPath: /app/secrets
       readOnly: true
   ```

3. **Application Read**: The Python application reads the password from `/app/secrets/postgres-password` at runtime:
   ```python
   with open("/app/secrets/postgres-password", 'r') as f:
       password = f.read().strip()
   ```

4. **Fallback Support**: For backward compatibility and local development, the application falls back to reading the password from `config.toml` if the secret file is not found (though this triggers a security warning).

## ConfigMap vs Secret

| Configuration Item | Storage Location | Reason |
|--------------------|------------------|---------|
| Host | ConfigMap | Not sensitive |
| Port | ConfigMap | Not sensitive |
| Database | ConfigMap | Not sensitive |
| Schema | ConfigMap | Not sensitive |
| Username | ConfigMap | Not sensitive |
| **Password** | **Secret** | **Sensitive credential** |

## Deployment

### Standard Deployment

```bash
helm install my-api ./helm-chart/cosmotech-asset-data-layer-api \
  --set postgres.enabled="true" \
  --set postgres.host="postgresql.example.com" \
  --set postgres.password="YOUR_SECURE_PASSWORD"
```

### Using External Secrets

For production environments, consider using external secret management solutions:

1. **Azure Key Vault** with the [Azure Key Vault Provider for Secrets Store CSI Driver](https://github.com/Azure/secrets-store-csi-driver-provider-azure)
2. **AWS Secrets Manager** with the [External Secrets Operator](https://external-secrets.io/)
3. **HashCorp Vault** with the [Vault Agent Injector](https://www.vaultproject.io/docs/platform/k8s/injector)

Example with External Secrets Operator:

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: postgres-password
spec:
  secretStoreRef:
    name: aws-secretsmanager
    kind: SecretStore
  target:
    name: <release-name>-secrets
    creationPolicy: Owner
  data:
    - secretKey: postgres-password
      remoteRef:
        key: prod/postgresql/password
```

## Security Best Practices

1. **Never commit passwords** to version control
2. **Use strong passwords** (at least 16 characters with mixed case, numbers, and special characters)
3. **Rotate passwords regularly** (recommended: every 90 days)
4. **Use external secret management** for production environments
5. **Enable encryption at rest** for Kubernetes Secrets in your cluster
6. **Limit RBAC permissions** on Secrets to only necessary service accounts
7. **Use network policies** to restrict database access to only the API pods

## Troubleshooting

### Password Not Found Error

If you see the error: `PostgreSQL password secret file not found`

**Cause**: The Secret volume is not mounted or PostgreSQL is not enabled.

**Solution**:
1. Verify `postgres.enabled` is set to `"true"` (note: it's a string, not a boolean)
2. Check that the Secret exists: `kubectl get secret <release-name>-secrets`
3. Verify the pod has the volume mounted: `kubectl describe pod <pod-name>`

### Password Authentication Failed

If PostgreSQL rejects the password:

**Solution**:
1. Verify the password value in the Secret: `kubectl get secret <release-name>-secrets -o jsonpath='{.data.postgres-password}' | base64 -d`
2. Check database user permissions
3. Verify the PostgreSQL host and port are correct

### Security Warning in Logs

If you see: `PostgreSQL password secret file not found, using password from config`

**Cause**: The application is falling back to reading the password from config.toml (ConfigMap).

**Solution**: This is a backward compatibility feature. For production, ensure:
- `postgres.enabled` is set to `"true"`
- The Secret is properly created and mounted

## Migration from ConfigMap to Secret

If you're upgrading from a previous version where the password was in the ConfigMap:

1. **No action required** - The application automatically uses the Secret when available
2. **Remove old password from config.toml** - The ConfigMap no longer includes the password field
3. **Verify Secret creation** - Check that `<release-name>-secrets` contains `postgres-password`

## Local Development

For local development without Kubernetes:

1. Create a `.env` file with `POSTGRES_PASSWORD=your_password`
2. Or use the `config.toml` file with the password (acceptable for local dev only)
3. The application will log a warning but continue to work

**Note**: Never use the ConfigMap password approach in production environments.
