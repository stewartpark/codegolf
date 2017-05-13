FROM alpine:3.5
MAINTAINER Stewart Park <hello@stewartjpark.com>
RUN apk update && apk add python3 ruby gcc libc-dev nodejs bash coreutils
RUN printf "#!/bin/sh\ngcc \$1 -o /tmp/a.out && /tmp/a.out" > /bin/run_c && chmod +x /bin/run_c
