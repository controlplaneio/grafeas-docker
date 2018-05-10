#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	CREATE USER grafeas WITH LOGIN PASSWORD '9Ptd5EQZFLoufuIby';
	CREATE DATABASE grafeas;
	GRANT ALL PRIVILEGES ON DATABASE grafeas TO grafeas;
EOSQL
