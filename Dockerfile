FROM alpine

RUN apk --no-cache git build-base

WORKDIR /opt
RUN git clone https://github.com/nim-lang/Nim.git --depth 1
WORKDIR /opt/Nim
COPY ./setup.sh .
RUN setup.sh
ENV PATH="/opt/Nim/bin:${PATH}"