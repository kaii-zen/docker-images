FROM buildpack-deps:trusty
MAINTAINER Shay Bergmann <sbergmann@benbria.ca>

ENV BUILD_DIR /usr/src/app/
RUN mkdir -p $HOME/.ssh $BUILD_DIR && chmod 700 $HOME/.ssh && ssh-keyscan -H github.com > $HOME/.ssh/known_hosts && \
    apt-get -qq update &&   \
    apt-get -qq install -y  \
    telnet                  \
    vim                     \
    dnsutils             && \
    apt-get clean        && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR $BUILD_DIR

COPY docker-ssh-exec dockerize run.sh /usr/local/bin/
