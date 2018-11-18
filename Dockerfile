FROM node:8-alpine
LABEL maintainer="Danilo Arcidiacono <danilo.arcidiacono@gmail.com>"

WORKDIR /root

# Alpine distribution has its own package repository
# See here: https://pkgs.alpinelinux.org/packages?branch=v3.8
ENV JAVA_ALPINE_VERSION="8.181.13-r0"
ENV GIT_ALPINE_VERSION="2.18.1-r0"
ENV MAVEN_ALPINE_VERSION="3.5.4-r1"
ENV GNUPG_ALPINE_VERSION="2.2.8-r0"

# The --no-cache option allows to not cache the index locally, which is useful for keeping containers small.
RUN apk upgrade --update && \
    apk add --no-cache man man-pages curl bash && \
    apk add --no-cache openjdk8="$JAVA_ALPINE_VERSION" && \
    apk add --no-cache git="$GIT_ALPINE_VERSION" && \
    apk add --no-cache maven="$MAVEN_ALPINE_VERSION" && \
    apk add --no-cache gnupg="$GNUPG_ALPINE_VERSION"

# Install Github's hub tool
RUN curl -sL https://github.com/github/hub/releases/download/v2.6.0/hub-linux-386-2.6.0.tgz | tar xz && \
    cd hub-linux-386-2.6.0 && \
    ./install && \
    cd ~ && \
    rm -rf hub-linux-386-2.6.0

# Configure environment variables
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:$JAVA_HOME/bin
ENV MANPATH $MANPATH:/usr/local/share/man