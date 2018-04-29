#!/bin/sh

echo 'Running start.sh'

rc=99

$(./wait-for.sh localhost:8080 -t 1)
rc=$?

echo 'RC=' $rc

echo 'Done'