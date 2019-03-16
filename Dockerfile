FROM frolvlad/alpine-glibc:latest

WORKDIR /

RUN apk add --no-cache \
    git \
    cmake \
    gdb \
    gcovr \
    cppcheck \
    doxygen graphviz \
    && apk --update --no-cache add --virtual build-dependencies \
    bzip2-dev \
    ca-certificates \
    openssl \
    tar \
    w3m \
    && wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 \
    && tar xvf gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 \
    && rm gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 \
    && apk del build-dependencies \
    && rm -rf /gcc-arm-none-eabi-8-2018-q4-major/share/doc

# Set up the compiler path
ENV PATH="/gcc-arm-none-eabi-8-2018-q4-major/bin:${PATH}"

WORKDIR /src

