#!/bin/bash
#Locust help:
#Options:
#  -h, --help            show this help message and exit
#  -H HOST, --host=HOST  Host to load test in the following format:
#                        http://10.21.32.33
#  --web-host=WEB_HOST   Host to bind the web interface to. Defaults to '' (all
#                        interfaces)
#  -P PORT, --port=PORT, --web-port=PORT
#                        Port on which to run web host
#  -f LOCUSTFILE, --locustfile=LOCUSTFILE
#                        Python module file to import, e.g. '../other.py'.
#                        Default: locustfile
#  --master              Set locust to run in distributed mode with this
#                        process as master
#  --slave               Set locust to run in distributed mode with this
#                        process as slave
#  --master-host=MASTER_HOST
#                        Host or IP address of locust master for distributed
#                        load testing. Only used when running with --slave.
#                        Defaults to 127.0.0.1.
#  --master-port=MASTER_PORT
#                        The port to connect to that is used by the locust
#                        master for distributed load testing. Only used when
#                        running with --slave. Defaults to 5557. Note that
#                        slaves will also connect to the master node on this
#                        port + 1.
#  --master-bind-host=MASTER_BIND_HOST
#                        Interfaces (hostname, ip) that locust master should
#                        bind to. Only used when running with --master.
#                        Defaults to * (all available interfaces).
#  --master-bind-port=MASTER_BIND_PORT
#                        Port that locust master should bind to. Only used when
#                        running with --master. Defaults to 5557. Note that
#                        Locust will also use this port + 1, so by default the
#                        master node will bind to 5557 and 5558.
#  --no-web              Disable the web interface, and instead start running
#                        the test immediately. Requires -c and -r to be
#                        specified.
#  -c NUM_CLIENTS, --clients=NUM_CLIENTS
#                        Number of concurrent clients. Only used together with
#                        --no-web
#  -r HATCH_RATE, --hatch-rate=HATCH_RATE
#                        The rate per second in which clients are spawned. Only
#                        used together with --no-web
#  -n NUM_REQUESTS, --num-request=NUM_REQUESTS
#                        Number of requests to perform. Only used together with
#                        --no-web
#  -L LOGLEVEL, --loglevel=LOGLEVEL
#                        Choose between DEBUG/INFO/WARNING/ERROR/CRITICAL.
#                        Default is INFO.
#  --logfile=LOGFILE     Path to log file. If not set, log will go to
#                        stdout/stderr
#  --print-stats         Print stats in the console
#  --only-summary        Only print the summary stats
#  -l, --list            Show list of possible locust classes and exit
#  --show-task-ratio     print table of the locust classes' task execution
#                        ratio
#  --show-task-ratio-json
#                        print json data of the locust classes' task execution
#                        ratio
#  -V, --version         show program's version number and exit

#Env vars for this script:
#MODE=[master|slave]

#Master mode vars:
#LOCUSTFILE=http URL
#HOST=host under test, like http://foohost note the absense of a trailing /

#Slave mode vars:
#MASTER_HOST=master host name
#LOCUSTFILE=http URL
set -eou pipefail

curl -o locustfile.py $LOCUSTFILE
echo "Using locustfile:"
echo
cat locustfile.py
case $MODE in
    master)
    locust --master --web-port=8080 --host=${HOST} --locustfile=/locustfile.py
    ;;
    slave)
    locust --slave --master-host=${MASTER_HOST} --locustfile=/locustfile.py
    ;;
    *)
    echo "Must set MODE to master or slave"
    exit 1
esac
