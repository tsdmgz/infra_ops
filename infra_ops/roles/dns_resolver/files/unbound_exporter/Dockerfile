FROM docker.io/golang:1.20-alpine as build
WORKDIR /go
RUN go install github.com/letsencrypt/unbound_exporter@latest

FROM alpine
WORKDIR /app
RUN apk add curl
COPY --from=build /go/bin/unbound_exporter /app/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /app/unbound_exporter /usr/local/bin/entrypoint.sh
ENTRYPOINT /usr/local/bin/entrypoint.sh "$@"
