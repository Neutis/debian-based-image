# neutis-debian-based-image

Debian-based Linux images for [neutis-n5](https://neutis.io/)

## Overview
This build system is based on [pi-gen-navio](https://github.com/emlid/pi-gen-navio). Image assembly is divided up into several stages for logical clarity and modularity.

## Build
Hereinafter `$USER` environment variable is assumed to be your username.

1) Create a docker image.
```
user@host$ cd /path/to/neutis-debian-based-image
user@host$ docker build -t neutis-debian-based-image:$USER -f Dockerfile .
```
2) Create and connect to docker container.
```
user@host$ docker create -t -i --privileged neutis-debian-based-image:$USER bash
docker_container_id
user@host$ docker start -a -i docker_container_id
```
3) Create config file.
```
root@container$ cd neutis-debian-based-image
root@container$ printf "IMG_NAME='Xenial'
SKIP_STAGES=''
EXPORT_STAGES='1:-bootable 2:-server 3:-desktop'
CPU_CORES='16'" > config
```
4) Run build.
```
root@container$ ./build.sh
```
5) If everything runs correctly your image will be in `deploy`. Now you can copy it:
```
user@host$ docker cp <containerId>:neutis-debian-based-image/work/buildname/deploy/image /host/path/target
```
6) Resuming old build.
- Add stages that you don't want to run again to `SKIP_STAGES` section of `config` file.
- Run `./build.sh`.

## Config

Upon execution, `build.sh` will source the file `config` in the current
working directory.  This bash shell fragment is intended to set needed
environment variables.

The following environment variables are supported:

 * `IMG_NAME` (Default: `neutis-n5-xenial`)

   The name of the image to build with the current stage directories.

* `SKIP_STAGES`  (Default: unset)

   Suffixes of stages which you wish not to execute. Setting
   `SKIP_STAGES="1 2:00 4"` will result skip `stage1`, `stage2/00-substage`
   and `stage4` during the build.

* `EXPORT_STAGES`  (Default: unset)

   Suffixes of stages on which you wish to export the image. Setting
   `EXPORT_STAGES="1:-bootable 3:-desktop"` will result to produce
   images on `stage1` and `stage3`. Image file names will
   be supplemented by `-bootable` and `-desktop` accordingly.

* `CPU_CORES` (Default: 1)

   Number of parallel jobs for sources compiling.


A simple `config` example for building Xenial:

```bash
IMG_NAME='Xenial'
SKIP_STAGES=''
EXPORT_STAGES='1:-bootable 2:-server 3:-desktop'
CPU_CORES='16'
```

## Stage anatomy overview
 - **Stage 0** - bootstrap.  The primary purpose of this stage is to create a
   usable filesystem.  This is accomplished largely through the use of
   `debootstrap`, which creates a minimal filesystem suitable for use as a
   base.tgz on Debian systems. The minimal core is installed but not configured,
   and the system will not quite boot yet.

 - **Stage 1** - compile dependencies. At this stage, important dependencies are
   collected for the future image, such as Linux, u-boot etc.
   This stage makes the system bootable, configures the bootloader, makes
   the network operable. At this stage the system should boot to a local
   console from which you have the means to perform basic tasks needed to
   configure and install the system.
   This is as minimal as a system can possibly get, and its arguably not
   really usable yet in a traditional sense yet.  Still, if you want minimal,
   this is minimal and the rest you could reasonably do yourself as sysadmin.

 - **Stage 2** - This stage produces server image. It installs
   some development tools, adds wifi and bluetooth support and other basics for
   the hardware managing.

 - **Stage 3** - Here's where you get the desktop system with xfce4.
