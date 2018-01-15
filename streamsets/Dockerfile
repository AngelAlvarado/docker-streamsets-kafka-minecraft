FROM streamsets/datacollector:3.0.1.0
LABEL MAINTAINER Angel Alvarado "angel.angelio@gmail.com"
USER root
RUN apk add --no-cache python && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install pyyaml ua-parser user-agents && \
    rm -r /root/.cache
RUN if [ "$ADD_LIBS" != "" ]; then ${SDC_DIST}/bin/streamsets stagelibs -install=${ADD_LIBS}; fi
USER ${SDC_USER}
RUN curl -o /tmp/GeoLite2-City.tar.gz http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz
RUN gunzip /tmp/GeoLite2-City.tar.gz
RUN tar -C /tmp -xvf /tmp/GeoLite2-City.tar
RUN mv /tmp/GeoLite2-City_* /tmp/GeoLite2-City
EXPOSE 18630
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["dc", "-exec"]
