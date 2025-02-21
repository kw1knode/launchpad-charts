# moonbeam

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.42.1-3400-latest](https://img.shields.io/badge/AppVersion-v0.42.1--3400--latest-informational?style=flat-square)

Deploy and scale [Moonbeam](https://docs.moonbeam.network/node-operators/networks/tracing-node/) inside Kubernetes with ease

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../common | common | 0.0.1-canary.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.annotations | object | `{}` | Global annotations added to all resources |
| global.fullnameOverride | string | `""` |  |
| global.labels | object | `{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}` | Global labels added to all resources |
| global.nameOverride | string | `""` |  |
| global.storageClassName | string | `"linstor-dynamic"` | Set a default storage class to use everywhere by default |
| moonbeam.__enabled | bool | `true` |  |
| moonbeam.workload.__enabled | bool | `true` |  |
| moonbeam.workload.replicaCount | int | `1` |  |
| moonbeamDefaults.clusterRole | object | `{"__enabled":true,"__name":"role","metadata":{"annotations":{},"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"{{ printf \"%s-%s-%s\" .Root.Release.Name .componentName $roleName }} @needs(.Self.clusterRole.__name as roleName)"},"rules":[{"apiGroups":[""],"resources":["nodes"],"verbs":["get","list","watch"]}]}` | Cluster scoped RBAC role and binding configuration Used by the P2P init-container |
| moonbeamDefaults.clusterRoleBinding.__enabled | bool | `true` |  |
| moonbeamDefaults.clusterRoleBinding.metadata.annotations | object | `{}` |  |
| moonbeamDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| moonbeamDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| moonbeamDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/managed-by" | string | `"{{ .Root.Release.Service }}"` |  |
| moonbeamDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| moonbeamDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/part-of" | string | `"{{ .Root.Release.Name }}"` |  |
| moonbeamDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/version" | string | `"{{ .Root.Chart.AppVersion }}"` |  |
| moonbeamDefaults.clusterRoleBinding.metadata.labels.<<."helm.sh/chart" | string | `"{{ include \"common.metadata.chart\" . }}"` |  |
| moonbeamDefaults.clusterRoleBinding.metadata.name | string | `"{{ print \"%s-binding\" $roleName }} @needs(.Self.clusterRole.metadata.name as roleName)"` |  |
| moonbeamDefaults.clusterRoleBinding.roleRef.apiGroup | string | `"rbac.authorization.k8s.io"` |  |
| moonbeamDefaults.clusterRoleBinding.roleRef.kind | string | `"ClusterRole"` |  |
| moonbeamDefaults.clusterRoleBinding.roleRef.name | string | `"{{ $roleName }} @needs(.Self.clusterRole.metadata.name as roleName)"` |  |
| moonbeamDefaults.clusterRoleBinding.subjects.default.kind | string | `"ServiceAccount"` |  |
| moonbeamDefaults.clusterRoleBinding.subjects.default.name | string | `"{{ $SAName }} @needs(.Self.serviceAccount.metadata.name as SAName)"` |  |
| moonbeamDefaults.clusterRoleBinding.subjects.default.namespace | string | `"{{ .Root.Release.Namespace }}"` |  |
| moonbeamDefaults.config.args.__prefix | string | `"--"` |  |
| moonbeamDefaults.config.args.__separator | string | `"="` |  |
| moonbeamDefaults.config.args.base-path | string | `"/storage"` |  |
| moonbeamDefaults.config.args.chain | string | `"moonbeam"` |  |
| moonbeamDefaults.config.args.db-cache | int | `64000` |  |
| moonbeamDefaults.config.args.ethapi | string | `"debug,trace,txpool"` |  |
| moonbeamDefaults.config.args.name | string | `"test"` |  |
| moonbeamDefaults.config.args.port | string | `"{{ $p2p.enabled | ternary \"30333\" \"30333\" }} @needs(.Self.config.p2p as p2p)"` |  |
| moonbeamDefaults.config.args.prometheus-port | int | `9090` |  |
| moonbeamDefaults.config.args.rpc-cors | string | `"all"` |  |
| moonbeamDefaults.config.args.rpc-port | int | `9944` |  |
| moonbeamDefaults.config.args.runtime-cache-size | int | `64` |  |
| moonbeamDefaults.config.args.state-pruning | string | `"archive"` |  |
| moonbeamDefaults.config.args.trie-cache-size | int | `1073741824` |  |
| moonbeamDefaults.config.args.unsafe-rpc-external | string | `"__none"` |  |
| moonbeamDefaults.config.args.wasm-runtime-overrides | string | `"/moonbeam/moonbeam-substitutes-tracing"` |  |
| moonbeamDefaults.config.argsOrder | list | `[]` |  |
| moonbeamDefaults.config.metrics | object | `{"addr":"0.0.0.0","enabled":true,"port":9090}` | Enable support for metrics |
| moonbeamDefaults.config.p2p | object | `{"enabled":false,"port":30333}` | Enable a NodePort for P2P support in node |
| moonbeamDefaults.config.p2p.enabled | bool | `false` | Expose P2P port via NodePort |
| moonbeamDefaults.config.p2p.port | int | `30333` | NodePorts must be unique, or left as empty string "" to be obtained dynamically.  |
| moonbeamDefaults.image | object | `{"digest":"","pullPolicy":"IfNotPresent","repository":"moonbeamfoundation/moonbeam-tracing","tag":"{{ .Root.Chart.AppVersion }}"}` | Image configuration for moonbeam |
| moonbeamDefaults.image.digest | string | `""` | Overrides the image reference using a specific digest |
| moonbeamDefaults.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| moonbeamDefaults.image.repository | string | `"moonbeamfoundation/moonbeam-tracing"` | Docker image repository |
| moonbeamDefaults.image.tag | string | `"{{ .Root.Chart.AppVersion }}"` | Overrides the image reference using a tag digest takes precedence over tag if both are set |
| moonbeamDefaults.podDisruptionBudget | object | `{"__enabled":true,"metadata":{"annotations":{},"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"{{ .Root.Release.Name }}-{{ .componentName }}"},"spec":{"selector":{"matchLabels":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}"}}}}` | .Self.Disruption Budget configuration |
| moonbeamDefaults.role | object | `{"__enabled":"{{ $SAEnabled }} @needs(.Self.serviceAccount.__enabled as SAEnabled)","__name":"role","metadata":{"annotations":{},"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"{{ printf \"%s-%s-%s\" .Root.Release.Name .componentName $roleName }} @needs(.Self.role.__name as roleName)"},"rules":[{"apiGroups":[""],"resources":["services"],"verbs":["get","list","watch"]},{"apiGroups":[""],"resources":["secrets"],"verbs":["get","create"]}]}` | RBAC role and binding configuration |
| moonbeamDefaults.roleBinding.__enabled | string | `"{{ $roleEnabled }} @needs(.Self.role.__enabled as roleEnabled)"` |  |
| moonbeamDefaults.roleBinding.metadata.annotations | object | `{}` |  |
| moonbeamDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| moonbeamDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| moonbeamDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/managed-by" | string | `"{{ .Root.Release.Service }}"` |  |
| moonbeamDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| moonbeamDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/part-of" | string | `"{{ .Root.Release.Name }}"` |  |
| moonbeamDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/version" | string | `"{{ .Root.Chart.AppVersion }}"` |  |
| moonbeamDefaults.roleBinding.metadata.labels.<<."helm.sh/chart" | string | `"{{ include \"common.metadata.chart\" . }}"` |  |
| moonbeamDefaults.roleBinding.metadata.name | string | `"{{ printf \"%s-%s-%s\" .Root.Release.Name .componentName $roleName }} @needs(.Self.role.__name as roleName)"` |  |
| moonbeamDefaults.roleBinding.roleRef.apiGroup | string | `"rbac.authorization.k8s.io"` |  |
| moonbeamDefaults.roleBinding.roleRef.kind | string | `"Role"` |  |
| moonbeamDefaults.roleBinding.roleRef.name | string | `"{{ $roleName }} @needs(.Self.role.metadata.name as roleName)"` |  |
| moonbeamDefaults.roleBinding.subjects[0].kind | string | `"ServiceAccount"` |  |
| moonbeamDefaults.roleBinding.subjects[0].name | string | `"{{ $SAName }} @needs(.Self.serviceAccount.metadata.name as SAName)"` |  |
| moonbeamDefaults.roleBinding.subjects[0].namespace | string | `"{{ .Root.Release.Namespace }}"` |  |
| moonbeamDefaults.serviceAccount | object | `{"__enabled":true,"metadata":{"annotations":{},"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"{{ printf \"%s-%s\" (include \"common.metadata.fullname\" $) .componentName }}"}}` | Service account configuration |
| moonbeamDefaults.serviceAccount.__enabled | bool | `true` | Specifies whether a service account should be created |
| moonbeamDefaults.serviceAccount.metadata | object | `{"annotations":{},"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"{{ printf \"%s-%s\" (include \"common.metadata.fullname\" $) .componentName }}"}` | Rest spec |
| moonbeamDefaults.serviceAccount.metadata.annotations | object | `{}` | Annotations to add to the service account |
| moonbeamDefaults.serviceAccount.metadata.labels | object | `{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}}` | Labels to add to the service account |
| moonbeamDefaults.serviceAccount.metadata.name | string | `"{{ printf \"%s-%s\" (include \"common.metadata.fullname\" $) .componentName }}"` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| moonbeamDefaults.serviceMonitor | object | `{"__enabled":true,"metadata":{"annotations":{},"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"{{ printf \"%s-%s\" (include \"common.metadata.fullname\" $) .componentName }}"},"spec":{"endpoints":{"http-metrics":{"honorLabels":true,"interval":"30s","path":"/metrics","scrapeTimeout":"10s"}},"jobLabel":"{{- .Root.Release.Name }}","namespaceSelector":{"matchNames":["{{- .Root.Release.Namespace }}"]},"selector":{"matchLabels":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}"}}}}` | ServiceMonitor configuration for Prometheus Operator |
| moonbeamDefaults.serviceMonitor.__enabled | bool | `true` | Enable monitoring by creating `ServiceMonitor` CRDs ([prometheus-operator](https://github.com/prometheus-operator/prometheus-operator)) |
| moonbeamDefaults.services.default.__enabled | bool | `true` |  |
| moonbeamDefaults.services.default.metadata.annotations | object | `{}` | Additional service annotations |
| moonbeamDefaults.services.default.metadata.labels | object | `{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}}` | Additional service labels |
| moonbeamDefaults.services.default.metadata.name | string | `"{{ include \"common.metadata.fullname\" $ }}-{{ .componentName }}"` |  |
| moonbeamDefaults.services.default.spec.ports | object | `{"http-jsonrpc":{"__enabled":"{{ if $args.http }}true{{else}}false{{ end }} @needs(.Self.config.args as args)","name":"http-jsonrpc","port":"{{ index $args \"http.port\" | int }} @needs(.Self.config.args as args)","protocol":"TCP"},"http-metrics":{"__enabled":"{{ $metrics.enabled }} @needs(.Self.config.metrics as metrics)","name":"http-metrics","port":"{{ $metrics.port | int }} @needs(.Self.config.metrics as metrics)","protocol":"TCP"},"ws-rpc":{"__enabled":"{{ index $args \"ws\" }} @needs(.Self.config.args as args)","name":"ws-rpc","port":"{{ index $args \"ws.port\" | int }} @needs(.Self.config.args as args)","protocol":"TCP"}}` | Service ports configuration |
| moonbeamDefaults.services.default.spec.selector."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| moonbeamDefaults.services.default.spec.selector."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| moonbeamDefaults.services.default.spec.selector."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| moonbeamDefaults.services.default.spec.type | string | `"ClusterIP"` | Service type |
| moonbeamDefaults.services.headless.__enabled | bool | `true` |  |
| moonbeamDefaults.services.headless.metadata.annotations | object | `{}` | Additional service annotations |
| moonbeamDefaults.services.headless.metadata.labels | object | `{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}}` | Additional service labels |
| moonbeamDefaults.services.headless.metadata.name | string | `"{{ include \"common.metadata.fullname\" $ }}-{{ .componentName }}-headless"` |  |
| moonbeamDefaults.services.headless.spec.<<.ports | object | `{"http-jsonrpc":{"__enabled":"{{ if $args.http }}true{{else}}false{{ end }} @needs(.Self.config.args as args)","name":"http-jsonrpc","port":"{{ index $args \"http.port\" | int }} @needs(.Self.config.args as args)","protocol":"TCP"},"http-metrics":{"__enabled":"{{ $metrics.enabled }} @needs(.Self.config.metrics as metrics)","name":"http-metrics","port":"{{ $metrics.port | int }} @needs(.Self.config.metrics as metrics)","protocol":"TCP"},"ws-rpc":{"__enabled":"{{ index $args \"ws\" }} @needs(.Self.config.args as args)","name":"ws-rpc","port":"{{ index $args \"ws.port\" | int }} @needs(.Self.config.args as args)","protocol":"TCP"}}` | Service ports configuration |
| moonbeamDefaults.services.headless.spec.<<.selector."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| moonbeamDefaults.services.headless.spec.<<.selector."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| moonbeamDefaults.services.headless.spec.<<.selector."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| moonbeamDefaults.services.headless.spec.<<.type | string | `"ClusterIP"` | Service type |
| moonbeamDefaults.services.headless.spec.clusterIP | string | `"None"` |  |
| moonbeamDefaults.services.p2p.__enabled | string | `"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)"` |  |
| moonbeamDefaults.services.p2p.metadata.annotations | object | `{}` | Additional service annotations |
| moonbeamDefaults.services.p2p.metadata.labels | object | `{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"},"pod":"{{ include \"common.metadata.fullname\" $ }}-{{ .componentName }}-0","type":"p2p"}` | Additional service labels |
| moonbeamDefaults.services.p2p.metadata.name | string | `"{{ include \"common.metadata.fullname\" $ }}-{{ .componentName }}-p2p"` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-tcp.__enabled | bool | `true` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-tcp.containerPort | string | `nil` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-tcp.name | string | `"p2p-tcp"` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-tcp.nodePort | string | `"{{- if not (empty $p2p.port) }}\n{{ $p2p.port | int }}\n{{- else }}\nnull\n{{- end }}\n@needs(.Self.config.p2p as p2p)\n"` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-tcp.port | int | `30303` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-tcp.protocol | string | `"TCP"` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-udp.__enabled | bool | `true` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-udp.containerPort | string | `nil` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-udp.name | string | `"p2p-udp"` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-udp.nodePort | string | `"{{- if not (empty $p2p.port) }}\n{{ $p2p.port | int }}\n{{- else }}\nnull\n{{- end }}\n@needs(.Self.config.p2p as p2p)\n"` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-udp.port | int | `30303` |  |
| moonbeamDefaults.services.p2p.spec.ports.p2p-udp.protocol | string | `"UDP"` |  |
| moonbeamDefaults.services.p2p.spec.selector."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| moonbeamDefaults.services.p2p.spec.selector."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| moonbeamDefaults.services.p2p.spec.selector."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| moonbeamDefaults.workload.__enabled | bool | `true` |  |
| moonbeamDefaults.workload.kind | string | `"StatefulSet"` |  |
| moonbeamDefaults.workload.metadata.annotations | object | `{}` | Component level annotations (templated) |
| moonbeamDefaults.workload.metadata.labels | object | `{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"},"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}"}` | Component level labels (templated) |
| moonbeamDefaults.workload.metadata.name | string | `"{{ printf \"%s-%s\" (include \"common.metadata.fullname\" $) .componentName }}"` |  |
| moonbeamDefaults.workload.spec.podManagementPolicy | StatefulSet only | `"{{ eq $kind \"StatefulSet\" | ternary \"OrderedReady\" nil }} @needs(.Self.workload.kind as kind)"` | , scaling behavior: (OrderedReady | Parallel) |
| moonbeamDefaults.workload.spec.replicas | string | `"{{ $replicaCount | default 1 }} @needs(.Self.workload.replicaCount as replicaCount)"` |  |
| moonbeamDefaults.workload.spec.selector.matchLabels."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| moonbeamDefaults.workload.spec.selector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| moonbeamDefaults.workload.spec.selector.matchLabels."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| moonbeamDefaults.workload.spec.serviceName | string | `"{{ include \"common.metadata.fullname\" $ }}-{{ .componentName }}-headless"` | Required for StatefulSets |
| moonbeamDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| moonbeamDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| moonbeamDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/managed-by" | string | `"{{ .Root.Release.Service }}"` |  |
| moonbeamDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| moonbeamDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/part-of" | string | `"{{ .Root.Release.Name }}"` |  |
| moonbeamDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/version" | string | `"{{ .Root.Chart.AppVersion }}"` |  |
| moonbeamDefaults.workload.spec.template.metadata.labels.<<."helm.sh/chart" | string | `"{{ include \"common.metadata.chart\" . }}"` |  |
| moonbeamDefaults.workload.spec.template.spec.affinity | object | `{}` | Affinity configuration |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.command | list | `["/bin/bash","-c","set -ex\n\nENV_DIR=\"/env\"\n\nif [ -d /env ]; then\n  set -o allexport\n  for env_file in \"$ENV_DIR\"/*; do\n    [ -f \"$env_file\" ] && source \"$env_file\"\n  done\n  set +o allexport\nfi\nexec /moonbeam/moonbeam\n{{- $__parameters := dict\n  \"map\" $args\n  \"orderList\" ( $argsOrder | default list )\n}}\n{{- $argsList := include \"common.utils.generateArgsList\" $__parameters | fromYamlArray }}\n{{ join \" \\\\\\n\" (initial $argsList) }}\n{{ (last $argsList) }}\n@needs(.Self.config.args as args)\n@needs(.Self.config.argsOrder as argsOrder)\n"]` | Container entrypoint |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.env | object | `{"POD_NAME":{"valueFrom":{"fieldRef":{"fieldPath":"metadata.name"}}}}` | Environment variables |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.image | string | `"{{ printf \"%s:%s\" $repository $tag }} @needs(.Self.image.repository as repository) @needs(.Self.image.tag as tag)"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.imagePullPolicy | string | `"IfNotPresent"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.lifecycle | object | `{}` | Lifecycle hooks |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.http-jsonrpc.__enabled | string | `"{{ index $args \"http.enabled\" }} @needs(.Self.config.args as args)"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.http-jsonrpc.containerPort | string | `"{{ index $args \"http.port\" }} @needs(.Self.config.args as args)"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.http-jsonrpc.name | string | `"http-jsonrpc"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.http-jsonrpc.protocol | string | `"TCP"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.http-metrics.__enabled | string | `"{{ $metrics.enabled }} @needs(.Self.config.metrics as metrics)"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.http-metrics.containerPort | string | `"{{ $metrics.port | int }} @needs(.Self.config.metrics as metrics)"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.http-metrics.name | string | `"http-metrics"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.http-metrics.protocol | string | `"TCP"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.p2p-tcp.__enabled | string | `"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.p2p-tcp.containerPort | int | `30303` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.p2p-tcp.name | string | `"p2p-tcp"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.p2p-tcp.protocol | string | `"TCP"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.p2p-udp.__enabled | string | `"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.p2p-udp.containerPort | int | `30303` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.p2p-udp.name | string | `"p2p-udp"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.p2p-udp.protocol | string | `"UDP"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.ws-rpc.__enabled | string | `"{{ index $args \"ws\" }} @needs(.Self.config.args as args)"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.ws-rpc.containerPort | string | `"{{ index $args \"ws.port\" }} @needs(.Self.config.args as args)"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.ws-rpc.name | string | `"ws-rpc"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.ports.ws-rpc.protocol | string | `"TCP"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.resources | object | `{"limits":{"cpu":6,"memory":"16Gi"},"requests":{"cpu":2,"memory":"4Gi"}}` | Resource requests and limits |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true}` | Container level security context overrides |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.volumeMounts.env-dir.__enabled | string | `"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.volumeMounts.env-dir.mountPath | string | `"/env"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.volumeMounts.storage.mountPath | string | `"/storage"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.volumeMounts.storage.name | string | `"storage"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.volumeMounts.tmp.mountPath | string | `"/tmp"` |  |
| moonbeamDefaults.workload.spec.template.spec.containers.moonbeam.volumeMounts.tmp.name | string | `"tmp"` |  |
| moonbeamDefaults.workload.spec.template.spec.initContainers | object | `{"10-init-nodeport@common":{"__enabled":"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)","image":"ghcr.io/graphops/docker-builds/init-toolbox:main","imagePullPolicy":"IfNotPresent","resources":{}}}` | Init containers configuration |
| moonbeamDefaults.workload.spec.template.spec.nodeSelector | object | `{}` | Node selector configuration |
| moonbeamDefaults.workload.spec.template.spec.securityContext | object | `{"fsGroup":"{{ $runAsUser }} @needs(.Self.workload.spec.template.spec.securityContext.runAsUser as runAsUser)","runAsGroup":"{{ $runAsUser }} @needs(.Self.workload.spec.template.spec.securityContext.runAsUser as runAsUser)","runAsNonRoot":true,"runAsUser":1000}` | .Self.wide security context |
| moonbeamDefaults.workload.spec.template.spec.serviceAccountName | string | `"{{ $sa.__enabled | ternary $sa.metadata.name nil }} @needs(.Self.serviceAccount as sa)"` |  |
| moonbeamDefaults.workload.spec.template.spec.terminationGracePeriodSeconds | int | `10` | Amount of time to wait before force-killing the process |
| moonbeamDefaults.workload.spec.template.spec.tolerations | list | `[]` | Tolerations configuration |
| moonbeamDefaults.workload.spec.template.spec.topologySpreadConstraints | list | `[]` | Topology spread constraints |
| moonbeamDefaults.workload.spec.template.spec.volumes | object | `{"env-dir":{"__enabled":"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)","emptyDir":{"medium":"Memory"}},"tmp":{"emptyDir":{}}}` | .Self.volumes |
| moonbeamDefaults.workload.spec.updateStrategy.rollingUpdate.partition | int | `0` |  |
| moonbeamDefaults.workload.spec.updateStrategy.type | string | `"RollingUpdate"` |  |
| moonbeamDefaults.workload.spec.volumeClaimTemplates | object | `{"storage":{"__enabled":true,"metadata":{"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"storage"},"spec":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"3Ti"}},"storageClassName":"{{ default nil .Root.Values.global.storageClassName }}"}}}` | Update Strategy, (RollingUpdate | Recreate) for Deployments, (RollingUpdate | OnDelete) for StatefulSets |
| moonbeamDefaults.workload.spec.volumeClaimTemplates.storage.spec.resources.requests.storage | string | `"3Ti"` | The amount of disk space to provision for Erigon |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
