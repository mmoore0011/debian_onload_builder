# onload-build

A container for building solarflare drivers from source

## Overview

Solarflare's OpenOnload needs to be built from source on whatever kernel you plan to run it on.  Solarflare
does not currently provide an way to do this for debian without installing gcc, make, module-assistant, and
a variety of other compiler-like tools and libraries on every system you plan to install the driver on.

This container can be used to build OpenOnload on a given system using the compilation tools installed
within the container instead of installing them directly on the host.  The compiled binaries can then be
packaged, shipped, and installed on any other systems running the same kernel.

## Using the image to build and install OpenOnload

** IMPORTANT, this must be done from either your target install system or another machine with the same kernel
and cpu type.

1. Edit the Dockerfile and change everything inside the "Versioning" section as needed for your environment

2. Build the image

```
docker build .
```

3.  Run the container, mounting a local directory for it to copy the compiled software to.  This needs to be mounted
as /mnt inside the container
```
docker run -v /tmp:/mnt [IMAGE]
```

4.  When the build is done, there will be a file named:
```
openonload-[ONLOAD VERSION]-kmod-[KERNEL VERSION].tgz
```
on the host in the directory you mounted in step 3.  Copy that file to the host you want to install onload on, unpack
it, and run:
```
cd scripts; onload_install --nobuild
``` 
