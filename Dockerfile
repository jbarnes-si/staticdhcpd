FROM python:3.9.20-slim-bullseye

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -q -y update \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install apt-utils \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install nano net-tools \
 && apt-get -q -y autoremove \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /src
COPY . /src

RUN cd /src && ./install.sh

# Configuration
COPY staticDHCPd/conf/conf.py.docker /etc/staticDHCPd/conf.py

ENTRYPOINT ["staticDHCPd"]
