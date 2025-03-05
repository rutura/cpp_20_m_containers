# Use the official GCC 14.2.0 image as the base
FROM gcc:14.2.0

# Ensure package lists are updated and upgrade any outdated packages
RUN apt-get update && apt-get upgrade -y

# Add the LLVM repository for Clang 19
RUN apt-get install -y software-properties-common && \
    wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 19 && \
    rm llvm.sh

# Install Clang tools, including clang-scan-deps-19 and other common dependencies
RUN apt-get install -y \
    clang-tools-19 \
    clangd-19 \
    clang-format-19 \
    clang-tidy-19 \
    lldb-19 \
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

# Set Clang 19 as the default compiler and tools
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-19 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-19 100 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100

# Install latest CMake (3.31.6)
RUN wget https://github.com/Kitware/CMake/releases/download/v3.31.6/cmake-3.31.6-linux-x86_64.sh -O /tmp/cmake.sh && \
    chmod +x /tmp/cmake.sh && \
    /tmp/cmake.sh --skip-license --prefix=/usr/local && \
    rm /tmp/cmake.sh

# Install Ninja v1.12.1
RUN wget https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-linux.zip -O /tmp/ninja-linux.zip && \
    unzip /tmp/ninja-linux.zip -d /usr/local/bin/ && \
    rm /tmp/ninja-linux.zip

# Install vcpkg
RUN git clone https://github.com/microsoft/vcpkg.git /opt/vcpkg && \
    /opt/vcpkg/bootstrap-vcpkg.sh

# Set up the VCPKG_ROOT environment variable
ENV VCPKG_ROOT=/opt/vcpkg

# Clean up unnecessary files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set entry point
CMD ["/bin/bash"]

