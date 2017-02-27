FROM streamsets/datacollector:2.2.0.0
MAINTAINER Angel Alvarado "angel.angelio@gmail.com"
ARG ADD_LIBS
USER root
RUN apk add --no-cache python && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install pyyaml ua-parser user-agents && \
    rm -r /root/.cache
RUN if [ "$ADD_LIBS" != "" ]; then ${SDC_DIST}/bin/streamsets stagelibs -install=${ADD_LIBS}; fi
USER ${SDC_USER}
RUN wget http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz -P /tmp
RUN gunzip /tmp/GeoLite2-City.mmdb.gz
EXPOSE 18630
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["dc", "-exec"]
