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

## Settings

See [Chart Readme](./chart/README.yaml) for Configuration.

