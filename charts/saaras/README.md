# enroute

![Version: 0.7.0](https://img.shields.io/badge/Version-0.7.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.11.0](https://img.shields.io/badge/AppVersion-v0.11.0-informational?style=flat-square)

EnRoute API Gateway

**Homepage:** <https://getenroute.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| contact | <contact@saaras.io> |  |

## Source Code

* <https://github.com/saarasio/enroute>
* <https://getenroute.io>
* <https://github.com/envoyproxy/envoy>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels.app | string | `"enroute"` |  |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"kubernetes.io/hostname"` |  |
| affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `100` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| enrouteService.rbac.create | bool | `false` |  |
| envoySettings | object | `{"logLevel":"debug"}` | One of ["trace", "debug", "info", "error"] |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| images.enrouteService.pullPolicy | string | `"Always"` |  |
| images.enrouteService.repository | string | `"saarasio/enroute-gwi"` |  |
| images.enrouteService.tag | string | `nil` |  |
| images.envoy.pullPolicy | string | `"Always"` |  |
| images.envoy.repository | string | `"envoyproxy/envoy"` |  |
| images.envoy.tag | string | `"v1.23.0"` |  |
| images.redis.pullPolicy | string | `"Always"` |  |
| images.redis.repository | string | `"redis"` |  |
| images.redis.tag | string | `nil` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| opa | object | `{"enable":false}` | When enabled, setup resources need to run OPA |
| podAnnotations."prometheus.io/path" | string | `"/stats/prometheus"` |  |
| podAnnotations."prometheus.io/port" | string | `"8002"` |  |
| podAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources.enrouteService | object | `{}` |  |
| resources.envoy | object | `{}` |  |
| resources.redis | object | `{}` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| service.annotations | object | `{}` |  |
| service.externalTrafficPolicy | string | `nil` |  |
| service.ports[0].name | string | `"http"` |  |
| service.ports[0].port | int | `80` |  |
| service.ports[0].protocol | string | `"TCP"` |  |
| service.ports[0].targetPort | int | `8080` |  |
| service.ports[1].name | string | `"https"` |  |
| service.ports[1].port | int | `443` |  |
| service.ports[1].protocol | string | `"TCP"` |  |
| service.ports[1].targetPort | int | `8443` |  |
| service.type | string | `"LoadBalancer"` |  |
| service.useProxyProtocol | bool | `false` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |

