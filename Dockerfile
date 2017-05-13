FROM alpine:3.5
MAINTAINER Stewart Park <hello@stewartjpark.com>
RUN apk update && apk add python3 ruby gcc nodejs bash
