# redis-sentinel-cluster

Dockerfile for [Redis Sentinel](http://redis.io/topics/sentinel). Image is available directly from [public docker registry](https://hub.docker.com/r/integration1taskworld/redis-sentinel-cluster/).

## Redis Sentinel

Redis Sentinel provides high availability for Redis. In practical terms this means that using Sentinel you can create a Redis deployment that resists without human intervention to certain kind of failures.
Additionally also provides other collateral tasks such as monitoring, notifications and acts as a configuration provider for clients. Detailed info can be found in the [official documentation](http://redis.io/documentation).

## Demo

For demonstration purposes you use the following command:

```sh
docker-compose up -d
```
It will fire a total of 6 redis instances with following configuration:

| Node|Count|Ports|
|---|:---:|---|
|MASTER|1|16379|
|SLAVE|2|16380, 16381|
|SENTINEL|3|26379, 26380, 26381|

|Master Name|
|:---:|
|mymaster|

To confirm that everything is working fine, you can check for ROLE of every node. Here is the sample output.

###### master:
```sh
$ redis-cli -p 16379 ROLE
1) "master"
2) (integer) 10669
3) 1) 1) "127.0.0.1"
      2) "16380"
      3) "10528"
   2) 1) "127.0.0.1"
      2) "16381"
      3) "10528"
```

###### slave 1:
```sh
$ redis-cli -p 16380 ROLE
 1) "slave"
 2) "127.0.0.1"
 3) (integer) 16379
 4) "connected"
 5) (integer) 12657
```

###### slave 2:
```sh
$ redis-cli -p 16381 ROLE
 1) "slave"
 2) "127.0.0.1"
 3) (integer) 16379
 4) "connected"
 5) (integer) 13221
```

###### sentinel 1:

```sh
$ redis-cli -p 26379 ROLE
  1) "sentinel"
  2) 1) "mymaster"
```

###### sentinel 2:

```sh
$ redis-cli -p 26380 ROLE
  1) "sentinel"
  2) 1) "mymaster"
```

###### sentinel 3:

```sh
$ redis-cli -p 26381 ROLE
  1) "sentinel"
  2) 1) "mymaster"
```

## How to use this image

```sh
$ docker run -d --name redis_sentinel_dev -p 16379:16379 -p 16380:16380 -p 16381:16381 -p 26379:26379 -p 26380:26380 -p 26381:26381 integration1taskworld/redis-sentinel-cluster
```

or the easier solution would be to run it using docker compose. Have a docker-compose.yml similar to one in this repo and run:

```sh
docker-compose up -d
```

and that is it.

## Environment Variables

No environment variables are supported at the moment. Everything is static and **only meant for development purposes***.
