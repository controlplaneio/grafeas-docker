#!/bin/sh

timeout=10  # Timeout to wait for the database server to come up, in seconds
debug=true
config_file="config.yaml"
grafeas_password_file="/.grafeas_password"

echoerr() {
    printf "* %s *\n" "$*" 1>&2; 
}

trace() {
    if [ $debug = true ] ; then
        printf "%s\n" "$*"; 
    fi
}

trace 'Running start.sh'

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
    echoerr "Failed to ingest a database password"
    exit 1
fi

sed -i "s/password:.*\".*\"/password: \"$password\"/" $config_file

# Get the hostname and port from the config file, checking if the file exists first
if [ -f $config_file ] 
then
    server=`grep -Eo "host:\s*\"(.+:[0-9]+)\"" $config_file | cut -d \" -f2`
else
    server='postgres:5432'
fi

trace "Database server= $server"

# Run the wait-for.sh script to check the port is alive, waiting up to 30 seconds
$(./wait-for.sh $server -t $timeout)
rc=$?
trace "RC= $rc" 

if [ $rc -eq 0 ] ; then
    # Database server is responding so start up Grafeas 
    $(./grafeas-server --config config.yaml)
else
    echoerr "Database server has not responded, exiting in error"
    exit 1
fi

echo 'Done'