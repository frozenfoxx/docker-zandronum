# docker-zandronum

[![Actions Status](https://github.com/frozenfoxx/docker-zandronum/workflows/build/badge.svg)](https://github.com/frozenfoxx/docker-zandronum/actions)

A [Docker](https://www.docker.com/) container that runs [Zandronum](https://zandronum.com/).

Docker Hub: [https://hub.docker.com/r/frozenfoxx/zandronum/](https://hub.docker.com/r/frozenfoxx/zandronum/)

# How to Build

To just build the default image, input the following:

```
git clone https://github.com/frozenfoxx/docker-zandronum.git
cd docker-zandronum
docker build -t frozenfoxx/zandronum:latest .
```

If you wish to build an alternate image, copy the alternate Dockerfile with the paramters to you wish to use to `Dockerfile` and issue the build command.

# How to Use this Image
## Quickstart

The following will run the latest Zandronum client with a default configuration.

```
docker run -it \
  --rm \
  -p 8080:8080 \
  -v /Path/To/WADs/:/wads:ro \
  --name=zandronum \
  frozenfoxx/zandronum:latest
```

Then open [http://localhost:8080/vnc_lite.html](http://localhost:8080/vnc_lite.html) in your browser.

## Adding Options

The entrypoint will pass all additional options to the Zandronum executable. To mount an additional WAD file, for instance:

```
docker run -it \
  --rm \
  -p 8080:8080 \
  -v /Path/To/WADs/:/wads:ro \
  -v /Path/To/Other/WADs:/tmp/other_wads:ro \
  --name=zandronum \
  frozenfoxx/zandronum:latest \
  /tmp/other_wads/savage.wad \
  +connect dm.zserver.net
```

# Configuration

## Controls

The default control scheme has been modified for easier use with noVNC. Since the mouse cannot be captured exclusively, keyboard is recommended.

* Fire: `Up Arrow`
* Forward: `W`
* Backward: `S`
* Strafe Left: `A`
* Strafe Right: `D`
* Turn Left: `Left Arrow`
* Turn Right: `Right Arrow`
* Use: `E`
* Jump: `Space`
* Crouch: `Control`

## Environment Variables

* `DISPLAY_HEIGHT`: allows modification of the virtual display's height.
* `DISPLAY_WIDTH`: allows modification of the virtual display's width.
* `PORT`: allows modification of the listening port for noVNC.
