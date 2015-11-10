FROM ahri/java:0.0.2

ENV LOGSTASH_VERSION 2.0.0

RUN su -s /bin/sh -c "cd /tmp && wget -O - http://download.elastic.co/logstash/logstash/logstash-$LOGSTASH_VERSION.tar.gz | tar xz" daemon && \
        mv /tmp/logstash-$LOGSTASH_VERSION /logstash && \
        apk add --update bash && \
        rm -rf /var/cache/apk/*

EXPOSE 12201/udp

USER nobody
ENTRYPOINT ["/logstash/bin/logstash", "agent"]
CMD ["-e", "input { gelf {} } output { stdout {} }"]
