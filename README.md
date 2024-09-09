# Docker Containers Intended for Use with the C++ 23 Masterclass

# IMPORTANT NOTE:
  - You need to have Docker installed on your machine to use these containers

# Three containers are provided:
- one using GCC 14.2
- one using Clang 18
- one combining the two compilers: GCC 14.2 and Clang 18
  
# Other tools : 
- CMake 3.30
- Ninja 1.12.1
- Vcpkg
  - We set up the `VCPKG_ROOT` environment variable to point to the root folder of vcpkg
- Debuggers: GDB

## Which container to use?
- We recommend you use the one with both compilers, as it will allow you to switch between the two compilers easily.
- The others are mainly for testing purposes (for us).

## How to use: 
- The are two ways to use the containers:
  - Build the container using the Dockerfile provided
  - Pull the container from Docker Hub
  
### Building the container:
- Navigate to the folder containing the Dockerfile
- Run the following command:
  - `docker build -t gcc_clang_image .`
- Run the command to start the container, pointing the folder containing the code to the /workspace folder in the container:
  - `docker run -it --name <container_name> -v <path_to_code>:/workspace <image_name>`
  - eg: `docker run -it --name gcc_clang -v D:\Sandbox\The-C-20-Masterclass-Source-Code:/workspace gcc_clang_image`
  - in the example, gcc_clang_image is the name of the image created locally.
  - You will need to adjust the path if you are on a Linux or Mac machine. Something like `/home/user/Sandbox/The-C-20-Masterclass-Source-Code`
- By this point, you should be in the container and ready to compile your code.

### Pulling the container from Docker Hub:
- Run the following command:
  - `docker pull dgakwaya/gcc-clang:latest`
- Run the command to start the container, pointing the folder containing the code to the /workspace folder in the container:
- `docker run -it --name <container_name> -v <path_to_code>:/workspace dgakwaya/gcc-clang:latest`
  - eg: `docker run -it --name gcc_clang -v D:\Sandbox\The-C-20-Masterclass-Source-Code:/workspace dgakwaya/gcc-clang:latest`
- By this point, you should be in the container and ready to compile your code.

## Connect VS Code to the container:
- You can connect VS Code to the container by following these steps:
  - Install the Remote - Containers extension in VS Code
  - Open the folder containing the code in VS Code
  - Click on the green icon at the bottom left corner of the window
  - Select "Attach to Running Container"
  - Select the container you want to connect to
  - Open a folder in the container
  - Install the needed extensions in the container
    - C/C++
    - CMake
    - CMake Tools
  - By this point, you should be connected to the container and ready to compile your code.
  - Things you can do: 
    - Select a configure preset
      - Windows-cl
      - Linux-gcc
      - Linux-clang
  - Build: 
    - Hit the build button in the bottom left corner of the window
  - Debug:
    - Set up a break point
    - Hit the debug button on the bottom bar

## Known Issues:
  - The gcc compiler (GCC 14.2) is not compiling module code that uses the fmt library
  - You can get around that by just falling back to iostream, or using the clang compiler
  - We'll update the container as soon as we find a solution
