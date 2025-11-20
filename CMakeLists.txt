cmake_minimum_required(VERSION 3.19)

project(ec2_package)

# Set the min-api path for subprojects
set(C74_MIN_API_DIR ${CMAKE_CURRENT_SOURCE_DIR}/my-min-devkit/source/min-api)

# Add each external in the source directory
add_subdirectory(source/ec2_tilde)
