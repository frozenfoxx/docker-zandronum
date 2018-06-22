# docker-zandronum
A Docker container that runs Zandronum.

Docker Hub: [https://hub.docker.com/r/frozenfoxx/zandronum/](https://hub.docker.com/r/frozenfoxx/zandronum/)

# How to Build
```
git clone git@github.com:frozenfoxx/docker-zandronum.git
cd docker-zandronum
docker build .
```

# How to Use this Image
## Quickstart
The following will run the latest Zandronum client with a default configuration.

```
docker run -d --rm -p 8080:80 --name=zandronum frozenfoxx/zandronum:latest
```
