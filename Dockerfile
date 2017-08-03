FROM redis:3.2.3
MAINTAINER Taskworld Dev (Forked from https://github.com/yesuagg/redis-sentinel-cluster)

ADD docker-entrypoint.sh /
ADD sentinel.conf /
RUN chmod +x /docker-entrypoint.sh
RUN chmod +x /sentinel.conf

ENTRYPOINT ["/docker-entrypoint.sh"]
