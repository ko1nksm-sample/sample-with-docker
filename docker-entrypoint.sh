#!/bin/sh

service mysql start > /tmp/mysql.log &

exec "$@"
