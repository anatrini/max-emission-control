cmake_minimum_required(VERSION 3.19)

set(C74_MIN_API_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../my-min-devkit/source/min-api)
include(${C74_MIN_API_DIR}/script/min-pretarget.cmake)

set(PROJECT_NAME ec2_tilde)

include_directories(
	"${C74_INCLUDES}"
)

# EmissionControl2 includes
include_directories(
	"${CMAKE_CURRENT_SOURCE_DIR}/../../third_party/EmissionControl2/ecSource/include"
	"${CMAKE_CURRENT_SOURCE_DIR}/../../third_party/EmissionControl2/ecSource/external"
)

set(SOURCE_FILES
	${PROJECT_NAME}.cpp
	ec2_utility.cpp
	ec2_scheduler.cpp
	ec2_envelope.cpp
)

add_library(
	${PROJECT_NAME}
	MODULE
	${SOURCE_FILES}
)

# Link EmissionControl2 library (we'll need to configure this)
# For now, we'll include the sources directly or link to ecLib

include(${C74_MIN_API_DIR}/script/min-posttarget.cmake)
