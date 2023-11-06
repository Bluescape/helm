{{/*
Expand the name of the chart.
*/}}
{{- define "bluescape-banzai-dashboards.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bluescape-banzai-dashboards.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bluescape-banzai-dashboards.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bluescape-banzai-dashboards.labels" -}}
helm.sh/chart: {{ include "bluescape-banzai-dashboards.chart" . }}
{{ include "bluescape-banzai-dashboards.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bluescape-banzai-dashboards.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bluescape-banzai-dashboards.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
dashboard: bluescape-monitoring
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bluescape-banzai-dashboards.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bluescape-banzai-dashboards.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
