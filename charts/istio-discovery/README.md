# Istiod Helm Chart

This chart installs an Istiod deployment.

## Setup Repo Info

```console
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Installing the Chart

Before installing, ensure CRDs are installed in the cluster (from the `istio/base` chart).

To install the chart with the release name `istiod`:

```console
kubectl create namespace istio-system
helm install istiod istio/istiod --namespace istio-system
```

## Uninstalling the Chart

To uninstall/delete the `istiod` deployment:

```console
helm delete istiod --namespace istio-system
```

## Configuration

To view support configuration options and documentation, run:

```console
helm show values istio/istiod
```

### Examples

#### Configuring mesh configuration settings

Any [Mesh Config](https://istio.io/latest/docs/reference/config/istio.mesh.v1alpha1/) options can be configured like below:

```yaml
meshConfig:
  accessLogFile: /dev/stdout
```

#### Revisions

Control plane revisions allow deploying multiple versions of the control plane in the same cluster.
This allows safe [canary upgrades](https://istio.io/latest/docs/setup/upgrade/canary/)

```yaml
revision: my-revision-name
```
### Custom Mods added for Bluescape use case.
#### Files impacted :
- [gateway-injection-template.yaml](files%2Fgateway-injection-template.yaml)
- [injection-template.yaml](files%2Finjection-template.yaml)
- [kube-gateway.yaml](files%2Fkube-gateway.yaml)
- [deployment.yaml](templates%2Fdeployment.yaml) 
- [values.yaml](values.yaml)

#### Helm Values
The following subsection has been added to the values.yaml file, allowing users to override custom changes.

```yaml
bluescapeMods:
  httpEnvoyProm:
  # Reprogram all monitoring endpoints from 15090 (istio-proxy metrics alone) to 15020 (merged app + istio-proxy metrics)
    containerPort: 15090

  # Specifies if aws-load-balancer-controller should be started in hostNetwork mode.
  #
  # This is required if using a custom CNI where the managed control plane nodes are unable to initiate
  # network connections to the pods, for example using Calico CNI plugin on EKS. This is not required or
  # recommended if using the Amazon VPC CNI plugin.
  hostNetwork: false

  # Specifies the dnsPolicy that should be used for pods in the deployment
  #
  # This may need to be used to be changed given certain conditions. For instance, if one uses the cilium CNI
  # with certain settings, one may need to set `hostNetwork: true` and webhooks won't work unless `dnsPolicy`
  # is set to `ClusterFirstWithHostNet`. See https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy
  dnsPolicy:
```

#### How to make future updates ?
- Use the getmesh CLI to check the latest version published by Tetrate:
```bash
getmesh fetch
getmesh list
```
- Check out the relevant tag from the Istio upstream at https://github.com/istio/istio/tags 
   **AND/OR** 
- Download the release artifact directly from https://istio-release.storage.googleapis.com/charts/index.yaml
- Compare the files listed above between the latest release and this customized chart.
- Publish the chart to the internal Helm repository.
- Ensure that you update `appVersion` and `version` in the `Chart.yaml` file to maintain parity between the upstream and this custom version.
  - This is recommended to avoid unnecessary overrides in the custom helm chart.