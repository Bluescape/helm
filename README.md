# Bluescape charts repository

This repository contains sources to Bluescape helm charts that utilized following github actions to manage chart releases:

<https://github.com/helm/chart-releaser-action>

All charts sources are located in the `charts` folder.

## Register repository

```shell
# add it
helm repo add bluescape-charts https://bluescape.github.io/helm-poc

# search it
helm search repo bluescape-charts
```

## Release process

### Main chart release

`Chart release action` utilized `gh-pages` brach to maintain index file which is served by GitHub Pages enabled on against that brach.

Release will be triggered automatically on `main` branch commit or PR merge.

To create new release following changes is required:

- Updated chart has new `version: X.X.X[-preRelease1]` within `Charts.yaml` file, one that is not currently associated with any existing GitHub release for that chart.

### Create pre-release chart on the story branch

If you want to try new version of the chart that is still work in progress, you perform following steps to introduce pre-release version of the particular chart.

1. Make sure you are on the story branch.
2. Change desired chart version to pre-release version within  `Charts.yaml`. E.g. `1.2.0-alpha1`
3. From GitHub UI trigger `Release Charts` action against `your story branch`
4. Release for `1.2.0-alpha1` chart should be created and `index.yaml` file will be updated on `gh-pages` branch.

For the next iteration bump pre-release version like so: `1.2.0-alpha2`

Before creating PR update version to they final new version `1.2.0`

### Removing charts from the registry

Create PR to `gh-pages` branch, removing charts metadata from `index.yaml` file.

### Chart sources

If you have new chart sources for your chart dependencies, please add it into `Adding helm repos` steps within [.github/workflows/release.yml](.github/workflows/release.yml)
