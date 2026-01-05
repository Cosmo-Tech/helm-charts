<!--
SPDX-FileCopyrightText: Copyright (C) 2022-2026 Cosmo Tech
SPDX-License-Identifier: MIT
-->

## **0.2.2** <sub><sup>2025-12-03</sup></sub>

### Features

- add optional tolerations for deployment of webapp server and functions
- add optional entries for Superset configuration in values and secrets
- add optional certificate in deployment of webapp functions if secret CA_CERT_FILE is defined

### Documentation

- update compatibility matrix & generated docs of cosmotech-business-webapp chart

## **0.2.1** <sub><sup>2024-11-12</sup></sub>

### Features

- add optional `nodeSelector` value for deployments of webapp server & functions

## **0.2.0** <sub><sup>2024-11-08</sup></sub>

### Features

- add support of new "universal" server mode
- add /tmp volume and mount ConfigMaps in webapp-server-deployment

## **0.1.1** <sub><sup>2024-10-31</sup></sub>

### Features

- add optional `pullSecret` values to pull server & functions images

## **0.1.0** <sub><sup>2024-10-11</sup></sub>

### Features

- first version of cosmotech-business-webapp helm chart
