# syntax=docker/dockerfile:1

FROM golang:1.24.5-alpine AS builder

RUN addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

WORKDIR /app
COPY . .

RUN go mod download

RUN CGO_ENABLED=0 go build -o /app/pingdom-ingress-check main.go

RUN chown -R appuser:appgroup /app

FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /app /app

USER 1000

EXPOSE 8080
ENTRYPOINT ["/app/pingdom-ingress-check"]
