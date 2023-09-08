# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.16.0] - 2023-09-08- NEX-3072 - Adding support for affinities in Vault
### Changed
- Affinities can be customized for the generated `vault_cr`. 
  - Using the standardized `node.kubernetes.io/lifecycle label` instead of the custom `spot=false` label
  - `spot=false` will be deprecated in the newer EKS harness, and currently, BOTH labels are being added to the nodes.
### Removed 
- Cleanup - Deprecated older `vault.yaml` file, not compatible post k8s 1.23+ versions.

## [0.13.0] - 2022-10-05- NEX-2092 - Remove external-secrets dependency for ArgoCD - REVERT
### Revert
- reverting 0.12.0 changes

## [0.12.0] - 2022-09-28- NEX-2092 - Remove external-secrets dependency for ArgoCD
### Changed
- removing `external-secret-argocd.yaml` and `external-secret-github.yaml`
- removing references in values.yaml file
- Note: This version (0.12.0) will not be used anywhere, and it's just to remove this functionality. It was replaced in base_apps v0.170.0 with vault mutations

## [0.11.0] - 2022-08-01- NEX-1282
### Changed
- changing Extra ClusterIssuer to use Secret references for 'accessKeyID'

## [0.10.0] - 2022-06-20 - NEX-2048
### Changed
- cert-manager cluster issuers api version is now dynamic that supports the old and new api versions

## [0.9.0] 
### Added
- new changelog
