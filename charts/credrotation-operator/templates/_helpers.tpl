{{/* Expand the name of the chart. */}}

{{- define "credrotator-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/* Create chart name and version as used by the chart label. */}}

{{- define "credrotator-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/* Create a default fully qualified app name.
     We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
     If release name contains chart name it will be used as a full name.
 */}}

{{- define "credrotator-operator.fullname" -}}
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


{{/* Create a default fully qualified app name for the db-shim.  */}}

{{- define "db-shim-configmap.name" -}}
{{- default "db-shim-api" .Values.dbShimName | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/* Common labels */}}

{{- define "credrotator-operator.labels" -}}
helm.sh/chart: {{ include "credrotator-operator.chart" . }}
{{ include "credrotator-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/* Selector labels */}}

{{- define "credrotator-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "credrotator-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ include "db-shim-configmap.name" . }}-cm
{{- end }}


{{/* Create the name of the service account to use */}}

{{- define "credrotator-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "credrotator-operator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
