FROM alpine:3.13.5

MAINTAINER Jim McVea <jmcvea@gmail.com>

LABEL Description="Provides openstack client tools" Version="0.1"

# Alpine-based installation
# #########################
RUN apk add --update \
  python3-dev \
  py-pip \
  ca-certificates \
  gcc \
  libffi-dev \
  openssl-dev \
  musl-dev \
  linux-headers \
  cargo \
  && pip install --upgrade --no-cache-dir pip setuptools
RUN pip install cryptography
RUN pip install python-openstackclient==5.2.1
#  && apk del gcc musl-dev linux-headers python-dev libffi-dev \
#  && rm -rf /var/cache/apk/*

# Add a volume so that a host filesystem can be mounted
# Ex. `docker run -v $PWD:/data jmcvea/openstack-client`
VOLUME ["/data"]

# Default is to start a shell.  A more common behavior would be to override
# the command when starting.
# Ex. `docker run -ti jmcvea/openstack-client openstack server list`
CMD ["/bin/sh"]

