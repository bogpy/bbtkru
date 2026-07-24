# 1. Fetch Litestream binary
FROM litestream/litestream:0.3.13 AS litestream

# 2. Build Go application
FROM golang:1.24-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGOENABLED=0 go build -ldflags="-s -w" -o /app/server ./cmd/main.go

# 3. Final Yandex runtime container
FROM alpine:latest
RUN apk add --no-cache ca-certificates tzdata

WORKDIR /app

COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream
COPY --from=builder /app/server /app/server
COPY litestream.yml /etc/litestream.yml

RUN mkdir -p /data
EXPOSE 8080

CMD ["litestream", "replicate", "-config", "/etc/litestream.yml", "-exec", "/app/server"]