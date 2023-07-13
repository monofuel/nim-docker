FROM alpine

RUN apk add --no-cache git build-base gc

# install nim and perform cleanup in one layer
COPY ./setup.sh /root/
RUN sh /root/setup.sh
ENV PATH="/root/.nimble/bin:${PATH}"