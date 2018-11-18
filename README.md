# neutis-debian-based-image

_Tool used to create the debian-based images for [neutis-n5](https://neutis.io/)_


## Dependencies

- docker

## Config

Upon execution, `build.sh` will source the file `config` in the current
working directory.  This bash shell fragment is intended to set needed
environment variables.

The following environment variables are supported:

 * `IMG_NAME` **required** (Default: unset)

   The name of the image to build with the current stage directories.

 * `APT_PROXY` (Default: unset)

   If you require the use of an apt proxy, set it here.  This proxy setting
   will not be included in the image, making it safe to use an `apt-cacher` or
   similar package for development.

   You can set up a local apt caching proxy to like speed up subsequent builds
   like this:

       docker-compose up -d
       echo 'APT_PROXY=http://172.17.0.1:3142' >> config

 * `BASE_DIR`  (Default: location of `build.sh`)

   **CAUTION**: Currently, changing this value will probably break build.sh

   Top-level directory for `pi-gen`.  Contains stage directories, build
   scripts, and by default both work and deployment directories.

 * `WORK_DIR`  (Default: `"$BASE_DIR/work"`)

   Directory in which `neutis-debian-based-image` builds the target system.  
   This value can be changed if you have a suitably large, fast storage location
   for stages to be built and cached.  Note, `WORK_DIR` stores a complete copy
   of the target system for each build stage.

 * `DEPLOY_DIR`  (Default: `"$BASE_DIR/deploy"`)

   Output directory for target system images.

* `SKIP_STAGES`  (Default: unset)

   Postfixes of stages which you wish not to execute. Setting
   `SKIP_STAGES="1 2:00 4"` will result skip `stage1`, `stage2/00-substage`
   and `stage4` during the build.

* `RM_STAGE_EXPORTS_POSTFIXES`  (Default: unset)

   Postfixes of stages on which you wish not to export the image in. Setting
   `RM_STAGE_EXPORTS_POSTFIXES="4"` will result to skip `stage4` image export.

* `CPU_CORES` (Default: 1)

   Number of parallel jobs for sources compiling.


A simple example for building Xenial:

```bash
IMG_NAME='Xenial'
SKIP_STAGES="4"  
RM_STAGE_EXPORTS_POSTFIXES="4"
CPU_CORES="16"
```


## Docker Build
#### Build an image
1) create a docker image
```
cd /path/to/neutis-debian-based-image
docker build -t neutis-debian-based-image:$USER -f Dockerfile .
```
2) create & connect to docker container
```
docker start -a -i `docker create -t -i --privileged neutis-debian-based-image:$USER bash`
```
**Hint**: to set up a custom location for docker storage use `-g` option.

3) create config file
```
cd neutis-debian-based-image
printf "IMG_NAME='Xenial'
SKIP_STAGES='4'
RM_STAGE_EXPORTS_POSTFIXES='4'
CPU_CORES='16'" > config
```
4) run build
```
dpkg-reconfigure qemu-user-static
./build.sh
```
5) If everything runs correctly your image will be in `deploy`. Now you can copy it, from your host system execute:
```
docker cp <containerId>:neutis-debian-based-image/work/buildname/deploy/image /host/path/target
```
6) Clean-up hints:
- To get list of docker containers use `docker ps -a`, to remove docker container use `docker rm <container_id>``.
- To get list of docker images use `docker images -a`, to remove docker image use `docker rmi <image_id>`.

There is a possibility that even when running from a docker container, the
installation of `qemu-user-static` will silently fail when building the image
because `binfmt-support` _must be enabled on the underlying kernel_. An easy
fix is to ensure `binfmt-support` is installed on the host machine before
starting the `./build-docker.sh` script (or using your own docker build
solution).

#### Resuming old build
In case of any error build process will be stopped:
- Add stages that you don't want to run again to `SKIP_STAGES` section of `config` file.
- Run `./build.sh`.

## Stage Anatomy

### Overview
The neutis-debian-based-image build system is based on [pi-gen-navio](https://github.com/emlid/pi-gen-navio) and uses scripts and
stage structure from it. The build is divided up into several stages for logical
clarity and modularity. This causes some initial complexity, but it simplifies
maintenance and allows for more easy customization.


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

 - **Stage 2** - lite system. This stage produces lite image.  It
   installs wifi and bluetooth support and other basics for managing the
   hardware. There are a few tools that may not make a whole lot of sense here for
   development purposes on a minimal system such as basic Python and vim.
   If you were looking for something between truly minimal and lite image,
   here's where you start trimming.

 - **Stage 3** - More development tools. This is the
   stage that installs all of the things that makes image easy to use
   for development.

 - **Stage 4** - desktop system.  Here's where you get the full desktop system
   with X11 and ubuntu-desktop, etc. This is a base desktop system,
   with some development tools installed.
