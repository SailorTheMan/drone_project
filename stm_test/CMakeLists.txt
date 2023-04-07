# Project name
project(stm32test)

cmake_minimum_required(VERSION 3.2)

enable_language(C ASM)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# Compiler definitions
add_compile_definitions(
    STM32F103xB
    USE_HAL_DRIVER
)

# Project sources
set(PROJECT_SOURCES
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c
    libs/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c

    src/stm32f1xx_it.c
    src/stm32f1xx_hal_msp.c
    src/system_stm32f1xx.c
    src/main.c

    startup_stm32f103xb.s
    )

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}/.
  ${CMAKE_CURRENT_SOURCE_DIR}/src
  ${CMAKE_CURRENT_SOURCE_DIR}/libs/CMSIS/Device/ST/STM32F1xx/Include
  ${CMAKE_CURRENT_SOURCE_DIR}/libs/CMSIS/Include
  ${CMAKE_CURRENT_SOURCE_DIR}/libs/STM32F1xx_HAL_Driver/Inc
  ${CMAKE_CURRENT_SOURCE_DIR}/libs/STM32F1xx_HAL_Driver/Inc/Legacy
)

add_executable(${CMAKE_PROJECT_NAME}.elf ${PROJECT_SOURCES})

target_compile_options(${CMAKE_PROJECT_NAME}.elf PRIVATE
    -mcpu=cortex-m3
    -mthumb
    -Wall
    -fdata-sections
    -ffunction-sections
    -g
    -gdwarf-2
    -Og
    $<$<COMPILE_LANGUAGE:ASM>:-x assembler-with-cpp ${ASM_FLAGS}>
)

target_link_options(${CMAKE_PROJECT_NAME}.elf PRIVATE
    -mcpu=cortex-m3
    -mthumb
    -T${CMAKE_CURRENT_SOURCE_DIR}/STM32F103C8Tx_FLASH.ld
    -lc
    -lm
    -lnosys
    -specs=nano.specs
)
add_custom_command(TARGET ${CMAKE_PROJECT_NAME}.elf
        POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O ihex ${CMAKE_PROJECT_NAME}.elf ${CMAKE_PROJECT_NAME}.hex
        COMMAND ${CMAKE_OBJCOPY} -O binary -S ${CMAKE_PROJECT_NAME}.elf ${CMAKE_PROJECT_NAME}.bin)