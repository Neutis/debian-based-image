FROM debian:stretch

RUN apt-get -y update && \
    apt-get -y install \
        git vim parted \
        quilt realpath qemu-user-static debootstrap zerofree pxz zip dosfstools \
        bsdtar libcap2-bin rsync grep udev curl xz-utils swig device-tree-compiler \
        make cmake bison flex bc libssl-dev u-boot-tools python python-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . /neutis-debian/

VOLUME [ "/neutis-debian/work", "/neutis-debian/deploy"]
