# Base image
FROM ubuntu:18.04

# Information
LABEL maintainer="FrozenFOXX <frozenfoxx@churchoffoxx.net>"

# Variables
ENV HOME=/root \
	DEBIAN_FRONTEND=noninteractive \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
	DISPLAY=:0.0 \
	DISPLAY_WIDTH=1366 \
	DISPLAY_HEIGHT=768

# Install packages
RUN apt update && \
    apt install -y \
	bash \
	fluxbox \
	git \
	net-tools \
	socat \
	supervisor \
    x11vnc \
	xterm \
	xvfb && \
    rm -rf /var/lib/apt/lists/*

# Clone noVNC from github
RUN git clone https://github.com/novnc/noVNC.git /root/noVNC

# Set up supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Modify the launch script 'ps -p'
RUN sed -i -- "s/ps -p/ps -o pid | grep/g" /root/noVNC/utils/launch.sh

# Expose ports
EXPOSE 8080

# Run subprocesses under supervisor
CMD ["/usr/bin/supervisord"]