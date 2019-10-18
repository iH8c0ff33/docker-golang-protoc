FROM golang:1.11-alpine

RUN apk add --no-cache git && \
    apk add --no-cache --virtual build-deps \
    git \
    unzip \
    autoconf \
    automake \
    libtool \
    alpine-sdk && \
    git clone https://github.com/google/protobuf.git && \
    cd protobuf && \
    ./autogen.sh && \
    ./configure && \
    make -j 4 && \
    make install && \
    ldconfig / && \
    make clean && \
    cd .. && \
    rm -r protobuf && \
    apk del build-deps

# NOTE: for now, this docker image always builds the current HEAD version of
# gRPC.  After gRPC's beta release, the Dockerfile versions will be updated to
# build a specific version.

# Get the source from GitHub
RUN go get google.golang.org/grpc
# Install protoc-gen-go
RUN go get github.com/golang/protobuf/protoc-gen-go
