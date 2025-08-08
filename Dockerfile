FROM python:3.13.6-slim-bookworm

# # Install linux libraries
RUN apt-get update && apt-get install -y wget unzip bash libnetcdf-dev

# Set arguments for provenance
ARG version_number
ARG commit_sha
ARG LSSS_VERSION_VER=lsss-3.1.0
ARG LSSS_VERSION_REL=rc1
ARG LSSS_VERSION_T=20250721-1247
ARG LSSS_VERSION=${LSSS_VERSION_VER}-${LSSS_VERSION_REL}-${LSSS_VERSION_T}-linux

# Set labels for provenance
LABEL COMMIT_SHA=$commit_sha
LABEL VERSION_NUMBER=$version_number
LABEL LSSS_VERSION=$LSSS_VERSION

# Set environment variables for provenance
ENV VERSION_NUMBER=$version_number
ENV COMMIT_SHA=$commit_sha
ENV LSSS_VERSION=$LSSS_VERSION

# Download Korona
RUN wget https://marec.no/tmp/${LSSS_VERSION}.zip

# Unpack Korona
RUN unzip /${LSSS_VERSION}.zip
RUN rm /${LSSS_VERSION}.zip
RUN unzip /${LSSS_VERSION_VER}-${LSSS_VERSION_REL}-${LSSS_VERSION_T}/${LSSS_VERSION_VER}-${LSSS_VERSION_REL}-linux.zip -d /
RUN rm /${LSSS_VERSION_VER}-${LSSS_VERSION_REL}-${LSSS_VERSION_T}/${LSSS_VERSION_VER}-${LSSS_VERSION_REL}-linux.zip

# Copy necessary files
COPY KoronaCli.sh /${LSSS_VERSION_VER}-${LSSS_VERSION_REL}/korona/KoronaCli.sh
COPY compression.cds /app/compression.cds
COPY compression.cfs /app/compression.cfs
COPY TransducerRanges.xml /app/TransducerRanges.xml

# Set permissions for the Korona script and Java binary
RUN chmod +x /${LSSS_VERSION_VER}-${LSSS_VERSION_REL}/korona/KoronaCli.sh
RUN chmod +x /${LSSS_VERSION_VER}-${LSSS_VERSION_REL}/jre/bin/java

# Prepare for running
COPY CRIMAC_compression.py /app/CRIMAC_compression.py 
RUN mkdir /scratch
WORKDIR /app

# Run the script
ENTRYPOINT ["python", "-u", "/app/CRIMAC_compression.py"]

