pushd ../../charts

RED='\033[0;31m'
NC='\033[0m' # No Color

# Get all charts that were modified
modified_charts=($(git diff --name-only origin/main...HEAD -- './**/templates/**/*.yaml' | cut -d/ -f 2 | xargs))

# Remove duplicate charts
uq_modified_charts=($(for chart in "${modified_charts[@]}"; do echo "${chart}"; done | sort -u))

for chart in ${uq_modified_charts[@]}; do
  chart_file=./$chart/Chart.yaml
  # Get chart version from this branch
  new_version=$(cat $chart_file | yq '.version')
  # Get chart version from main branch
  main_version=$(git show origin/main:$chart_file | yq '.version')

  # Compare them to make sure they aren't equal after a change
  echo "Chart changed $chart..."
  echo "New Chart Version: $new_version"
  echo "Checked in Chart Version: $main_version"

  if [[ "$new_version" == "$main_version" ]]; then
    echo -e "${RED}ERROR:${NC} Chart version hasn't changed with an update to the chart"
    exit 1
  fi
done
