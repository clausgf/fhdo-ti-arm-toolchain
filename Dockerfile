FROM ubuntu:18.04
ENV TZ=Europe/Berlin
ENV PATH="/gcc-arm-none-eabi-8-2018-q4-major/bin:${PATH}"

ADD fhdo-hw1-ca.pem /
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true ; \
    apt-get update && apt-get install -y \
    tzdata \
    build-essential \
    git \
    cmake \
    xz-utils \
    bzip2 \
    curl \
    cppcheck python-pygments \
    gcovr \
    doxygen graphviz mscgen plantuml \
    && rm -rf /var/lib/apt/lists/* \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && cp /fhdo-hw1-ca.pem /usr/local/share/ca-certificates/fhdo-hw1-ca.crt \
    && update-ca-certificates \
    && curl -SL https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 --output gcc-arm-none-eabi.tar.bz2 \
    && tar xf gcc-arm-none-eabi.tar.bz2 \
    && rm -rf gcc-arm-none-eabi.tar.bz2 \
    && rm -rf /gcc-arm-none-eabi-7-2018-q2-update/share/doc \
    && echo 'export PATH=/gcc-arm-none-eabi-7-2018-q2-update/bin:$PATH' >> ~/.bashrc \
    && curl -SL https://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz | tar -xJC . \
    && mv clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04 clang \
    && echo 'export PATH=/clang/bin:$PATH' >> ~/.bashrc \
    && echo 'export LD_LIBRARY_PATH=/clang/lib:$LD_LIBRARY_PATH' >> ~/.bashrc \
    && echo nameserver 172.22.1.10 >> /etc/resolv.conf

WORKDIR /src

