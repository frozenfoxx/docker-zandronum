# Base image
FROM ubuntu:22.04

# Information
LABEL maintainer="FrozenFOXX <frozenfoxx@churchoffoxx.net>"

# Variables
ENV HOME=/root \
  APP_DEPS=" \
    libglu1-mesa \
    libgtk2.0 \
    net-tools \
    supervisor \
    novnc \
    websockify \
    x11vnc \
    xvfb " \
  APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
  BUILD_DEPS=" \
    git \
    gnupg \
    software-properties-common \
    wget" \
  DEBIAN_FRONTEND=noninteractive \
  DISPLAY=:0.0 \
  DISPLAY_WIDTH=1280 \
  DISPLAY_HEIGHT=720 \
  DOOMWADDIR='/wads' \
  FILES='' \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8 \
  LC_ALL=C.UTF-8 \
  NOVNCPORT=8080 \
  RFBPORT=5900

# Install packages
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y ${APP_DEPS} ${BUILD_DEPS}

# Copy files
RUN mkdir -p /usr/local/etc && \
  mkdir -p ${DOOMWADDIR}
COPY conf/* /usr/local/etc/
COPY scripts/* /usr/local/bin/
COPY wads/* ${DOOMWADDIR}/

# Set up Zandronum
RUN /usr/local/bin/install_zandronum.sh

# Clean up unnecessary packages
RUN apt-get autoremove --purge -y ${BUILD_DEPS}
RUN rm -rf /var/lib/apt/lists/*
  
# Expose ports
EXPOSE ${NOVNCPORT}

# Launch processes
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
