FROM python:3.6-alpine

LABEL maintainer="chaostoolkit <contact@chaostoolkit.org>"

ADD requirements.txt requirements.txt
RUN apk update && \
    apk add --virtual build-deps gcc python3-dev musl-dev && \
    pip install -U pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del build-deps && \
    rm -rf /tmp/* /root/.cache

ENTRYPOINT ["/usr/local/bin/chaos"]
CMD ["--help"]