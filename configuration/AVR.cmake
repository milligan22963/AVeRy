set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_SYSTEM_PROCESSOR avr)

set(TOOL_CHAIN_PATH /opt/tools/avr8-gnu-toolchain-linux_x86_64/bin)

set(TOOL_CHAIN_PREFIX avr-)

set(CMAKE_CROSS_COMPILING 1)

# These should be defined in the main file prior to this one being included
add_definitions(
    -DF_CPU=${F_CPU}
)

add_compile_options(
    -mmcu=${MCU}
    -Os # optimize
    -Wall # enable warnings
    -Werror
    -Wfatal-errors
    -Wl,--relax,--gc-sections
    -g
    -fpack-struct
    -fshort-enums
    -ffunction-sections
    -fdata-sections
)