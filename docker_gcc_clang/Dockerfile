# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Ensure package lists are updated and upgrade any outdated packages
RUN apt-get update && apt-get upgrade -y

# Install common dependencies and development tools
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
    bash-completion \
    gcc-14 \
    g++-14 \
    cmake

# Set GCC 14 as the default gcc
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 140 --slave /usr/bin/g++ g++ /usr/bin/g++-14 && \
    update-alternatives --set gcc /usr/bin/gcc-14

# Install Clang 18
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 18 && \
    rm llvm.sh

# Set Clang 18 as an alternative
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 180 --slave /usr/bin/clang++ clang++ /usr/bin/clang++-18

# Install Ninja v1.12.1
RUN wget https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-linux.zip && \
    unzip ninja-linux.zip -d /usr/local/bin/ && \
    rm ninja-linux.zip

# Create a non-root user
RUN useradd -m developer && echo "developer:developer" | chpasswd && adduser developer sudo

# Allow developer to use sudo without password
RUN echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/developer

# Install vcpkg as the developer user
USER developer
RUN git clone https://github.com/microsoft/vcpkg.git /home/developer/vcpkg --depth 1 && \
    /home/developer/vcpkg/bootstrap-vcpkg.sh

# Set up the VCPKG_ROOT environment variable and add vcpkg to PATH
ENV VCPKG_ROOT=/home/developer/vcpkg
ENV PATH="/home/developer/vcpkg:$PATH"

# Set up bash-completion and add vcpkg to PATH for the developer user
RUN echo "source /etc/profile.d/bash_completion.sh" >> /home/developer/.bashrc && \
    echo 'export PATH="/home/developer/vcpkg:$PATH"' >> /home/developer/.bashrc

# Run vcpkg integrate install
RUN /home/developer/vcpkg/vcpkg integrate install

# Switch back to root to clean up
USER root

# Clean up unnecessary files
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set working directory
WORKDIR /workspace

# Switch back to the non-root user
USER developer

# Set entry point
CMD ["/bin/bash"]