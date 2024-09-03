# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Ensure package lists are updated and upgrade any outdated packages
RUN apt-get update && apt-get upgrade -y

# Install common dependencies and bash-completion
RUN apt-get install -y \
    wget \
    git \
    curl \
    gdb \
    unzip \
    zip \
    tar \
    ninja-build \
    libssl-dev \
    pkg-config \
    build-essential \
    libgmp-dev \
    libmpfr-dev \
    libmpc-dev \
    libisl-dev \
    zlib1g-dev \
    sudo \
    software-properties-common \
    lsb-release \
    gnupg \
    bash-completion

# Install GCC 14.2
RUN wget https://ftp.gnu.org/gnu/gcc/gcc-14.2.0/gcc-14.2.0.tar.gz && \
    tar -xvzf gcc-14.2.0.tar.gz && \
    cd gcc-14.2.0 && \
    ./contrib/download_prerequisites && \
    mkdir build && \
    cd build && \
    ../configure --disable-multilib --enable-languages=c,c++ && \
    make -j$(nproc) && \
    make install && \
    cd /tmp && \
    rm -rf gcc-14.2.0.tar.gz gcc-14.2.0

# Install CMake 3.30 (or later)
RUN wget https://github.com/Kitware/CMake/releases/download/v3.30.0/cmake-3.30.0-Linux-x86_64.sh && \
    chmod +x cmake-3.30.0-Linux-x86_64.sh && \
    ./cmake-3.30.0-Linux-x86_64.sh --skip-license --prefix=/usr/local && \
    rm cmake-3.30.0-Linux-x86_64.sh

# Install Ninja v1.12.1
RUN wget https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-linux.zip && \
    unzip ninja-linux.zip -d /usr/local/bin/ && \
    rm ninja-linux.zip

# Install vcpkg
RUN git clone https://github.com/microsoft/vcpkg.git /opt/vcpkg && \
    /opt/vcpkg/bootstrap-vcpkg.sh

# Set up the VCPKG_ROOT environment variable
ENV VCPKG_ROOT=/opt/vcpkg

# Clean up unnecessary files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create a non-root user
RUN useradd -m developer && echo "developer:developer" | chpasswd && adduser developer sudo

# Allow developer to use sudo without password
RUN echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/developer

# Set up bash-completion
RUN echo "source /etc/profile.d/bash_completion.sh" >> /home/developer/.bashrc

# Set working directory
WORKDIR /workspace

# Set entry point
CMD ["/bin/bash"]
