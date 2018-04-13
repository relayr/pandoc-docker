# Dockerfile for making available a docker container with Pandoc and
# all the necessary software to build the relayr documentation.
FROM debian:testing-slim

# Install the needed packages.
RUN export DEBIAN_FRONTEND=noninteractive \
           && apt-get update -y \
           && apt-get upgrade -y \
           && apt-get --no-install-recommends install -y \
           texlive-fonts-extra \
           texlive-latex-recommended \
           texlive-latex-extra \
           texlive-pictures \
           texlive-luatex \
           pandoc \
           fontconfig 
           
RUN apt-get --no-install-recommends install -y \
           lmodern \
           python-pip \
           python-setuptools \
           python-wheel \
           python-psutil \
           make 

# Install the pandoc filters.
RUN pip install pandoc-fignos pandoc-tablenos

# Install the Monda font.
ADD fonts/Monda.tar.xz /usr/local/share/fonts/
RUN chmod 644 /usr/local/share/fonts/Monda-*.ttf

# Create the work directory.
WORKDIR /source

VOLUME ["/source"]

# pndoc is the entry point. Arguments will be passed via docker run.
ENTRYPOINT ["/usr/bin/make"]
