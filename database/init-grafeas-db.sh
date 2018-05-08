#!/bin/bash
set -e

echo 'Running init-grafeas-db.sh'

grafeas_password_file="/.grafeas_password"
password=''

# Get the password from the Grafeas password file
if [ -f $grafeas_password_file ]
then
    password=`cat $grafeas_password_file`
fi

# Pull the environment variable 
env_password=`printenv GRAFEAS_PASSWORD`

# Sample the environment variable
if [ ! -z "$env_password" ]
then
    password=$env_password
fi

# If we got a blank password then exit without further ado
if [ -z "$password" ]
then 
    echo "Failed to ingest a database password"
    exit 1
fi

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER grafeas WITH LOGIN PASSWORD '$password';
    CREATE DATABASE grafeas;
    GRANT ALL PRIVILEGES ON DATABASE grafeas TO grafeas;
EOSQL

