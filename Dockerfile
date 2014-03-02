# Redis (unstable) Docker
#
# Version 0.01

# use ubuntu base image
# FROM ubuntu
FROM  stackbrew/ubuntu:13.10

# update
RUN apt-get update -y

# Install git
RUN apt-get install -y git


# Upgrade your gcc to version at least 4.7 to get C++11 support.
RUN apt-get install -y build-essential checkinstall

# Install gflags
RUN apt-get install -y libgflags-dev

# Install snappy
RUN apt-get install -y libsnappy-dev

# Install zlib
RUN apt-get install -y zlib1g-dev

# Install bzip2
RUN apt-get install -y libbz2-dev

# Clone redis and build
RUN cd ~ && git clone https://github.com/antirez/redis && cd redis && make clean && make

# Run Redis Server
RUN cd ~/redis/src && ./redis-server 
