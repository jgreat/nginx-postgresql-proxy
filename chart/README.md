# nginx-postgresql-proxy

Simple nginx proxy to forward connections for a external postgresql instance that your kubernetes cluster has access to.

Handy for when you want to lock down the DB access to just your cluster nodes and add the additional layer of kubernetes authentication for access.

The helm chart creates a `ClusterIP` service. Use `kubectl port-forward` to access the database.

```sh
kubectl port-forward service/<release name> 5432:postgresql
```

Then connect to `127.0.0.1:5432`

```sh
psql "postgres://<user>:<pass>@127.0.0.1:5432/postgres?sslmode=require"
```

## Features

Runs as a non root user and a read only filesystem. Writable locations use EmptyDir volumes.

## Install with Helm

Clone this repo and install the chart from the local directory.

```sh
helm install postgres-proxy ./chart \
  --set hostname="dbhostname.example.com" \
  --set port="5432"
```

## Configuration

Set `hostname` and `port` or use an existing configMap with a `hostname` and `port` value.

| Value | Default | Description |
| --- | --- | --- |
| `databaseConfigMap.name` | "" | Name of configMap to use for database details. See `databaseConfigMap.useExisting`. |
| `databaseConfigMap.useExisting` | `false` | Use an existing configMap instead of `hostname` and `port` values.  Expects a configMap with `data.hostname and `data.port` values. |
| `hostname` | "" | Hostname or IP address of the upstream Database connection. |
| `port` | "5432" | Port of the upstream Database connection. |

## Pod/Deployment Settings

| Value | Default | Description |
| --- | --- | --- |
| `affinity` | `{}` | Pod affinity block |
| `image.repository` | `jgreat/nginx-postgresql-proxy` | Override repo |
| `image.tag` | `.Chart.appVersion` | Overrides the image tag |
| `imagePullSecrets` | `[]` | List of Pod imagePullSecrets |
| `fullNameOverride` | `{{ .Chart.release }}-{{ .Chart.name }}` | Override fullName |
| `nameOverride` | `.Chart.release` | Override name. |
| `nodeSelector` | `{}` | Pod nodeSelector block. |
| `podSecurityContext` | see values.yaml | podSecurityContext block. Default runs containers as non-root |
| `resources` | see values.yaml | Pod resources block |
| `securityContext` | see values.yaml | Container securityContext block. Default drops capabilities and runs as ReadOnly |
| `tolerations` | `[]` | Pod tolerations block |
