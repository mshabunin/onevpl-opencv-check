ARG UBUNTU_VER
FROM ubuntu:${UBUNTU_VER}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  git cmake ninja-build g++ python3 python3-numpy autotools-dev

RUN apt-get install -y \
  autoconf autoconf-archive gnu-standards libtool gettext

RUN apt-get install -y \
  libdrm-dev pkg-config
