{{- define "component.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "component.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "component.labels" -}}
{{ include "component.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/part-of: gpubase-fabric
app.kubernetes.io/managed-by: {{ .Release.Service }}
gpubase.acryl.ai/component: {{ .Chart.Name }}
gpubase.acryl.ai/layer: {{ index .Chart.Annotations "gpubase.acryl.ai/layer" }}
{{- end -}}
