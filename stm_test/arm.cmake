set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(TOOLCHAIN_PATH /opt/gcc-arm-none-eabi-10.3-2021.10)

set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_COMPILER ${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX}g++)

set(CMAKE_OBJCOPY ${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX}objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL ${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX}size CACHE INTERNAL "size tool")

set(CMAKE_FIND_ROOT_PATH /home/sailor/arm-toochain)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)