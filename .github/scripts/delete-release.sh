
CHART_NAME='cdata'
CHART_VERSION='0.1.0'

# find specific version
yq ".entries.${CHART_NAME}[] | select( .version | contains(\"${CHART_VERSION}\"))" index.yaml

# delete
yq "del(.entries.${CHART_NAME}[] | select( .version | contains(\"${CHART_VERSION}\")))" index.yaml
