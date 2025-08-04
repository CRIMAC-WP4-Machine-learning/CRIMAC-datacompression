FROM python:3.11

# Install linux libraries
RUN apt-get update && apt-get install -y wget unzip libnetcdf-dev

# Set up versioning
ARG version_number
ARG commit_sha
ENV VERSION_NUMBER=$version_number
ENV COMMIT_SHA=$commit_sha
ENV LSSS_VERSION='lsss-3.1.0-alpha-20250430-1546-linux'
LABEL COMMIT_SHA=$commit_sha
LABEL VERSION_NUMBER=$version_number
LABEL LSSS_VERSION='lsss-3.1.0-rc1-20250721-1247-linux'
#lsss-3.1.0-rc1-20250721-1247-linux.zip

# Download Korona
#RUN wget https://marec.no/tmp/lsss-3.1.0-rc1-20250721-1247-linux.zip
COPY lsss-3.1.0-rc1-20250721-1247-linux.zip lsss-3.1.0-rc1-20250721-1247-linux.zip

# Unpack Korona in two stages:
RUN unzip lsss-3.1.0-rc1-20250721-1247-linux.zip
RUN rm lsss-3.1.0-rc1-20250721-1247-linux.zip
RUN unzip /lsss-3.1.0-rc1-20250721-1247/lsss-3.1.0-rc1-linux.zip -d /
RUN rm /lsss-3.1.0-rc1-20250721-1247/lsss-3.1.0-rc1-linux.zip

COPY KoronaCli.sh /lsss-3.1.0-rc1/korona/KoronaCli.sh

# Copy korona files
COPY compression.cds /app/
COPY compression.cfs /app/
COPY TransducerRanges.xml /app/

# Install python libraries & python code
#COPY requirements.txt /requirements.txt
#RUN pip install --no-cache-dir --upgrade pip && \
#    pip install --no-cache-dir -r requirements.txt

# Prepare for running
COPY CRIMAC_compression.py /app/CRIMAC_compression.py 
RUN mkdir /scratch
WORKDIR /app

# Run the script
ENTRYPOINT ["python", "-u", "/app/CRIMAC_compression.py"]

