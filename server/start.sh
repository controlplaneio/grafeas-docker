#!/bin/sh

timeout=3  # Timeout to wait for the database server to come up, in seconds
debug=true

echoerr() {
    printf "* %s *\n" "$*" 1>&2; 
}

trace() {
    if [ $debug = true ] ; then
        printf "%s\n" "$*"; 
    fi
}

trace 'Running start.sh'

# Get the hostname and port from the config file
server=`grep -Eo "host:\s*\"(.+:[0-9]+)\"" config.yaml | cut -d \" -f2`
trace "Database server= $server"

# Run the wait-for.sh script to check the port is alive, waiting up to 30 seconds
$(./wait-for.sh $server -t $timeout)
rc=$?

if [ $debug = true ] ; then 
    trace "RC= $rc" 
fi

if [ $rc -eq 0 ] ; then
    # Database server is responding so start up Grafeas 
    true
else
    echoerr "Database server has not responded, exiting in error"
    exit 1
fi

echo 'Done'