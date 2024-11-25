# Cosmo Tech Helm Charts

This repository contains the Cosmo Tech helm charts for deploying various components of the Cosmo Tech Platform.

## Charts

### Cosmo Tech API

The Cosmo Tech API chart is located in the [charts/cosmotech-api](charts/cosmotech-api) directory. It provides the necessary resources to deploy the Cosmo Tech API on a Kubernetes cluster.

### Cosmo Tech Business Webapp

The Cosmo Tech Business Webapp chart is located in the [charts/cosmotech-business-webapp](charts/cosmotech-business-webapp) directory. It provides the necessary resources to deploy the Cosmo Tech Business Webapp on a Kubernetes cluster.

## Installation

Add the helm repository and update:
```bash
helm repo add cosmotech https://cosmo-tech.github.io/helm-charts/
helm repo update
```

Deploy chart:
```bash
helm install mychartname cosmotech/chartname --version X.Y.Z
```

## License
![MIT License](LICENSE)