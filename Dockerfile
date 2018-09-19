FROM alpine

RUN apk update
RUN apk add git
RUN apk add build-base

WORKDIR /opt
RUN git clone https://github.com/nim-lang/Nim.git --depth 1
WORKDIR /opt/Nim
RUN sh build_all.sh
RUN ./bin/nim c koch
RUN ./koch boot -d:release
RUN ./koch tools
ENV PATH="/opt/Nim/bin:${PATH}"