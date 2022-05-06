{{/*
Expand the name of the chart.
*/}}
{{- define "ethereum-sync-tests.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ethereum-sync-tests.fullname" -}}
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
{{- define "ethereum-sync-tests.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ethereum-sync-tests.labels" -}}
helm.sh/chart: {{ include "ethereum-sync-tests.chart" . }}
{{ include "ethereum-sync-tests.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
consensus_client: {{ .Values.global.ethereum.consensus.client.name | quote }}
execution_client: {{ .Values.global.ethereum.execution.client.name | quote }}
network: {{ .Values.global.ethereum.network | quote }}
testnet: {{ .Values.global.ethereum.network | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ethereum-sync-tests.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ethereum-sync-tests.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ethereum-sync-tests.serviceAccountName" -}}
{{- if .Values.rbac.create }}
{{- default (include "ethereum-sync-tests.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Helpers to grab the consensus network configs
*/}}
{{- define "ethereum-sync-tests.consensusConfig" -}}https://raw.githubusercontent.com/eth-clients/merge-testnets/main/{{ .Values.global.ethereum.network }}{{- end }}

{{/*
Helpers to grab the execution network configs
*/}}
{{- define "ethereum-sync-tests.executionConfig" -}}https://raw.githubusercontent.com/eth-clients/merge-testnets/main/{{ .Values.global.ethereum.network }}{{- end }}