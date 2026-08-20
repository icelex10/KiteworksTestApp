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
- `Service` of type `LoadBalancer` for public access
- `ConfigMap` for environment-specific settings

## Files of interest

- [gitops/dev/kustomization.yaml](gitops/dev/kustomization.yaml)
- [gitops/staging/kustomization.yaml](gitops/staging/kustomization.yaml)
- [gitops/prod/kustomization.yaml](gitops/prod/kustomization.yaml)

The repository is intended to be synced by Argo CD using the `gitops` branch and the environment-specific application paths.
