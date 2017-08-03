#!/bin/sh
set -e

redis-server --port 16379 --daemonize yes
redis-server --port 16380 --slaveof 127.0.0.1 16379 --daemonize yes
redis-server --port 16381 --slaveof 127.0.0.1 16379 --daemonize yes

redis-server /sentinel.conf --sentinel --daemonize yes
redis-server /sentinel.conf --sentinel --port 26380 --daemonize yes
redis-server /sentinel.conf --sentinel --port 26381
