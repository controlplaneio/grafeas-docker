FROM alpine:latest
WORKDIR /
COPY ./grafeas-server /grafeas-server
COPY ./config.yaml /config.yaml 
EXPOSE 8080
ENTRYPOINT ["/grafeas-server", "--config", "config.yaml"]
