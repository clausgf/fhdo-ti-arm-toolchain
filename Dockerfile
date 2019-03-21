FROM ubuntu:18.04

WORKDIR /

RUN apt-get update && apt-get install -y \
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
    && curl -SL http://releases.llvm.org/7.0.1/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-18.04.tar.xz \
    | tar -xJC . \
    && mv clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-18.04 clang_7.0.1 \
    && curl -SL https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 --output gcc-arm-none-eabi.tar.bz2 \
    && echo 'export PATH=/clang_7.0.1/bin:$PATH' >> ~/.bashrc \
    && echo 'export LD_LIBRARY_PATH=/clang_7.0.1/lib:$LD_LIBRARY_PATH' >> ~/.bashrc \
    && tar xvf gcc-arm-none-eabi.tar.bz2 \
    && rm -rf gcc-arm-none-eabi.tar.bz2 \
    && rm -rf /gcc-arm-none-eabi-8-2018-q4-major/share/doc \
    && echo 'export PATH=/gcc-arm-none-eabi-8-2018-q4-major/bin:$PATH' >> ~/.bashrc

# Set up the compiler path
ENV PATH="/gcc-arm-none-eabi-8-2018-q4-major/bin:${PATH}"

WORKDIR /src

