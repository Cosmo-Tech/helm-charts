# Cosmo Tech Helm Charts

This repository contains the Cosmo Tech helm charts for deploying various components of the Cosmo Tech Platform.

## Charts

- [Cosmo Tech API](charts/cosmotech-api)
- [Cosmo Tech Business Webapp](charts/cosmotech-business-webapp)
- [Cosmo Tech Copilot API](charts/cosmotech-copilot-api)
- [Cosmo Tech Modeling API](charts/cosmotech-modeling-api)

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