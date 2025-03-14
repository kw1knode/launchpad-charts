{{- $ := index . 0 }}
{{- $input := index . 1 }}

{{- $paths := list }}

{{/* TODO: write a function to guarantee the paths are sorted alphabetically */}}
{{- $containers := dig "spec" "template" "spec" "containers" dict $input }}
{{- range $containerName, $container := $containers }}
{{- $containerPaths := list
(dict "path" (printf "%s.%s.%s" "spec.template.spec.containers" $containerName "ports") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.containers" $containerName "volumeMounts") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.containers" $containerName "volumeDevices") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.containers" $containerName "env") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.containers" $containerName "lifecycle.postStart.httpGet.httpHeaders") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.containers" $containerName "lifecycle.preStop.httpGet.httpHeaders") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.containers" $containerName "livenessProbe.httpGet.httpHeaders") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.containers" $containerName "readinessProbe.httpGet.httpHeaders") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.containers" $containerName "startupProbe.httpGet.httpHeaders") "indexKey" "name")
}}
{{- $paths = concat $paths $containerPaths }}
{{- end }}

{{- $initContainers := dig "spec" "template" "spec" "initContainers" dict $input }}
{{- range $containerName, $container := $initContainers }}
{{- $initContainerPaths := list
(dict "path" (printf "%s.%s.%s" "spec.template.spec.initContainers" $containerName "ports") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.initContainers" $containerName "volumeMounts") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.initContainers" $containerName "volumeDevices") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.initContainers" $containerName "env") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.initContainers" $containerName "lifecycle.postStart.httpGet.httpHeaders") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.initContainers" $containerName "lifecycle.preStop.httpGet.httpHeaders") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.initContainers" $containerName "livenessProbe.httpGet.httpHeaders") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.initContainers" $containerName "readinessProbe.httpGet.httpHeaders") "indexKey" "name")
(dict "path" (printf "%s.%s.%s" "spec.template.spec.initContainers" $containerName "startupProbe.httpGet.httpHeaders") "indexKey" "name")
}}
{{- $paths = concat $paths $initContainerPaths }}
{{- end }}

{{- $paths = concat $paths (list
(dict "path" "spec.volumeClaimTemplates" "indexKey" nil)
(dict "path" "spec.template.spec.containers" "indexKey" "name")
(dict "path" "spec.template.spec.initContainers" "indexKey" "name")
(dict "path" "spec.template.spec.ephemeralContainers" "indexKey" "name")
(dict "path" "spec.template.spec.volumes" "indexKey" "name")
)}}

{{- list $ $input $paths | include "common.utils.transformMapToList" }}
{{- $output := $.__common.fcallResult }}

{{- $_ := set $.__common "fcallResult" $output }}
