# rancher-windows-deployer

A Rancher chart that sets up a DaemonSet of clients to download and run an executable on a set of Windows nodes on a Kubernetes cluster.

## Node Requirements

Since Windows does not support privileged pods, this chart expects a Named Pipe (`\\.\pipe\rancher_wins`) to exist on the Windows host that allows containers to communicate with the host. This is done by deploying a [rancher/wins](https://github.com/rancher/wins) server on the host.

This chart is configured to create a wins client that communicates with the wins server to execute the Windows binary executable provided to the chart via a download link. Through the wins client and wins server, the Windows binary executable is able to run as a privileged container on the Windows host.

If the cluster you are installing this chart on is a custom cluster that was created via RKE1 with Windows Support enabled, your nodes should already have the wins server running; this should have been added as part of [the bootstrapping process for adding the Windows node onto your RKE1 cluster](https://github.com/rancher/rancher/blob/master/package/windows/bootstrap.ps1).

## Configuration

The following tables list the configurable parameters of the rancher-windows-deployer chart and their default values.

### General

#### Optional
| Parameter | Description | Default |
| ----- | --------------- | -- |
| `clients.enabled` | Deploys a DaemonSet of clients that are each capable of scraping Windows node metrics via [wins](https://github.com/rancher/wins) and [windows-exporter](https://github.com/prometheus-community/windows_exporter) | `true` |
| `clients.port` |  The port where the client will publish Windows metrics | `9796` |
| `clients.image.repository` | The repository for the Docker image that deploys [windows-exporter](https://github.com/prometheus-community/windows_exporter) and runs it through a [wins](https://github.com/rancher/wins) client configured to talk to the wins server on the host | `rancher/wmi_exporter-package` |
| `clients.image.tag` | The tag for the Docker image that deploys [windows-exporter](https://github.com/prometheus-community/windows_exporter) and runs it through a [wins](https://github.com/rancher/wins) client configured to talk to the wins server on the host | `v0.0.4` |
| `clients.endpoints` | A specific set of Endpoints that point to Nodes that expose the metrics at `clients.port` | `[]` |
| `clients.args` | Additional args to provide to the client image | `[]` |
| `clients.env` | Additional environment variables to provide to the client image | `{}` |
| `clients.enabledCollectors` | A comma-separated list of enabled [collectors](https://github.com/prometheus-community/windows_exporter#collectors) | `"net,os,service,system,cpu,cs,logical_disk,tcp,memory,container"` |
| `clients.resources` | Set resource limits and requests for the client container | `{}` |
| `clients.nodeSelector` | Select which nodes to deploy the clients on | `{}` |
| `clients.tolerations` | Specify tolerations for clients | `[]` |
| `clients.imagePullSecrets` | Image Pull Secrets for the service account used by the clients | `{}` |


See [rancher-monitoring](https://github.com/rancher/charts/tree/gh-pages/packages/rancher-monitoring) for an example of how this chart can be used.