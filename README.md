# KiteworksTest

This repository is the application source for the Kiteworks AKS GitOps deployment.

## GitOps layout

Argo CD is configured to watch one environment folder per cluster:

- dev -> `gitops/dev`
- staging -> `gitops/staging`
- prod -> `gitops/prod`

Each environment contains its own namespace plus the workload resources for the application.

## Application deployment model

The app is delivered as a simple public-facing web workload on AKS:

- `Deployment` with a containerized web app
- `ClusterIP` Service behind the NGINX Ingress reverse proxy
- `ConfigMap` for environment-specific settings

The application Services are now `ClusterIP` services. NGINX Ingress is the public reverse proxy, with one static Azure public IP and Azure-provided DNS name per AKS environment. The current MVP uses HTTP only; TLS and custom DNS are intentionally deferred.

## Files of interest

- [gitops/dev/kustomization.yaml](gitops/dev/kustomization.yaml)
- [gitops/staging/kustomization.yaml](gitops/staging/kustomization.yaml)
- [gitops/prod/kustomization.yaml](gitops/prod/kustomization.yaml)

The repository is intended to be synced by Argo CD using the `gitops` branch and the environment-specific application paths.

The current environment endpoints are:

- dev: `http://kiteworkstest-dev.centralus.cloudapp.azure.com`
- staging: `http://kiteworkstest-staging.centralus.cloudapp.azure.com`
- prod: `http://kiteworkstest-prod.centralus.cloudapp.azure.com`

## Promotion policy

During the MVP test phase, the Azure DevOps pipeline updates `gitops/dev/kustomization.yaml` directly after a successful build. This keeps development deployment automatic.

Staging and production changes are intended to be promoted through pull requests that update only their environment folder. `CODEOWNERS` assigns `@icelex10` as the owner for all three environment paths, so GitHub requests that review when a pull request changes an environment manifest.

When the workflow is ready for enforcement, protect the `gitops` branch and require pull requests and Code Owner approval. At that point, the dev pipeline should create an automatically mergeable dev pull request instead of pushing directly; staging and production pull requests should remain approval-gated.
