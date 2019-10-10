FROM python:alpine

RUN echo "**** install build packages ****" && \
    apk add --no-cache --virtual=build-dependencies \
      gcc \
      libc-dev \
      linux-headers \
      libxml2-dev \
      unzip

RUN echo "**** install runtime packages ****" && \
    apk add --no-cache \
      ffmpeg \
      libxslt-dev \
      git \
      curl

RUN echo "**** install pip dependencies ****" && \
    pip3 install --no-cache-dir \
      streamlink \
      lxml \
      requests \
      requests-cache \
      youtube_dl \
      mutagen

RUN echo "**** install rclone ****" && \
  mkdir -p /tmp/rclone && \
  curl \
    -o /tmp/rclone-current-linux-amd64.zip \
    -L https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
  unzip -j \
    /tmp/rclone-current-linux-amd64.zip \
    -d /tmp/rclone && \
  mv /tmp/rclone/rclone /usr/local/bin

RUN echo "**** cleanup ****" && \
    apk del --purge build-dependencies && \
    rm -rf /tmp/*

RUN echo "**** create user ****" && \
    addgroup -S app && \
    adduser -S app \
      -G app \
      -s /bin/bash \
      -h /home/app \
      -D -u 1000 && \
    chown -R app:app /home/app

USER app
WORKDIR /home/app
