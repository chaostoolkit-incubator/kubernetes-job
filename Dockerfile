FROM python:3.7-alpine

LABEL maintainer="chaostoolkit <contact@chaostoolkit.org>"

ADD requirements.txt requirements.txt
RUN apk update && \
    apk add --virtual build-deps libffi-dev openssl-dev gcc python3-dev musl-dev && \
    apk add tzdata git tar && \
    echo "Europe/London" >  /etc/timezone && \
    pip install --no-cache-dir -U pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del build-deps && \
    rm -rf /tmp/* /root/.cache

VOLUME ["/var/log/chaostoolkit"]

ENTRYPOINT ["/usr/local/bin/chaos"]
CMD ["--help"]