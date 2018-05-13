#!/bin/bash

# This is a simple convenience script to run the local instance of the Postgres server 
# built via the Compose step. Additionally it runs a funky Postgres web UI tool to allow
# inspection of what's in the database in order to debug the Grafeas API.

# Run the database
# docker run -d \
#     --name postgres_local \
#     --network grafeas\
#     -p 5432:5432 \
#     -e POSTGRES_PASSWORD=rover37a \
#     -e GRAFEAS_PASSWORD=9Ptd5EQZFLoufuIby \
#     grafeas-docker_database

# Run the web GUI tool
docker run -d \
    --name pgadmin4 \
    -p 8888:80 \
    --network grafeas \
    -e PGADMIN_DEFAULT_EMAIL=colin.domoney@gmail.com \
    -e PGADMIN_DEFAULT_PASSWORD=rover37a \
    dpage/pgadmin4