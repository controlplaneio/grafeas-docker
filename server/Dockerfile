FROM alpine:latest
WORKDIR /
COPY ./grafeas-server /grafeas-server
COPY ./config.yaml /config.yaml 
COPY ./wait-for-it.sh /wait-for-it.sh
EXPOSE 8080
#ENTRYPOINT [ "./wait-for-it.sh" ]
#ENTRYPOINT [ "./wait-for-it.sh", "database:5432" ]
#ENTRYPOINT ["/grafeas-server", "--config", "config.yaml"]
