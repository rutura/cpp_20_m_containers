# Docker containers intended for use with the C++ 23 Masterclass

. Projects use CMake with the following dependencies and settings: 
        . gcc 14.2 or Clang 18
        . cmake 3.30
        . ninja v1.12.1
        . vcpkg and run the bash file to initialize
	    . set up the VCPKG_ROOT environment variable wo point to the root folder of vcpkg 
        . gdb any version

. Intended work flow: 
    . The student opens the template project in VS Code by dragging the folder on top of  VS Code
    . The projects opens up
    . If the cmake tools extension is installed there should be a button to choose configuration.
    . The student clicks on the button
        . On windows, they should be given the option to use Visual C++
        . ON Linux, they should be given the option to use GCC or clang
            . GCC still has issues with modules that we need to fix
        . On Mac, may be clang??

. End goal: 
    . We need these two containers to work to the best of their abilities with modules
        . ubuntu_cmake_clang_18
        . ubuntu_cmake_gcc_14

. Open questions: 
    . Should we install both gcc and clang in the same container? 
        . What are the pros and cons? 