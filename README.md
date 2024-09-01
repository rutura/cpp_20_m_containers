# Docker Containers Intended for Use with the C++ 23 Masterclass

## Projects Use CMake with the Following Dependencies and Settings:
- GCC 14.2 or Clang 18
- CMake 3.30
- Ninja v1.12.1
- Vcpkg
  - Run the bash file to initialize
  - Set up the `VCPKG_ROOT` environment variable to point to the root folder of vcpkg
- GDB (any version)

## Intended Workflow:
1. The student opens the template project in VS Code by dragging the folder onto VS Code.
2. The project opens up.
3. If the CMake Tools extension is installed, there should be a button to choose configuration.
4. The student clicks on the button:
   - On Windows, they should be given the option to use Visual C++.
   - On Linux, they should be given the option to use GCC or Clang:
     - GCC still has issues with modules that we need to fix.
     - Debugging doesn't work yet with Clang and this needs fixing.
   - On Mac, they may be given the option to use Clang.

## End Goal:
- We need these two containers to work to the best of their abilities with modules:
  - `ubuntu_cmake_clang_18`
  - `ubuntu_cmake_gcc_14`

## Open Questions:
- Should we install both GCC and Clang in the same container?
  - What are the pros and cons?
