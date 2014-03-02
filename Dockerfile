# Redis (unstable) Docker
#
# Version 0.01

# use ubuntu base image
# FROM ubuntu
FROM  stackbrew/ubuntu:13.10

MAINTAINER Amit Mor amit.mor@hotmail.com


# update
RUN apt-get update -y

# Install git
RUN apt-get install -y git


# Upgrade your gcc to version at least 4.7 to get C++11 support.
RUN apt-get install -y build-essential checkinstall libjemalloc-dev libgflags-dev libsnappy-dev zlib1g-dev libbz2-dev


# Clone redis and build
RUN cd ~ && git clone https://github.com/antirez/redis && cd redis && make clean && make


# Create a redis user, and switch to it
RUN /usr/sbin/useradd --create-home --home-dir /usr/local/redis --shell /bin/bash redis
RUN mkdir /usr/local/redis/redis-src && cp -r ~/redis/* /usr/local/redis/redis-src 
RUN /usr/sbin/adduser redis sudo
RUN chown -R redis /usr/local/
RUN chown -R redis /usr/lib/
RUN chown -R redis /usr/bin/


# Run Redis Server

RUN sed -ie "s/^daemonize no$/daemonize yes/" /usr/local/redis/redis-src/redis.conf
RUN sysctl vm.overcommit_memory=1
ENTRYPOINT ["/usr/local/redis/redis-src/src/redis-server"]
USER redis
EXPOSE 6379

