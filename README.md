_Archived, unmaintained, please use official [FreeTakServer image](https://github.com/FreeTAKTeam/FreeTAKServer-Docker) instead_

Docker image for [FreeTakServer](https://github.com/tapawingo/freetakserver)  
Since FTS is heavy work in progress project, there might be bugs, but generally image should be working.  
FTS exposes ports 8080 and 8087.  
If you are behind NAT, you need to specify -DataPackageIP variable in FTS_ARGS (use your public-facing IP, or internal VPN ip, or even domain name - depending on your setup) for datapackages to work:

```
docker run -e FTS_ARGS='-DataPackageIP 1.2.3.4' rlex/freetakserver:latest
```

Image is built and pushed to dockerhub and github packages. If you want to pull from github, use docker login to github and

```
docker run -e FTS_ARGS='-DataPackageIP 1.2.3.4' docker.pkg.github.com/rlex/docker-freetakserver/freetakserver:latest
```

Possible arguments for FTS in this docker image:
```
-CoTIP COTIP
-DataPackageIP DATAPACKAGEIP
-RestAPIIP RESTAPIIP
-AutoStart AUTOSTART
```

There is also port-changing args such as
```
-RestAPIPort RESTAPIPORT
-DataPackagePort DATAPACKAGEPORT
-CoTPort COTPORT
```
However due to hard-coded ports in docker image you shouldn't use them.

If you're running k8s, you can use [helm chart](https://github.com/rlex/helm-charts/tree/master/charts/freetakserver) which uses this image.
