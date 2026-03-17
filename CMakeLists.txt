cmake_minimum_required(VERSION 3.19)

project(ec2_package)

# Target Universal Binary (Apple Silicon + Intel)
set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "Build architectures for Mac OS X" FORCE)

# Set Max SDK path (update if needed)
set(MAX_SDK_DIR "${CMAKE_CURRENT_SOURCE_DIR}/max-sdk" CACHE PATH "Path to Max SDK")

# Set consistent output directory for all externals
set(EXTERNALS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/externals" CACHE PATH "Output directory for Max externals")

# Add the ec2~ external
add_subdirectory(source/ec2_tilde)

# Unit tests (standalone, no Max SDK required)
option(EC2_BUILD_TESTS "Build unit tests for engine components" OFF)
if(EC2_BUILD_TESTS)
  add_subdirectory(tests)
endif()
