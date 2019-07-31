cmake_minimum_required (VERSION 3.5)

set(OUTPUT_FILE_NAME AVeRY)

project(${OUTPUT_FILE_NAME})

include(configuration/${BUILD_TARGET}.cmake)

set (CMAKE_CXX_STANDARD 14)

#set (JSON_INCLUDE /usr/local/include/nlohmann)

set(CMAKE_ASM_COMPILER ${TOOL_CHAIN_PATH}/${TOOL_CHAIN_PREFIX}gcc)
set(CMAKE_C_COMPILER ${TOOL_CHAIN_PATH}/${TOOL_CHAIN_PREFIX}gcc)
set(CMAKE_CXX_COMPILER ${TOOL_CHAIN_PATH}/${TOOL_CHAIN_PREFIX}g++)
set(CMAKE_OBJCOPY ${TOOL_CHAIN_PATH}/${TOOL_CHAIN_PREFIX}objcopy)
set(CMAKE_OBJDUMP ${TOOL_CHAIN_PATH}/${TOOL_CHAIN_PREFIX}objdump)
set(CMAKE_SIZE ${TOOL_CHAIN_PATH}/${TOOL_CHAIN_PREFIX}size)

set(VERBOSE ON)

# Output for install
set (LIB_DIR ${CMAKE_BINARY_DIR}/staging/lib)
set (BIN_DIR ${CMAKE_BINARY_DIR}/staging/bin)

set(LIB_FILES
)

set(SRC_FILES
    src/main.cpp
)

include_directories (
    .
    internal
)

link_directories (
    ${LIB_DIR}
)

#add_library (System ${LIB_FILES})
add_executable (${OUTPUT_FILE_NAME}.elf ${SRC_FILES})

target_link_libraries(
    ${OUTPUT_FILE_NAME}.elf
)

add_custom_target(${OUTPUT_FILE_NAME}.hex ALL ${CMAKE_OBJCOPY} -j .text -j .data -O ihex ${OUTPUT_FILE_NAME}.elf ${OUTPUT_FILE_NAME}.hex
DEPENDS ${OUTPUT_FILE_NAME}.elf)

add_custom_target(${OUTPUT_FILE_NAME}.lst ALL ${CMAKE_OBJDUMP} -h -S ${OUTPUT_FILE_NAME}.elf > ${OUTPUT_FILE_NAME}.lst
DEPENDS ${OUTPUT_FILE_NAME}.elf)

add_custom_target(${OUTPUT_FILE_NAME}.size ALL ${CMAKE_SIZE} ${OUTPUT_FILE_NAME}.elf > ${OUTPUT_FILE_NAME}.size
DEPENDS ${OUTPUT_FILE_NAME}.elf)

install (TARGETS ${OUTPUT_FILE_NAME}.elf DESTINATION ${BIN_DIR})

