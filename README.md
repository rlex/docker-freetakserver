Docker image for [FreeTakServer](https://github.com/tapawingo/freetakserver)  
Since FTS is heavy work in progress project, there might be bugs, but generally image should be working.  
FTS exposes ports 8080 and 8087.  
If you are behind NAT, you need to specify DATAPACKAGE_SERVER_IP variable (use your public-facing IP, or internal VPN ip, or even domain name - depending on your setup) for datapackages to work:

```
docker run -e DATAPACKAGE_SERVER_IP='1.2.3.4' rlex/freetakserver:latest
```

Image is built and pushed to dockerhub and github packages. If you want to pull from github, use docker login to github and

```
docker run -e DATAPACKAGE_SERVER_IP='1.2.3.4' docker.pkg.github.com/rlex/docker-freetakserver/freetakserver:latest
```

If you're running k8s, you can use [helm chart](https://github.com/rlex/helm-charts/tree/master/charts/freetakserver) which uses this image.