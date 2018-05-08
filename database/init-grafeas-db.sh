#!/bin/bash
set -e

echo 'Running init-grafeas-db.sh'

# TODO : Sample the environment to see if a password exists
# TODO : Check if file exists
grafeas_password_file="/Users/colind/.grafeas_password"
password=`cat $grafeas_password_file`

# TODO : If password is blank then abort this step ...

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER grafeas WITH LOGIN PASSWORD $password;
    CREATE DATABASE grafeas;
    GRANT ALL PRIVILEGES ON DATABASE grafeas TO grafeas;
EOSQL

