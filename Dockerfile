# Base image
FROM ubuntu:18.04

# Information
LABEL maintainer="FrozenFOXX <frozenfoxx@churchoffoxx.net>"

# Variables
ENV HOME=/root \
      APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
      DEBIAN_FRONTEND=noninteractive \
      DISPLAY=:0.0 \
      DISPLAY_WIDTH=1280 \
      DISPLAY_HEIGHT=720 \
      DOOMWADDIR='/wads' \
      FILES='' \
      LANG=en_US.UTF-8 \
      LANGUAGE=en_US.UTF-8 \
      LC_ALL=C.UTF-8

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      bash \
      git \
      gnupg \
      libglu1-mesa \
      libgtk2.0 \
      net-tools \
      socat \
      software-properties-common \
      supervisor \
      wget \
      x11vnc \
      xvfb

# Set up noVNC
RUN git clone https://github.com/novnc/noVNC.git /root/noVNC && \
  ln -s /root/noVNC/vnc_lite.html /root/noVNC/index.html

# Set up supervisor
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Modify the launch script 'ps -p'
RUN sed -i -- "s/ps -p/ps -o pid | grep/g" /root/noVNC/utils/launch.sh

# Set up Zandronum
RUN mkdir -p /root/.config/zandronum
COPY conf/zandronum.ini /root/.config/zandronum/
COPY scripts/* /tmp/
RUN /tmp/install_zandronum.sh

# Set up entrypoint
COPY bin/entrypoint.sh /usr/local/bin/entrypoint.sh

# Clean up unnecessary packages
RUN apt-get autoremove --purge -y \
  gnupg \
  wget

RUN rm -rf /var/lib/apt/lists/*
  
# Expose ports
EXPOSE 8080

# Launch processes
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
