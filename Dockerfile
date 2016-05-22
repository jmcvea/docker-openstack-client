FROM alpine:latest

MAINTAINER Jim McVea <jmcvea@gmail.com>

LABEL Description="Provides open whisk client tools" Version="0.1"

# Alpine-based installation
# #########################
RUN apk add --update \
  bash \
  python-dev \
  py-pip \
  py-setuptools \
  ca-certificates \
  gcc \
  musl-dev \
  linux-headers \
  && pip install --upgrade --no-cache-dir pip setuptools argcomplete https://new-console.ng.bluemix.net/openwhisk/cli/download \
  && apk del gcc musl-dev linux-headers \
  && rm -rf /var/cache/apk/*

# Add a volume so that a host filesystem can be mounted
# Ex. `docker run -v $PWD:/data jmcvea/whisk-client`
VOLUME ["/data"]

WORKDIR /data

# Add a script to set up the whisk environment based on environment variable
# which should be passed in via the `docker run` command
COPY configWhisk.sh /usr/local/bin/configWhisk.sh
# RUN chmod +x /root/configWhisk.sh

ENTRYPOINT ["/usr/local/bin/configWhisk.sh"]

# Default is to start a shell.  A more common behavior would be to override
# the command when starting.
# Ex. `docker run -ti jmcvea/whisk-client wsk`
# CMD ["/bin/bash"]

# CMD /bin/bash -C '/usr/local/bin/configWhisk.sh'; '/bin/bash'
