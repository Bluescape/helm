# Helm chart for Ambassador based host redirects

This chat allows creation of Ambassador based redirects.

Lets say you want Ambassador to redirect argocd endpoint `argocd.trinity.dev.bluescape.io` to its cluster's management AB subdomain `argocd.a-trinity.dev.bluescape.io`

This will require creation of 3 CRDs: 
- cert-manager certificate for `argocd.trinity.dev.bluescape.io`
- ambassador host
- ambassador mapping

## Requirements 

Deployed and configured services:
- `cert-manager` with cluster issuer `letsencrypt-prod-dns`. You can adjust it specifying `certManager.clusterIssuer` value.
- `ambassador`. Value `ambassadorId` is set to `default`, adjust it if required.

## Configuration

Refer to [values.yaml](./values.yaml) for all available configuration.

**Required variables:**
- `fqdn.from` - host FQDN to redirect from. Should be set to `argocd.trinity.dev.bluescape.io` in our example
- `fqdn.to` - redirect to host. `argocd.a-trinity.dev.bluescape.io` in our example
