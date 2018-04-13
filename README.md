# Dockerfile for building the relayr documentation container

## Introduction

This Dockerfile creates the Docker image needed to build the relayr
documentation.

Due to the installation of a few texlive packages the resulting image
is around 1.5 GB in size.

Due to the size of the texlive related Debian packages the package
installation is split in two different `RUN` invocations. This is
to avoid rebuilding the texlive package download and installation. 

It uses a [docker bind
mount](https://docs.docker.com/storage/bind-mounts) to make the source
directory &mdash; where the documents source resides &mdash; available
to the container. To increase portability it uses the current working
directory as the bind mount source. The 
[working
directory](https://docs.docker.com/engine/reference/builder/#workdir)
inside Docker is `/source`.

## Building the image by yourself

    docker build -t <name>:<tag> .
    
### Example

    docker build -t perusio/pandoc-relayr:1.0 .
    
## Running the container

Running pandoc is an ideal application for Docker since is a single
run. Since there is no daemon on the container the container should be
removed after pandoc is invoked.

    docker run  --rm --mount type=bind,src=$(pwd),dst=/source \
        perusio/pandoc-relayr:1.0 <arguments>

where `<arguments>` are the arguments passed to GNU Make. Note that
this container does not run pandoc directly but it relies on GNU Make
to invoke pandoc. So it expects a source directory with a given
structure specific of the relayr documentation system.
