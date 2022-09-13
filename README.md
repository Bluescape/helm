# Bluescape charts repository

This repository contains sources to Bluescape helm charts that utilize following github actions to manage chart releases:

<https://github.com/helm/chart-releaser-action>

All charts sources are located in the `charts` folder.

## Register repository

```shell
# add it
helm repo add bluescape-charts https://bluescape.github.io/helm

# search it
helm search repo bluescape-charts
```

## Release process

### Main chart release

`Chart release action` utilizes `gh-pages` branch to maintain an index file which is served by GitHub Pages which are enabled against that branch.

A release will be triggered automatically on a `main` branch commit or PR merge.

To create a new release the following changes are required:

- Update the chart with a new `version: X.X.X[-preRelease1]` field within the `Chart.yaml` file (inside the chart directory), one that is not currently associated with any existing GitHub release for that chart.

### Create pre-release chart on the story branch

If you want to try a new version of the chart that is still a work in progress, perform the following steps to introduce a pre-release version of the particular chart.

1. Make sure you are on the story branch.
2. Change desired chart version to pre-release version within e.g. [`charts/bluescape-monitoring-dashboards/Chart.yaml`](https://github.com/Bluescape/helm/blob/main/charts/bluescape-monitoring-dashboards/Chart.yaml). E.g. `version: 1.2.0-alpha1`
3. From GitHub UI trigger `Release Charts` action against `your story branch`
4. Release for the `1.2.0-alpha1` chart should be created and `index.yaml` file will be updated on the `gh-pages` branch.

For the next iteration bump the pre-release version like so: `1.2.0-alpha2`

Before committing a PR, update version to the final new version e.g. `1.2.0`

### Removing charts from the registry

Create PR to `gh-pages` branch, removing charts metadata from `index.yaml` file.

### Chart sources

If you have new chart sources for your chart dependencies, please add it into `Adding helm repos` steps within [.github/workflows/release.yml](.github/workflows/release.yml)
