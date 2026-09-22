{{/*
Expand the name of the chart.
*/}}
{{- define "enroute.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "enroute.fullname" -}}
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
{{- define "enroute.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "enroute.labels" -}}
helm.sh/chart: {{ include "enroute.chart" . }}
{{ include "enroute.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "enroute.selectorLabels" -}}
app.kubernetes.io/name: {{ include "enroute.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: enroute
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "enroute.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "enroute.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "enroute.image" -}}
{{- $registry := default .image.registry .global.imageRegistry -}}
{{- with $registry }}{{ trimSuffix "/" . }}/{{ end }}{{ .image.repository }}:{{ default .defaultTag .image.tag }}
{{- end }}

{{/*
Return global and chart-specific Docker registry secret names.
Both string entries and LocalObjectReference-style objects are supported.
*/}}
{{- define "enroute.imagePullSecrets" -}}
{{- $pullSecrets := list -}}
{{- range (default (list) .Values.global.imagePullSecrets) -}}
  {{- if kindIs "map" . -}}
    {{- with .name -}}
      {{- $pullSecrets = append $pullSecrets . -}}
    {{- end -}}
  {{- else -}}
    {{- $pullSecrets = append $pullSecrets . -}}
  {{- end -}}
{{- end -}}
{{- range (default (list) .Values.imagePullSecrets) -}}
  {{- if kindIs "map" . -}}
    {{- with .name -}}
      {{- $pullSecrets = append $pullSecrets . -}}
    {{- end -}}
  {{- else -}}
    {{- $pullSecrets = append $pullSecrets . -}}
  {{- end -}}
{{- end -}}
{{- if $pullSecrets }}
imagePullSecrets:
{{- range ($pullSecrets | uniq) }}
  - name: {{ . | quote }}
{{- end }}
{{- end }}
{{- end }}
