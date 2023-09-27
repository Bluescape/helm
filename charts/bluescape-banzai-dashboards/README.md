# Add new grafana dashboards

NOTE: You must helm version 3.x

## Manual Addition

This part is purposefully sparse but enough is given to give the reader a sufficient overview
of the process.

 * export dashboard JSON from grafana dashboard using the export tool
   * make sure "Export for sharing external externally" is not set to on
 * save the JSON somewhere well-known on your laptop/computer
 * use the templates in `<repo>/helm/charts/bluescape-banzai-dashboards/templates/0_template`
   * create a new dashboard directory in `<repo>/helm/charts/bluescape-banzai-dashboards/templates`
   * within that newly created directory, copy the templates from `0_template`.
   * chdir to the new directory
   * put the exported JSON in the `configmap.yaml` using the example data
     provided in the `configmap.yaml` template
   * update the necessary fields in `configmap.yaml`
 * fix the necessary fields in `dashboard.yaml`

Jump down to verify dashboards below.

## Automatic Addition

These instructions cover how to use the `add-dashboard` script located
in `<repo>/helm/charts/bluescape-banzai-dashboards`

### Pre-requisites

The following are necessary in order for this script to function
properly:

  * [yaml2json](https://github.com/Bluescape/ops/tree/master/scripts/bin)
  * [json2yaml](https://github.com/Bluescape/ops/tree/master/scripts/bin)
  * jq
  * gnu sed
  * gnu grep

### Synopsis

This script must be run from this directory. It will verify as much
and if it isn't in the proper directory then it will exit with an error


```
Usage: ../bin/add-dashboard <path/to/exported/dashboard.json> <new_dashboard_directory>

```

The first argument is the path to the exported JSON from grafana.

The second argument is the name of the dashboard directory into which
the new configmap and dashboard manifests will be placed. This argument requires
pathing. A simple name such as `65_dashboard_name` is sufficient.

### Example

```
$ cd <repo>/helm/charts/bluescape-banzai-dashboards
../bin/add-dashboard $HOME/Downloads/Redis.json 44_redis_dashboard
```

### Validations performed at runtime

A cursory check of the following is performed at runtime:

  * the script is running from the expected directory
  * the JSON imported will have `__inputs` and `__requires` removed
  * the dashboard JSON is valid JSON
  * pre-requisite binaries are on the running machine

Note that any gotmpls (go templating) in the JSON will be fixed so that helm will
not interpolate them (IE it will error on run).

#### yaml2json and json2yaml

These scripts are in [ops scripts repo][1] and require ruby installed on
your laptop. Most OSes will automatically have a proper Ruby interpreter installed.

## Verify Dashboards

Visually validate the configmap:

```
cat 44_redis_dashboard/configmap.yaml
```

Visually validate the dashboard manifest:

```
cat 44_redis_dashboard/dashboad.yaml
```

### Lint validation

```
$ cd <repo>/helm/charts
$ helm template /bluescape-banzai-dashboards | yamllint -
```

You should get no errors from `yamllint` and you should get no errors
from `helm`.

This check is a good method of topically validating the manifests returned are
valid yaml.

### Chart validation

The following will perform a dry-run of the chart. For the purposes of this
set of examples, we'll be using the Atreus cluster to perform these tests.
You'll have to transpose these directions with whichever [test] cluster you, the
reader, is working in.

Note that if the `bluescape-banzai-dashboards` are already installed on your
cluster, you'll need to re-use the same deployment name under which those were
installed with helm before.

```
# for good practice you should make sure you're using the correct cluster
# on which to test!
# use your favorite method...
$ kctx atreus
Switched to context "arn:aws:eks:us-west-2:429863676324:cluster/atreus".

$ helm ls
NAME                            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                                   APP VERSION
a-atreus                        grafana         1               2021-08-09 23:37:45.464990415 +0000 UTC deployed        grafana-operator-0.2.5                  master
grafana-a-atreus                grafana         1               2021-08-09 23:38:16.854245718 +0000 UTC deployed        bluescape-monitoring-grafana-0.2.3      1.16.0
grafana-dashboards-a-atreus     grafana         6               2021-08-09 23:23:16.473682282 +0000 UTC deployed        bluescape-banzai-dashboards-0.2.3   1.16.2
```

...so in this case, we'll need to make note that the dashboards were
installed under the deployment name `grafana-dashboards-a-atreus` or else `helm`
will go nuts.

Now run the dry-run

```
$ cd <repo>/helm/charts
$ helm upgrade --install grafana-dashboards-a-atreus bluescape-banzai-dashboards -n grafana --dry-run
```

This should give a lot of useful output and no errors. If there are errors,
you'll need to address them.

Assuming there are no errors, now install the chart in a test cluster. We'll continue to use Atreus.

```
$ kctx atreus
Switched to context "arn:aws:eks:us-west-2:429863676324:cluster/atreus".

$ cd <repo>/helm/charts
$ helm upgrade --install grafana-dashboards-atreus bluescape-banzai-dashboards -n grafana
```

This should not fail. Once this completes, login to grafana on the test cluster
and verify your dashboards:

 #. installed
 #. work properly.

if the dashboards need tweaking, wash, rinse, repeat. Once all is working, push a
commit and PR the push to this repo.

## commit, push, and PR

### Chart.yaml version bump

Update/bump the versions of the `Chart.yaml` (in this directory). The `Chart.yaml` contains
decent comments about the version bump. It's sufficient to just bump the minor. The comments
state that semver is not being used, however the versions themselves seem to follow a semver
convention, which is likely sufficient for the bump.

### commit and push

Make sure you're doing work in a feature branch! When all is done and tested, commit the
branch and push. Create a pull request. The Infra team is the owner of this repo. Only they
can merge PRs. Make sure you've properly tested everything before creating the PR and request
a merge.

## Notes

This script should function properly on Linux and Darwin

[1]:https://github.com/Bluescape/ops/tree/develop/scripts
