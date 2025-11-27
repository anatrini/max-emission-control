cmake_minimum_required(VERSION 3.19)

project(ec2_package)

# Target Universal Binary (Apple Silicon + Intel)
set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "Build architectures for Mac OS X" FORCE)

# Set the min-api path for subprojects
set(C74_MIN_API_DIR ${CMAKE_CURRENT_SOURCE_DIR}/my-min-devkit/source/min-api)

# Set consistent output directory for all externals (fixes build location inconsistency)
set(C74_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/externals" CACHE PATH "Output directory for Max externals")

# Add each external in the source directory
add_subdirectory(source/ec2_tilde)
