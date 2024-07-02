MCU_SERIES = u5
CMSIS_MCU = STM32U575xx
AF_FILE = boards/stm32u575_af.csv
LD_FILES = $(BOARD_DIR)/stm32u575xi.ld

## board-specific frozen modules
FROZEN_MANIFEST = $(BOARD_DIR)/manifest.py
