# puma-exporter: exports puma stats for Prometheus

```
$ curl localhost:9394/metrics
# Number of connections waiting for puma thread to serve it
puma_backlog{worker_index="0"} 0
# Number of puma threads spawned
puma_running{worker_index="0"} 5
# Number of requests puma is capable of taking right now
puma_pool_capacity{worker_index="0"} 16
# Maximum number of puma threads
puma_max_threads{worker_index="0"} 16
```

## Configuration:

| ENV variable | Default | Description |
| --- | --- | --- |
| `PUMA_THREADS_MIN` | `5` | Minimum number of threads exporter's puma is spawning |
| `PUMA_THREADS_MAX` | `16` | Maximum number of threads exporter's puma is spawning |
| `PUMA_PORT` | `9394` | Exporter's port |
| `CONTROL_APP_URL` | `http://127.0.0.1:9293` | URL of monitored puma's control app |
