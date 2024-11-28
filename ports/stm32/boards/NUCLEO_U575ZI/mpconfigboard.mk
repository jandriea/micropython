MCU_SERIES = u5
CMSIS_MCU = STM32U575xx
AF_FILE = boards/stm32u575_af.csv
ifeq ($(USE_MBOOT),1)
LD_FILES = $(BOARD_DIR)/stm32u575xi_mboot.ld
TEXT0_ADDR = 0x0800E000
else
LD_FILES = $(BOARD_DIR)/stm32u575xi.ld
TEXT0_ADDR = 0x08000000
endif
# Additional MicroPython modules
## Add MbedTLS module
MICROPY_PY_SSL = 1
MICROPY_SSL_MBEDTLS = 1
MBEDTLS_CONFIG_FILE = '"$(BOARD_DIR)/mbedtls_config_board.h"'
## Add FatFS module
MICROPY_VFS_FAT ?= 1
## Add LittleFS2 module
MICROPY_VFS_LFS2 ?= 1

## board-specific frozen modules
FROZEN_MANIFEST = $(BOARD_DIR)/manifest.py

# Bootloader settings
MBOOT_LD_FILES = $(BOARD_DIR)/mboot_memory.ld $(BOARD_DIR)/mboot_sections.ld
