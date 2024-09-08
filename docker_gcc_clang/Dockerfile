# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Ensure package lists are updated and upgrade any outdated packages
RUN apt-get update && apt-get upgrade -y

# Install common dependencies
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
    zlib1g-dev

# ----------------- Install GCC 14.2 -----------------
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

# Set GCC 14.2 as the default gcc and g++ compiler
RUN update-alternatives --install /usr/bin/gcc gcc /usr/local/bin/gcc 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/local/bin/g++ 100

# ----------------- Install Clang 18 and tools -----------------
RUN apt-get install -y \
    clang-18 \
    clangd-18 \
    clang-format-18 \
    clang-tidy-18 \
    lldb-18 \
    clang-tools-18

# Set Clang 18 as the default compiler and tools
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 100 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100

# ----------------- Install CMake 3.30 -----------------
RUN apt-get purge --auto-remove -y cmake && \
    wget https://github.com/Kitware/CMake/releases/download/v3.30.0/cmake-3.30.0-Linux-x86_64.sh && \
    chmod +x cmake-3.30.0-Linux-x86_64.sh && \
    ./cmake-3.30.0-Linux-x86_64.sh --skip-license --prefix=/usr/local

# ----------------- Install Ninja v1.12.1 -----------------
RUN wget https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-linux.zip && \
    unzip ninja-linux.zip -d /usr/local/bin/ && \
    update-alternatives --install /usr/bin/ninja ninja /usr/local/bin/ninja 100

# ----------------- Install vcpkg -----------------
RUN git clone https://github.com/microsoft/vcpkg.git /opt/vcpkg && \
    /opt/vcpkg/bootstrap-vcpkg.sh

# Set up the VCPKG_ROOT environment variable
ENV VCPKG_ROOT=/opt/vcpkg

# Clean up unnecessary files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set entry point
CMD ["/bin/bash"]
