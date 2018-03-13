FROM python:3.5-alpine

LABEL maintainer="chaostoolkit <contact@chaostoolkit.org>"

RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk --no-cache --update-cache add gcc gfortran python python-dev py-pip build-base
RUN pip install --no-cache-dir chaostoolkit chaostoolkit-kubernetes

ENTRYPOINT ["/usr/local/bin/chaos"]
CMD ["--help"]