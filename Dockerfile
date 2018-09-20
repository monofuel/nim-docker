FROM alpine

RUN apk add --no-cache git build-base gc

WORKDIR /opt
RUN git clone https://github.com/nim-lang/Nim.git --depth 1
WORKDIR /opt/Nim
COPY ./setup.sh .
RUN setup.sh
ENV PATH="/opt/Nim/bin:${PATH}"