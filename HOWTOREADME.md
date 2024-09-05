# C++ 23 Masterclass Development Environments with Docker

This project provides Docker-based C++ development environments for the C++ 23 Masterclass:

1. Ubuntu with CMake and Clang 18
2. Ubuntu with CMake and GCC 14
3. A combined environment with both Clang 18 and GCC 14

## Prerequisites

- Docker
- Docker Compose
- Visual Studio Code (recommended)
- CMake Tools extension for VS Code (recommended)

## Project Structure

```
project_root/
│
├── docker-compose.yml
│
├── docker_clang_18/
│   └── Dockerfile
│
├── docker_gcc_14/
│   └── Dockerfile
│
└── docker_gcc_clang/
    └── Dockerfile
```

## Building and Running the Containers

1. Clone the C++ 23 Masterclass repository:
   ```
   git clone https://github.com/rutura/The-C-20-Masterclass-Source-Code.git
   cd The-C-20-Masterclass-Source-Code
   git checkout cpp23-update
   ```

2. Copy the `docker-compose.yml` and Dockerfiles into this directory.

3. Build and start the containers:
   ```
   docker-compose up -d --build
   ```

4. To enter a specific container:
   - Clang 18: `docker exec -it ubuntu_cmake_clang_18 /bin/bash`
   - GCC 14: `docker exec -it ubuntu_cmake_gcc_14 /bin/bash`
   - Combined: `docker exec -it ubuntu_cmake_gcc_clang /bin/bash`

5. When you're done, stop the containers:
   ```
   docker-compose down
   ```

## Using the Environments

All containers mount the project root directory to `/workspace`. This allows you to edit files on your host machine and compile them within the container.

### Clang 18 or GCC 14 Environment

1. Navigate to the workspace: `cd /workspace`

2. Compile a C++ file:
   - Clang: `clang++ -std=c++23 your_file.cpp -o output`
   - GCC: `g++ -std=c++23 your_file.cpp -o output`

3. Run CMake:
   ```
   mkdir build && cd build
   cmake -G Ninja ..
   ninja
   ```

### Combined Environment

In the combined environment, you can switch between compilers:

1. To use GCC: `sudo update-alternatives --set gcc /usr/bin/gcc-14`
2. To use Clang: `sudo update-alternatives --set clang /usr/bin/clang-18`
3. Verify the active compiler: `gcc --version` or `clang --version`

## Intended Workflow

1. Open the project in VS Code by dragging the folder onto VS Code.
2. If the CMake Tools extension is installed, use the button to choose configuration:
   - On Windows: Use Visual C++
   - On Linux: Choose GCC or Clang (Note: GCC may have issues with modules, and debugging with Clang needs fixing)
   - On Mac: Use Clang

## Additional Tools and Settings

All environments include:
- CMake 3.30
- Ninja v1.12.1
- Vcpkg (initialized, with `VCPKG_ROOT` set)
- GDB
- Git

## Customizing the Environments

To add more tools or customize the environments:

1. Modify the respective Dockerfile.
2. Rebuild the containers: `docker-compose up -d --build`

## Troubleshooting

1. For permission issues, ensure Docker has necessary permissions to access your project directory.
2. Check container logs: `docker-compose logs [service_name]`
3. To remove all containers and start fresh: `docker-compose down --rmi all --volumes`

## Known Issues and Limitations

- GCC still has issues with modules that need to be fixed.
- Debugging doesn't work yet with Clang and needs fixing.
