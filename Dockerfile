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
      PORT=8080

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y ${APP_DEPS} ${BUILD_DEPS}

# Set up supervisor
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Set up Zandronum
RUN mkdir -p /root/.config/zandronum && \
  mkdir -p ${DOOMWADDIR}
COPY conf/zandronum.ini /root/.config/zandronum/
COPY scripts/* /usr/local/bin/
COPY wads/* ${DOOMWADDIR}/
RUN /usr/local/bin/install_zandronum.sh

# Clean up unnecessary packages
RUN apt-get autoremove --purge -y ${BUILD_DEPS}
RUN rm -rf /var/lib/apt/lists/*
  
# Expose ports
EXPOSE ${PORT}

# Launch processes
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
