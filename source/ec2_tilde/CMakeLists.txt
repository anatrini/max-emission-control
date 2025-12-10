cmake_minimum_required(VERSION 3.19)

# Set policy for normalized paths
if(POLICY CMP0177)
  cmake_policy(SET CMP0177 NEW)
endif()

# Pure Max SDK build
set(PROJECT_NAME ec2_tilde)
project(${PROJECT_NAME})

# Get git version using git describe (semantic versioning with auto-increment)
# Format: v1.0.0-alpha-5-g33e56c1 where 5 is number of commits since tag
execute_process(
    COMMAND git describe --tags --long --always --dirty
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE GIT_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_QUIET
)

# Fallback if git describe fails (no tags yet)
if(NOT GIT_VERSION OR GIT_VERSION STREQUAL "")
    execute_process(
        COMMAND git rev-parse --short HEAD
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_COMMIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
    )
    if(GIT_COMMIT_HASH)
        set(GIT_VERSION "1.0.0-alpha-0-g${GIT_COMMIT_HASH}")
    else()
        set(GIT_VERSION "1.0.0-alpha-unknown")
    endif()
else()
    # Remove 'v' prefix if present
    string(REGEX REPLACE "^v" "" GIT_VERSION "${GIT_VERSION}")
endif()

# Generate version header
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/ec2_version.h.in"
    "${CMAKE_CURRENT_SOURCE_DIR}/ec2_version.h"
    @ONLY
)

# Target Universal Binary (Apple Silicon + Intel)
set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "Build architectures for Mac OS X" FORCE)

# Max SDK path - looks for symlink or set MAX_SDK_BASE_DIR
if(NOT DEFINED MAX_SDK_BASE_DIR)
    set(MAX_SDK_BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../max-sdk/source/max-sdk-base" CACHE PATH "Path to Max SDK")
endif()

if(NOT EXISTS "${MAX_SDK_BASE_DIR}/c74support/max-includes")
    message(FATAL_ERROR "Max SDK not found at: ${MAX_SDK_BASE_DIR}\n"
                        "Please install Max SDK package to: ~/Documents/Max 9/Packages/max-sdk\n"
                        "Download from: https://cycling74.com/downloads/sdk\n"
                        "Then create symlink: ln -s ~/Documents/Max\\ 9/Packages/max-sdk max-sdk\n")
endif()

# Include directories
include_directories(
    "${MAX_SDK_BASE_DIR}/c74support/max-includes"
    "${MAX_SDK_BASE_DIR}/c74support/msp-includes"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../third_party/EmissionControl2/ecSource/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../third_party/EmissionControl2/ecSource/external"
)

# Source files
set(SOURCE_FILES
    ${PROJECT_NAME}.cpp
    ec2_utility.cpp
    ec2_scheduler.cpp
    ec2_envelope.cpp
    ec2_grain.cpp
    ec2_voice_pool.cpp
    ec2_engine.cpp
    ec2_spatial_allocator.cpp
    ec2_lfo.cpp
    ${MAX_SDK_BASE_DIR}/c74support/max-includes/common/commonsyms.c
)

# Create the external
add_library(${PROJECT_NAME} MODULE ${SOURCE_FILES})

# Set output name
set_target_properties(${PROJECT_NAME} PROPERTIES
    PREFIX ""
    OUTPUT_NAME "ec2~"
    SUFFIX ".mxo"
    BUNDLE TRUE
    BUNDLE_EXTENSION "mxo"
)

# Compiler settings
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_17)
target_compile_options(${PROJECT_NAME} PRIVATE
    -Wall
    -Wno-unknown-pragmas
    -Wno-unused-parameter
)

# Find MaxAPI framework (inside Max.app)
set(MAXAPI_FRAMEWORK "/Applications/Max.app/Contents/Resources/C74/packages/max-sdk/source/c74support/max-includes")

# Linker flags for Max externals
target_link_libraries(${PROJECT_NAME} PRIVATE
    "-framework CoreFoundation"
    "-framework CoreAudio"
    "-framework AudioToolbox"
    "-framework Accelerate"
    "-undefined dynamic_lookup"
)

# Install to externals directory
set(EXTERNALS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../externals")
install(TARGETS ${PROJECT_NAME}
    LIBRARY DESTINATION "${EXTERNALS_DIR}"
)

# Post-build: copy .mxo bundle to externals
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory "${EXTERNALS_DIR}"
    COMMAND ${CMAKE_COMMAND} -E remove_directory "${EXTERNALS_DIR}/ec2~.mxo"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "$<TARGET_BUNDLE_DIR:${PROJECT_NAME}>" "${EXTERNALS_DIR}/ec2~.mxo"
    COMMENT "Copying ec2~.mxo bundle to externals directory"
)
