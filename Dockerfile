FROM python:3.8.3-alpine
LABEL maintainer "rlex"

ENV PYTHONUNBUFFERED 1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_NO_CACHE_DIR=1
ARG FREETAKSERVER_VERSION=0.8.23
RUN apk add --no-cache -U libxslt libxml2 && \
  apk add libxslt-dev libxml2-dev build-base && \
  pip install FreeTAKServer==${FREETAKSERVER_VERSION} && \
  apk del libxslt-dev libxml2-dev build-base
RUN addgroup -g 1000 freetakserver \
  && adduser -Ss /bin/false -u 1000 -G freetakserver -h /home/freetakserver freetakserver \
  && mkdir -m 777 /data \
  && chown freetakserver:freetakserver /data /home/freetakserver

# Since we do not have config file (yet) we need to patch distribution files so it points to /data
RUN sed -i s=FreeTAKServerDataPackageDataBase.db=/data/FreeTAKServerDataPackageDataBase.db=g /usr/local/lib/python3.8/site-packages/FreeTAKServer/controllers/configuration/DataPackageServerConstants.py && \
  sed -i s=FreeTAKServerDataPackageFolder=/data/FreeTAKServerDataPackageFolder=g /usr/local/lib/python3.8/site-packages/FreeTAKServer/controllers/configuration/DataPackageServerConstants.py && \
  sed -i s='logs'='/data/logs'=g /usr/local/lib/python3.8/site-packages/FreeTAKServer/controllers/configuration/LoggingConstants.py

EXPOSE 8087 8080
VOLUME ["/data"]
USER freetakserver
WORKDIR /data
ENTRYPOINT ["python", "-m", "FreeTAKServer.controllers.Orchestrator"]
