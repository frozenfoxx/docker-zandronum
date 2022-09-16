#!/usr/bin/env bash

# Variables
DISPLAY=${DISPLAY:-'0'}
DISPLAY_HEIGHT=${DISPLAY_HEIGHT:-'1280'}
DISPLAY_WIDTH=${DISPLAY_WIDTH:-'720'}
HOME=$(eval echo ~$(whoami))
NOVNCPORT=${NOVNCPORT:-'8080'}
PARAMS=''
RFBPORT=${RFBPORT:-'5900'}

# Functions

## Build config files
build_configs()
{
  # Create local Zandornum config directory
  mkdir -p ${HOME}/.config/zandronum

  export DISPLAY_PORT
  export DISPLAY_HEIGHT
  export DISPLAY_WIDTH
  export NOVNC_PORT
  export RFB_PORT

  envsubst < /usr/local/etc/zandronum.ini.tmpl > ${HOME}/.config/zandronum/zandronum.ini
  envsubst < /usr/local/etc/supervisord.conf.tmpl > ${HOME}/supervisord.conf
}

## Configure ports
config_ports()
{
  # For Multiplay you cannot presently specifc different ports, so increment to avoid collisions
  if [[ ${NOVNCPORT} -eq ${RFBPORT} ]]; then
    RFBPORT=$((${NOVNCPORT} + 1))
  fi
}

## Run supervisor
launch_supervisor()
{
  /usr/bin/supervisord -c ${HOME}/supervisord.conf &
}

## Launch Zandronum
launch_zandronum()
{
  ## Wait until X11 is up
  until pids=$(pidof Xvfb)
  do   
    sleep 1
  done

  ## Execute Zandronum
  zandronum ${PARAMS}
}

# Logic

## Check for overridden variables
while [[ "$1" != "" ]]; do
  case $1 in
    --displayport ) shift
                    DISPLAY_PORT=$1
                    ;;
    --novncport )   shift
                    NOVNC_PORT=$1
                    ;;
    --rfbport )     shift
                    RFB_PORT=$1
                    ;;
    * )             PARAMS="${PARAMS} $1"
                    ;;
  esac
  shift
done

config_ports
build_configs
launch_supervisor
launch_zandronum
