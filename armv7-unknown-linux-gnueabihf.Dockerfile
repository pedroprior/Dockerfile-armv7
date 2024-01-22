FROM debian:buster

RUN dpkg --add-architecture armhf && \ 
    apt-get update && \
    apt-get install --assume-yes \
    curl \
    build-essential \
    cmake \
    g++-arm-linux-gnueabihf \
    git \
    pkg-config \
    libdbus-1-dev:armhf \
    libudev-dev:armhf \
    libxkbcommon-dev:armhf \
    libfontconfig1-dev:armhf 

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    --default-toolchain stable \
    --no-modify-path \
    --profile minimal

ENV RUSTUP_HOME=/root/.rustup \
    CARGO_HOME=/root/.cargo \
    PATH=/root/.cargo/bin:$PATH \
    PKG_CONFIG_ALLOW_CROSS=1 \
    PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig \
    CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_LINKER=arm-linux-gnueabihf-gcc \
    CC_armv7_unknown_linux_gnueabihf=arm-linux-gnueabihf-gcc \
    RUST_TEST_THREADS=1    

RUN rustup target add armv7-unknown-linux-gnueabihf