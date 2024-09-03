# Use the official latest Clang image as the base
FROM silkeh/clang:latest

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
    bash-completion

# Install the latest CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null && \
    echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null && \
    apt-get update && \
    apt-get install -y cmake

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
RUN git clone https://github.com/microsoft/vcpkg.git /home/developer/vcpkg && \
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