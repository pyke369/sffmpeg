FROM alpine:latest
RUN apk add --no-cache build-base cmake autoconf libtool pkgconf git mercurial file linux-headers
COPY . /sffmpeg
WORKDIR /sffmpeg
RUN ls -R && make