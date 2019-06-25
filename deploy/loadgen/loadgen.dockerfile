FROM williamyeh/wrk

ARG thread_count='100'
ARG connections='300'
ARG duration='4h'

ENV THREAD_COUNT=${thread_count}
ENV CONNECTIONS=${connections}
ENV DURATION=${duration}

ENTRYPOINT ["sh", "-c", "wrk -t$THREAD_COUNT -c$CONNECTIONS -d$DURATION $0"]
