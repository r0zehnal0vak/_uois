###############################################################
#
# Zero phase
#
###############################################################
FROM python:3.10.13-slim as pythonbase

# Install curl and ping
RUN apt update && apt install -y curl iputils-ping

# Install pip requirements
COPY ./requirements.txt .
RUN python -m pip install -r requirements.txt

### Snort installation

# Set environment variable to avoid user interaction during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install the required packages, including Git and wget
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        libpcap-dev \
        libpcre3-dev \
        iproute2 \
        libnet1-dev \
        zlib1g-dev \
        luajit \
        hwloc \
        libdumbnet-dev \
        liblzma-dev \
        openssl \
        libssl-dev \
        pkg-config \
        libhwloc-dev \
        cmake \
        libsqlite3-dev \
        uuid-dev \
        libcmocka-dev \
        libnetfilter-queue-dev \
        libmnl-dev \
        autotools-dev \
        libluajit-5.1-dev \
        libunwind-dev \
        libfl-dev \
        git \
        nano \
        wget && \
    # Clean up APT when done to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the libdaq repository and build it
RUN git clone https://github.com/snort3/libdaq.git && \
    cd libdaq && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install

# Download and install gperftools
RUN cd /root && \
    wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.9.1/gperftools-2.9.1.tar.gz && \
    tar xzf gperftools-2.9.1.tar.gz && \
    cd gperftools-2.9.1 && \
    ./configure && \
    make && \
    make install

# Download and install Snort3
RUN cd /root && \
    wget https://github.com/snort3/snort3/archive/refs/tags/3.1.43.0.tar.gz && \
    tar -xvzf 3.1.43.0.tar.gz && \
    cd snort3-3.1.43.0 && \
    ./configure_cmake.sh --prefix=/usr/local --enable-tcmalloc && \
    cd build && \
    make && \
    make install && \
    ldconfig

# Set up Snort configuration directory
RUN mkdir -p /usr/local/etc/snort && \
    mkdir -p /usr/local/etc/rules && \
    mkdir -p /var/log/snort && \
    mkdir -p /usr/local/lib/snort_dynamicrules && \
    touch /usr/local/etc/snort/snort.lua && \
    touch /usr/local/etc/snort/snort_defaults.lua

# Download and extract Snort community rules
RUN cd /root && \
    wget https://www.snort.org/downloads/community/snort3-community-rules.tar.gz && \
    tar -xvzf snort3-community-rules.tar.gz && \
    cp -r snort3-community-rules/* /usr/local/etc/rules/

# Copy Snort configuration files
COPY ./snort.lua /usr/local/etc/snort/
COPY ./local.rules /usr/local/etc/rules/

###############################################################
#
# Last phase
#
###############################################################
FROM pythonbase as executepython

EXPOSE 8000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY . /app

# Creates a non-root user and adds permission to access the /app folder
RUN useradd appuser && chown -R appuser /app
#USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules -i lo -D -l /var/log/snort && gunicorn --bind 0.0.0.0:8000 -k uvicorn.workers.UvicornWorker server.main:app
#CMD ["gunicorn", "--bind", "0.0.0.0:8000", "-k", "uvicorn.workers.UvicornWorker", "server.main:app"]
#CMD ["gunicorn", "--reload", "--reload-engine", "inotify", "--bind", "0.0.0.0:8000", "-k", "uvicorn.workers.UvicornWorker", "app:app"]
