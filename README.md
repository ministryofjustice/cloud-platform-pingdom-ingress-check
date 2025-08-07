# Cloud Platform Pingdom Ingress Check

- Lightweight Go http server with a single `healthz` route for deployment behind CP ingress controller class(es) as a target for Pingdom checks

## Local dev

- Set env var for GIN_MODE

```
export GIN_MODE="[debug/test/release]"

run main.go
```
