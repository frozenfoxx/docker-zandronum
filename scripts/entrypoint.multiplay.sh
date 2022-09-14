#!/usr/bin/env bash

# Variables
DISPLAY_HEIGHT=${DISPLAY_HEIGHT:-'1280'}
DISPLAY_WIDTH=${DISPLAY_WIDTH:-'720'}
PARAMS=''
PORT=${PORT:-'8080'}

# Functions

## Build config files
build_configs()
{
  export DISPLAY_HEIGHT
  export DISPLAY_WIDTH
  export PORT

  envsubst < /home/mpukgame/.config/zandronum/zandronum.ini.tmpl > /home/mpukgame/.config/zandronum/zandronum.ini
  envsubst < /etc/supervisor/conf.d/supervisord.conf.tmpl > /home/mpukgame/supervisord.conf
}

## Run supervisor
launch_supervisor()
{
  /usr/bin/supervisord -c /home/mpukgame/supervisord.conf &
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

## Check if PORT is overridden with vncport
while [[ "$1" != "" ]]; do
  case $1 in
    --vncport ) shift
                PORT=$1
                ;;
    * )         PARAMS="${PARAMS} $1"
  esac
  shift
done

build_configs
launch_supervisor
launch_zandronum
