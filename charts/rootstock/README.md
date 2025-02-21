# rootstock

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: ARROWHEAD-6.3.1](https://img.shields.io/badge/AppVersion-ARROWHEAD--6.3.1-informational?style=flat-square)

Deploy and scale [Rootstock](https://dev.rootstock.io/node-operators/) inside Kubernetes with ease

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
| rootstock.__enabled | bool | `true` |  |
| rootstock.workload.__enabled | bool | `true` |  |
| rootstockDefaults.clusterRole | object | `{"__enabled":true,"__name":"role","metadata":{"annotations":{},"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"{{ printf \"%s-%s-%s\" .Root.Release.Name .componentName $roleName }} @needs(.Self.clusterRole.__name as roleName)"},"rules":[{"apiGroups":[""],"resources":["nodes"],"verbs":["get","list","watch"]}]}` | Cluster scoped RBAC role and binding configuration Used by the P2P init-container |
| rootstockDefaults.clusterRoleBinding.__enabled | bool | `true` |  |
| rootstockDefaults.clusterRoleBinding.metadata.annotations | object | `{}` |  |
| rootstockDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| rootstockDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/managed-by" | string | `"{{ .Root.Release.Service }}"` |  |
| rootstockDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| rootstockDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/part-of" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.clusterRoleBinding.metadata.labels.<<."app.kubernetes.io/version" | string | `"{{ .Root.Chart.AppVersion }}"` |  |
| rootstockDefaults.clusterRoleBinding.metadata.labels.<<."helm.sh/chart" | string | `"{{ include \"common.metadata.chart\" . }}"` |  |
| rootstockDefaults.clusterRoleBinding.metadata.name | string | `"{{ print \"%s-binding\" $roleName }} @needs(.Self.clusterRole.metadata.name as roleName)"` |  |
| rootstockDefaults.clusterRoleBinding.roleRef.apiGroup | string | `"rbac.authorization.k8s.io"` |  |
| rootstockDefaults.clusterRoleBinding.roleRef.kind | string | `"ClusterRole"` |  |
| rootstockDefaults.clusterRoleBinding.roleRef.name | string | `"{{ $roleName }} @needs(.Self.clusterRole.metadata.name as roleName)"` |  |
| rootstockDefaults.clusterRoleBinding.subjects.default.kind | string | `"ServiceAccount"` |  |
| rootstockDefaults.clusterRoleBinding.subjects.default.name | string | `"{{ $SAName }} @needs(.Self.serviceAccount.metadata.name as SAName)"` |  |
| rootstockDefaults.clusterRoleBinding.subjects.default.namespace | string | `"{{ .Root.Release.Namespace }}"` |  |
| rootstockDefaults.config.p2p | object | `{"enabled":true,"port":5050}` | Enable a NodePort for P2P support in node |
| rootstockDefaults.config.p2p.enabled | bool | `true` | Expose P2P port via NodePort |
| rootstockDefaults.config.p2p.port | int | `5050` | NodePorts must be unique, or left as empty string "" to be obtained dynamically.  |
| rootstockDefaults.config.rpc.enabled | bool | `true` | Enable JSON-RPC HTTP server |
| rootstockDefaults.config.rpc.http_port | int | `4444` | JSON-RPC HTTP server port |
| rootstockDefaults.config.rpc.ws | bool | `true` | Enable JSON-RPC WebSocket server |
| rootstockDefaults.config.rpc.ws_port | int | `4445` | JSON-RPC WebSocket server port |
| rootstockDefaults.configMap.__enabled | bool | `true` |  |
| rootstockDefaults.configMap.data."node.conf" | string | `"# -- RSKJ configuration file\n# --\nblockchain.config.name = \"main\"\ndatabase.dir = /var/lib/rsk/.rsk/database/mainnet\nrpc {\nproviders : {\n    web: {\n        cors: \"localhost\",\n        http: {\n            enabled: '{{ $rpc.enabled }} @needs(.Self.config.rpc as rpc)',\n            bind_address = \"0.0.0.0\",\n            hosts = [\"localhost\"]\n            port: '{{ $rpc.http_port | int }} @needs(.Self.config.rpc as rpc)',\n            }\n        ws: {\n            enabled: '{{ $rpc.ws }} @needs(.Self.config.rpc as rpc)',\n            bind_address: \"0.0.0.0\",\n            port: '{{ $rpc.ws_port | int }} @needs(.Self.config.rpc as rpc)',\n            }\n        }\n    }\n\n    modules = [\n        {\n            name: \"eth\",\n            version: \"1.0\",\n            enabled: \"true\",\n        },\n        {\n            name: \"net\",\n            version: \"1.0\",\n            enabled: \"true\",\n        },\n        {\n            name: \"rpc\",\n            version: \"1.0\",\n            enabled: \"true\",\n        },\n        {\n            name: \"web3\",\n            version: \"1.0\",\n            enabled: \"true\",\n        },\n        {\n            name: \"evm\",\n            version: \"1.0\",\n            enabled: \"true\"\n        },\n        {\n            name: \"sco\",\n            version: \"1.0\",\n            enabled: \"false\",\n        },\n        {\n            name: \"txpool\",\n            version: \"1.0\",\n            enabled: \"true\",\n        },\n        {\n            name: \"debug\",\n            version: \"1.0\",\n            enabled: \"false\",\n        },        \n        {\n            name: \"personal\",\n            version: \"1.0\",\n            enabled: \"true\"\n        }\n    ]\n}\n"` | RSKJ configuration file |
| rootstockDefaults.configMap.metadata.annotations | object | `{}` |  |
| rootstockDefaults.configMap.metadata.labels."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| rootstockDefaults.configMap.metadata.labels."app.kubernetes.io/part-of" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.configMap.metadata.labels.<<."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| rootstockDefaults.configMap.metadata.labels.<<."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.configMap.metadata.labels.<<."app.kubernetes.io/managed-by" | string | `"{{ .Root.Release.Service }}"` |  |
| rootstockDefaults.configMap.metadata.labels.<<."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| rootstockDefaults.configMap.metadata.labels.<<."app.kubernetes.io/part-of" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.configMap.metadata.labels.<<."app.kubernetes.io/version" | string | `"{{ .Root.Chart.AppVersion }}"` |  |
| rootstockDefaults.configMap.metadata.labels.<<."helm.sh/chart" | string | `"{{ include \"common.metadata.chart\" . }}"` |  |
| rootstockDefaults.configMap.metadata.name | string | `"{{ printf \"%s-%s\" (include \"common.metadata.fullname\" $) .componentName }}"` |  |
| rootstockDefaults.image | object | `{"digest":"","pullPolicy":"IfNotPresent","repository":"rsksmart/rskj","tag":"{{ .Root.Chart.AppVersion }}"}` | Image configuration for rootstock |
| rootstockDefaults.image.digest | string | `""` | Overrides the image reference using a specific digest |
| rootstockDefaults.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| rootstockDefaults.image.repository | string | `"rsksmart/rskj"` | Docker image repository |
| rootstockDefaults.image.tag | string | `"{{ .Root.Chart.AppVersion }}"` | Overrides the image reference using a tag digest takes precedence over tag if both are set |
| rootstockDefaults.podDisruptionBudget | object | `{"__enabled":true,"metadata":{"annotations":{},"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"{{ .Root.Release.Name }}-{{ .componentName }}"},"spec":{"selector":{"matchLabels":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}"}}}}` | .Self.Disruption Budget configuration |
| rootstockDefaults.role | object | `{"__enabled":"{{ $SAEnabled }} @needs(.Self.serviceAccount.__enabled as SAEnabled)","__name":"role","metadata":{"annotations":{},"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"{{ printf \"%s-%s-%s\" .Root.Release.Name .componentName $roleName }} @needs(.Self.role.__name as roleName)"},"rules":[{"apiGroups":[""],"resources":["services"],"verbs":["get","list","watch"]},{"apiGroups":[""],"resources":["secrets"],"verbs":["get","create"]}]}` | RBAC role and binding configuration |
| rootstockDefaults.roleBinding.__enabled | string | `"{{ $roleEnabled }} @needs(.Self.role.__enabled as roleEnabled)"` |  |
| rootstockDefaults.roleBinding.metadata.annotations | object | `{}` |  |
| rootstockDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| rootstockDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/managed-by" | string | `"{{ .Root.Release.Service }}"` |  |
| rootstockDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| rootstockDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/part-of" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.roleBinding.metadata.labels.<<."app.kubernetes.io/version" | string | `"{{ .Root.Chart.AppVersion }}"` |  |
| rootstockDefaults.roleBinding.metadata.labels.<<."helm.sh/chart" | string | `"{{ include \"common.metadata.chart\" . }}"` |  |
| rootstockDefaults.roleBinding.metadata.name | string | `"{{ printf \"%s-%s-%s\" .Root.Release.Name .componentName $roleName }} @needs(.Self.role.__name as roleName)"` |  |
| rootstockDefaults.roleBinding.roleRef.apiGroup | string | `"rbac.authorization.k8s.io"` |  |
| rootstockDefaults.roleBinding.roleRef.kind | string | `"Role"` |  |
| rootstockDefaults.roleBinding.roleRef.name | string | `"{{ $roleName }} @needs(.Self.role.metadata.name as roleName)"` |  |
| rootstockDefaults.roleBinding.subjects[0].kind | string | `"ServiceAccount"` |  |
| rootstockDefaults.roleBinding.subjects[0].name | string | `"{{ $SAName }} @needs(.Self.serviceAccount.metadata.name as SAName)"` |  |
| rootstockDefaults.roleBinding.subjects[0].namespace | string | `"{{ .Root.Release.Namespace }}"` |  |
| rootstockDefaults.serviceAccount.__enabled | bool | `true` | Specifies whether a service account should be created |
| rootstockDefaults.serviceAccount.metadata | object | `{"annotations":{},"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"{{ printf \"%s-%s\" (include \"common.metadata.fullname\" $) .componentName }}"}` | Rest spec |
| rootstockDefaults.serviceAccount.metadata.annotations | object | `{}` | Annotations to add to the service account |
| rootstockDefaults.serviceAccount.metadata.labels | object | `{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}}` | Labels to add to the service account |
| rootstockDefaults.serviceAccount.metadata.name | string | `"{{ printf \"%s-%s\" (include \"common.metadata.fullname\" $) .componentName }}"` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| rootstockDefaults.services.default.__enabled | bool | `true` |  |
| rootstockDefaults.services.default.metadata.annotations | object | `{}` | Additional service annotations |
| rootstockDefaults.services.default.metadata.labels | object | `{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}}` | Additional service labels |
| rootstockDefaults.services.default.metadata.name | string | `"{{ include \"common.metadata.fullname\" $ }}-{{ .componentName }}"` |  |
| rootstockDefaults.services.default.spec.ports | object | `{"http-jsonrpc":{"__enabled":"{{ $rpc.enabled }} @needs(.Self.config.rpc as rpc)","name":"http-jsonrpc","port":"{{ $rpc.http_port | int }} @needs(.Self.config.rpc as rpc)","protocol":"TCP"},"ws-rpc":{"__enabled":"{{ $rpc.ws }} @needs(.Self.config.rpc as rpc)","name":"ws-rpc","port":"{{ $rpc.ws_port | int }} @needs(.Self.config.rpc as rpc)","protocol":"TCP"}}` | Service ports configuration |
| rootstockDefaults.services.default.spec.selector."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| rootstockDefaults.services.default.spec.selector."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.services.default.spec.selector."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| rootstockDefaults.services.default.spec.type | string | `"ClusterIP"` | Service type |
| rootstockDefaults.services.headless.__enabled | bool | `true` |  |
| rootstockDefaults.services.headless.metadata.annotations | object | `{}` | Additional service annotations |
| rootstockDefaults.services.headless.metadata.labels | object | `{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}}` | Additional service labels |
| rootstockDefaults.services.headless.metadata.name | string | `"{{ include \"common.metadata.fullname\" $ }}-{{ .componentName }}-headless"` |  |
| rootstockDefaults.services.headless.spec.<<.ports | object | `{"http-jsonrpc":{"__enabled":"{{ $rpc.enabled }} @needs(.Self.config.rpc as rpc)","name":"http-jsonrpc","port":"{{ $rpc.http_port | int }} @needs(.Self.config.rpc as rpc)","protocol":"TCP"},"ws-rpc":{"__enabled":"{{ $rpc.ws }} @needs(.Self.config.rpc as rpc)","name":"ws-rpc","port":"{{ $rpc.ws_port | int }} @needs(.Self.config.rpc as rpc)","protocol":"TCP"}}` | Service ports configuration |
| rootstockDefaults.services.headless.spec.<<.selector."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| rootstockDefaults.services.headless.spec.<<.selector."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.services.headless.spec.<<.selector."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| rootstockDefaults.services.headless.spec.<<.type | string | `"ClusterIP"` | Service type |
| rootstockDefaults.services.headless.spec.clusterIP | string | `"None"` |  |
| rootstockDefaults.services.p2p.__enabled | string | `"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.services.p2p.metadata.annotations | object | `{}` | Additional service annotations |
| rootstockDefaults.services.p2p.metadata.labels | object | `{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"},"pod":"{{ include \"common.metadata.fullname\" $ }}-{{ .componentName }}-0","type":"p2p"}` | Additional service labels |
| rootstockDefaults.services.p2p.metadata.name | string | `"{{ include \"common.metadata.fullname\" $ }}-{{ .componentName }}-p2p"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-tcp.__enabled | string | `"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-tcp.name | string | `"p2p-tcp"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-tcp.nodePort | string | `"{{- if $p2p.enabled }}\nnull\n{{- end }}\n@needs(.Self.config.p2p as p2p)\n"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-tcp.port | string | `"{{ $p2p.port | int }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-tcp.protocol | string | `"TCP"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-tcp.targetPort | string | `"{{ $p2p.port | int }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-udp.__enabled | string | `"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-udp.name | string | `"p2p-udp"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-udp.nodePort | string | `"{{- if $p2p.enabled }}\nnull\n{{- end }}\n@needs(.Self.config.p2p as p2p)\n"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-udp.port | string | `"{{ $p2p.port | int }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-udp.protocol | string | `"UDP"` |  |
| rootstockDefaults.services.p2p.spec.ports.p2p-udp.targetPort | string | `"{{ $p2p.port | int }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.services.p2p.spec.selector."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| rootstockDefaults.services.p2p.spec.selector."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.services.p2p.spec.selector."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| rootstockDefaults.services.p2p.spec.type | string | `"NodePort"` |  |
| rootstockDefaults.workload.__enabled | bool | `true` |  |
| rootstockDefaults.workload.kind | string | `"StatefulSet"` |  |
| rootstockDefaults.workload.metadata.annotations | object | `{}` | Component level annotations (templated) |
| rootstockDefaults.workload.metadata.labels | object | `{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"},"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}"}` | Component level labels (templated) |
| rootstockDefaults.workload.metadata.name | string | `"{{ printf \"%s-%s\" (include \"common.metadata.fullname\" $) .componentName }}"` |  |
| rootstockDefaults.workload.spec.podManagementPolicy | StatefulSet only | `"{{ eq $kind \"StatefulSet\" | ternary \"OrderedReady\" nil }} @needs(.Self.workload.kind as kind)"` | , scaling behavior: (OrderedReady | Parallel) |
| rootstockDefaults.workload.spec.selector.matchLabels."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| rootstockDefaults.workload.spec.selector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.workload.spec.selector.matchLabels."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| rootstockDefaults.workload.spec.serviceName | string | `"{{ include \"common.metadata.fullname\" $ }}-{{ .componentName }}-headless"` | Required for StatefulSets |
| rootstockDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/component" | string | `"{{ .componentName }}"` |  |
| rootstockDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/instance" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/managed-by" | string | `"{{ .Root.Release.Service }}"` |  |
| rootstockDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/name" | string | `"{{ .Root.Chart.Name }}"` |  |
| rootstockDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/part-of" | string | `"{{ .Root.Release.Name }}"` |  |
| rootstockDefaults.workload.spec.template.metadata.labels.<<."app.kubernetes.io/version" | string | `"{{ .Root.Chart.AppVersion }}"` |  |
| rootstockDefaults.workload.spec.template.metadata.labels.<<."helm.sh/chart" | string | `"{{ include \"common.metadata.chart\" . }}"` |  |
| rootstockDefaults.workload.spec.template.spec.affinity | object | `{}` | Affinity configuration |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.env | object | `{"POD_NAME":{"valueFrom":{"fieldRef":{"fieldPath":"metadata.name"}}}}` | Environment variables |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.image | string | `"{{ printf \"%s:%s\" $repository $tag }} @needs(.Self.image.repository as repository) @needs(.Self.image.tag as tag)"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.imagePullPolicy | string | `"IfNotPresent"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.lifecycle | object | `{}` | Lifecycle hooks |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.http-jsonrpc.__enabled | string | `"{{ $rpc.enabled }} @needs(.Self.config.rpc as rpc)"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.http-jsonrpc.containerPort | string | `"{{ $rpc.http_port | int }} @needs(.Self.config.rpc as rpc)"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.http-jsonrpc.name | string | `"http-jsonrpc"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.http-jsonrpc.protocol | string | `"TCP"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.p2p-tcp.__enabled | string | `"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.p2p-tcp.containerPort | string | `"{{ $p2p.port | int }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.p2p-tcp.name | string | `"p2p-tcp"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.p2p-tcp.protocol | string | `"TCP"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.p2p-udp.__enabled | string | `"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.p2p-udp.containerPort | string | `"{{ $p2p.port | int }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.p2p-udp.name | string | `"p2p-udp"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.p2p-udp.protocol | string | `"UDP"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.ws-rpc.__enabled | string | `"{{ $rpc.ws }} @needs(.Self.config.rpc as rpc)"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.ws-rpc.containerPort | string | `"{{ $rpc.ws_port | int }} @needs(.Self.config.rpc as rpc)"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.ws-rpc.name | string | `"ws-rpc"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.ports.ws-rpc.protocol | string | `"TCP"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.resources | object | `{"limits":{"cpu":6,"memory":"24Gi"},"requests":{"cpu":2,"memory":"24Gi"}}` | Resource requests and limits |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true}` | Container level security context overrides |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.volumeMounts.config.mountPath | string | `"/etc/rsk"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.volumeMounts.config.name | string | `"config"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.volumeMounts.config.subPath | string | `"node.conf"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.volumeMounts.env-dir.__enabled | string | `"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.volumeMounts.env-dir.mountPath | string | `"/env"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.volumeMounts.storage.mountPath | string | `"/var/lib/rsk/.rsk"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.volumeMounts.storage.name | string | `"storage"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.volumeMounts.tmp.mountPath | string | `"/tmp"` |  |
| rootstockDefaults.workload.spec.template.spec.containers.rootstock.volumeMounts.tmp.name | string | `"tmp"` |  |
| rootstockDefaults.workload.spec.template.spec.initContainers | object | `{"10-init-nodeport@common":{"__enabled":"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)","image":"ghcr.io/graphops/docker-builds/init-toolbox:main","imagePullPolicy":"IfNotPresent","resources":{}}}` | Init containers configuration |
| rootstockDefaults.workload.spec.template.spec.nodeSelector | object | `{}` | Node selector configuration |
| rootstockDefaults.workload.spec.template.spec.securityContext | object | `{"fsGroup":"{{ $runAsUser }} @needs(.Self.workload.spec.template.spec.securityContext.runAsUser as runAsUser)","runAsGroup":"{{ $runAsUser }} @needs(.Self.workload.spec.template.spec.securityContext.runAsUser as runAsUser)","runAsNonRoot":true,"runAsUser":1000}` | .Self.wide security context |
| rootstockDefaults.workload.spec.template.spec.serviceAccountName | string | `"{{ $sa.__enabled | ternary $sa.metadata.name nil }} @needs(.Self.serviceAccount as sa)"` |  |
| rootstockDefaults.workload.spec.template.spec.terminationGracePeriodSeconds | int | `10` | Amount of time to wait before force-killing the process |
| rootstockDefaults.workload.spec.template.spec.tolerations | list | `[]` | Tolerations configuration |
| rootstockDefaults.workload.spec.template.spec.topologySpreadConstraints | list | `[]` | Topology spread constraints |
| rootstockDefaults.workload.spec.template.spec.volumes | object | `{"config":{"configMap":{"name":"{{ printf \"%s-%s\" (include \"common.metadata.fullname\" $) .componentName }}"}},"env-dir":{"__enabled":"{{ $p2p.enabled }} @needs(.Self.config.p2p as p2p)","emptyDir":{"medium":"Memory"}},"tmp":{"emptyDir":{}}}` | .Self.volumes |
| rootstockDefaults.workload.spec.updateStrategy.rollingUpdate.partition | int | `0` |  |
| rootstockDefaults.workload.spec.updateStrategy.type | string | `"RollingUpdate"` |  |
| rootstockDefaults.workload.spec.volumeClaimTemplates | object | `{"storage":{"__enabled":true,"metadata":{"labels":{"<<":{"app.kubernetes.io/component":"{{ .componentName }}","app.kubernetes.io/instance":"{{ .Root.Release.Name }}","app.kubernetes.io/managed-by":"{{ .Root.Release.Service }}","app.kubernetes.io/name":"{{ .Root.Chart.Name }}","app.kubernetes.io/part-of":"{{ .Root.Release.Name }}","app.kubernetes.io/version":"{{ .Root.Chart.AppVersion }}","helm.sh/chart":"{{ include \"common.metadata.chart\" . }}"}},"name":"storage"},"spec":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"500Gi"}},"storageClassName":"{{ default nil .Root.Values.global.storageClassName }}"}}}` | Update Strategy, (RollingUpdate | Recreate) for Deployments, (RollingUpdate | OnDelete) for StatefulSets |
| rootstockDefaults.workload.spec.volumeClaimTemplates.storage.spec.resources.requests.storage | string | `"500Gi"` | The amount of disk space to provision for Erigon |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
