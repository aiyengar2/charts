# Rancher

{{- define "system_default_registry" -}}
{{- if .Values.global.cattle.systemDefaultRegistry -}}
{{- printf "%s/" .Values.global.cattle.systemDefaultRegistry -}}
{{- end -}}
{{- end -}}

# General

{{- define "windowsDeployer.name" -}}
windows-deployer
{{- end -}}

{{- define "windowsDeployer.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride -}}
{{- end -}}

{{- define "windowsDeployer.labels" -}}
k8s-app: {{ template "windowsDeployer.name" . }}
release: {{ .Release.Name }}
provider: kubernetes
{{- end -}}

# Client

{{- define "windowsDeployer.nodeSelector" -}}
{{- if semverCompare "<1.14-0" .Capabilities.KubeVersion.GitVersion -}}
beta.kubernetes.io/os: windows
{{- else -}}
kubernetes.io/os: windows
{{- end -}}
{{- if .Values.nodeSelector }}
{{ toYaml .Values.nodeSelector }}
{{- end }}
{{- end -}}

{{- define "windowsDeployer.tolerations" -}}
{{- if .Values.tolerations -}}
{{ toYaml .Values.tolerations }}
{{- else -}}
- operator: Exists
{{- end -}}
{{- end -}}