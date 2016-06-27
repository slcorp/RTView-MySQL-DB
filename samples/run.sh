#!/bin/sh

# Script to launch mysql-server container configured for use by RTView
# This script augments the default entrypoint.sh script provided
# in the docker hub version of mysql-server, in order to add features

# Set RTVHISTORY as MYSQL database if database not given in env
if [ "$MYSQL_DATABASE" = "" ]
then
    echo ... setting default database: RTVHISTORY
    export MYSQL_DATABASE=RTVHISTORY
fi

# Set default password if not given in env
if [ "$MYSQL_ROOT_PASSWORD" = "" ]
then	
    echo ... setting default root password: my-secret-pw
    export MYSQL_ROOT_PASSWORD=my-secret-pw
fi

# Set ANSI_QUOTES as default sql mode
# launch mysqld using "entrypoint" script, with any additional arguments passed in
echo ... launching MYSQL with $*
/entrypoint.sh mysqld --sql-mode='ANSI_QUOTES' $*
