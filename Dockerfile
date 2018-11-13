FROM ubuntu:18.04

RUN apt-get -y update && \
        apt-get install -y git vim parted \
        quilt coreutils qemu-user-static debootstrap zerofree pxz zip dosfstools \
        bsdtar libcap2-bin rsync grep udev curl xz-utils swig device-tree-compiler \
        make cmake bison flex bc libssl-dev u-boot-tools python python-dev \
        locales kmod fakeroot

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

COPY . /neutis-debian/

VOLUME [ "/neutis-debian/work", "/neutis-debian/deploy"]
