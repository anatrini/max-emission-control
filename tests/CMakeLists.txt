cmake_minimum_required(VERSION 3.19)
project(ec2_tests)

# Tests compile standalone without Max SDK
# Only engine components are tested (no ec2_tilde.cpp, no ec2_param_window.mm)

set(EC2_SRC "${CMAKE_CURRENT_SOURCE_DIR}/../source/ec2_tilde")

set(ENGINE_SOURCES
    ${EC2_SRC}/ec2_utility.cpp
    ${EC2_SRC}/ec2_scheduler.cpp
    ${EC2_SRC}/ec2_envelope.cpp
    ${EC2_SRC}/ec2_lfo.cpp
    ${EC2_SRC}/ec2_filter.h
    ${EC2_SRC}/ec2_grain.cpp
    ${EC2_SRC}/ec2_voice_pool.cpp
    ${EC2_SRC}/ec2_engine.cpp
    ${EC2_SRC}/ec2_spatial_allocator.cpp
)

add_executable(ec2_tests
    test_components.cpp
    ${ENGINE_SOURCES}
)

target_include_directories(ec2_tests PRIVATE ${EC2_SRC})
target_compile_features(ec2_tests PRIVATE cxx_std_17)
target_compile_options(ec2_tests PRIVATE -Wall -Wno-unused-parameter)

# Enable CTest integration
enable_testing()
add_test(NAME ec2_unit_tests COMMAND ec2_tests)
