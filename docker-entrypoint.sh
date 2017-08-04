#!/bin/sh
set -e

cp /sentinel.conf /sentinel_1.conf
cp /sentinel.conf /sentinel_2.conf
cp /sentinel.conf /sentinel_3.conf

redis-server --port 16379 --daemonize yes
if [ $? -eq 0 ]; then
	echo "MASTER  \t PORT: 16379"
    redis-server --port 16380 --slaveof 127.0.0.1 16379 --daemonize yes
	if [ $? -eq 0 ]; then
		echo "SLAVE  \t PORT: 16380"
	    redis-server --port 16381 --slaveof 127.0.0.1 16379 --daemonize yes
		if [ $? -eq 0 ]; then
		    echo "SLAVE  \t PORT: 16381"
		    redis-server /sentinel_1.conf --sentinel --daemonize yes
		    if [ $? -eq 0 ]; then
			    echo "SENTINEL  \t PORT: 26379"
			    redis-server /sentinel_2.conf --sentinel --port 26380 --daemonize yes
			    if [ $? -eq 0 ]; then
				    echo "SENTINEL  \t PORT: 26380"
				    echo "SENTINEL  \t PORT: 26381"
				    redis-server /sentinel_3.conf --sentinel --port 26381
				else
				    echo "Failed to start redis sentinel at port 26381"
				fi
			else
			    echo "Failed to start redis sentinel at port 26380"
			fi
		else
		    echo "Failed to start redis slave at port 16380"
		fi
	else
	    echo "Failed to start redis slave at port 16379"
	fi
else
    echo "Failed to start redis master"
fi
