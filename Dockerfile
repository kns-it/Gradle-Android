FROM knsit/gradle:4.9.0-jdk8-alpine

LABEL maintainer="sebastian.kurfer@kns-it.de"

ENV PATH=$PATH:/opt/android/tools/bin
ENV ANDROID_HOME=/opt/android

ARG GLIBC_VERSION=2.28-r0

USER root

RUN apk add --no-cache wget unzip ca-certificates && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget -q -O /tmp/glibc.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk && \
    wget -q -O /tmp/glibc-bin.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk && \
    apk add --no-cache /tmp/glibc.apk /tmp/glibc-bin.apk && \
    wget -q -O /tmp/sdk-tools-linux.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    mkdir -p /opt/android/sdk && \
    unzip /tmp/sdk-tools-linux.zip -d /opt/android && \
    rm -f /tmp/sdk-tools-linux.zip && \
    apk del wget unzip ca-certificates && \
    rm -rf /var/cache/apk/* && \
    yes | sdkmanager --licenses && \
    chown -R gradle:gradle /opt/android

USER gradle