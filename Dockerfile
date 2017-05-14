FROM alpine:edge
MAINTAINER Stewart Park <hello@stewartjpark.com>
RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN apk update && apk add python3 ruby gcc libc-dev nodejs bash coreutils rust@testing
RUN printf "#!/bin/sh\ngcc \$1 -o /tmp/a.out && /tmp/a.out" > /bin/run_c && chmod +x /bin/run_c
RUN printf "#!/bin/sh\nrustc \$1 -o /tmp/a.out && /tmp/a.out" > /bin/run_rs && chmod +x /bin/run_rs
