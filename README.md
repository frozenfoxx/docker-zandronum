# docker-zandronum
A Docker container that runs [Zandronum](https://zandronum.com/).

Docker Hub: [https://hub.docker.com/r/frozenfoxx/zandronum/](https://hub.docker.com/r/frozenfoxx/zandronum/)

# How to Build

To just build the default image, input the following:

```
git clone git@github.com:frozenfoxx/docker-zandronum.git
cd docker-zandronum
docker build -t frozenfoxx/zandronum:latest .
```

If you wish to build an alternate image, copy the alternate Dockerfile with the paramters to you wish to use to `Dockerfile` and issue the build command.

# How to Use this Image
## Quickstart

The following will run the latest Zandronum client with a default configuration.

```
docker run -it --rm -p 8080:8080 -v /Path/To/WADs/:/wads --name=zandronum frozenfoxx/zandronum:latest
```

Then open `http://localhost:8080` in your browser.
