FROM python:3.11

# Install linux libraries
RUN apt-get update && apt-get install -y wget unzip libnetcdf-dev

# Set up versioning
ARG version_number
ARG commit_sha

#ARG LSSS_VERSION=lsss-3.1.0-rc1-20250721-1247-linux

ARG LSSS_VERSION_VER=lsss-3.1.0
ARG LSSS_VERSION_REL=rc1
ARG LSSS_VERSION_T=20250721-1247

ARG LSSS_VERSION=${LSSS_VERSION_VER}-${LSSS_VERSION_REL}-${LSSS_VERSION_T}-linux
#lsss-3.1.0-rc1-20250721-1247

ENV VERSION_NUMBER=$version_number
ENV COMMIT_SHA=$commit_sha
ENV LSSS_VERSION=$LSSS_VERSION

LABEL COMMIT_SHA=$commit_sha
LABEL VERSION_NUMBER=$version_number
LABEL LSSS_VERSION=$LSSS_VERSION

# Download Korona
RUN wget https://marec.no/tmp/${LSSS_VERSION}.zip

# Unpack Korona in two stages:
RUN unzip /${LSSS_VERSION}.zip
RUN rm /${LSSS_VERSION}.zip
RUN unzip /${LSSS_VERSION_VER}-${LSSS_VERSION_REL}-${LSSS_VERSION_T}/${LSSS_VERSION_VER}-${LSSS_VERSION_REL}-linux.zip -d /
RUN rm /${LSSS_VERSION_VER}-${LSSS_VERSION_REL}-${LSSS_VERSION_T}/${LSSS_VERSION_VER}-${LSSS_VERSION_REL}-linux.zip

COPY KoronaCli.sh /${LSSS_VERSION_VER}-${LSSS_VERSION_REL}/korona/KoronaCli.sh

# Copy korona files
COPY compression.cds /app/
COPY compression.cfs /app/
COPY TransducerRanges.xml /app/

# Prepare for running
COPY CRIMAC_compression.py /app/CRIMAC_compression.py 
RUN mkdir /scratch
WORKDIR /app

# Run the script
ENTRYPOINT ["python", "-u", "/app/CRIMAC_compression.py"]

