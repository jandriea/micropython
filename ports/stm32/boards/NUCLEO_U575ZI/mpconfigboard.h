#include <stdint.h>

#define MICROPY_HW_BOARD_NAME       "NUCLEO-U575ZI-Q"
#define MICROPY_HW_MCU_NAME         "STM32U575ZIQ"

#define MICROPY_HW_HAS_SWITCH       (1)
#define MICROPY_HW_ENABLE_RNG       (1)
#define MICROPY_HW_ENABLE_RTC       (1)
#define MICROPY_HW_ENABLE_USB       (1)
#define MICROPY_HW_HAS_FLASH                     (1)

// MSI is used and is 4MHz
#define MICROPY_HW_CLK_PLLM         (1)
#define MICROPY_HW_CLK_PLLN         (80)
#define MICROPY_HW_CLK_PLLP         (2)
#define MICROPY_HW_CLK_PLLQ         (2)
#define MICROPY_HW_CLK_PLLR         (2)
#define MICROPY_HW_CLK_PLLFRAC      (0)

#define MICROPY_HW_FLASH_LATENCY    FLASH_LATENCY_4

// The board has an external 32kHz crystal
#define MICROPY_HW_RTC_USE_LSE      (1)

// Activate the 48 MHz internal clock
#define MICROPY_HW_CLK_USE_HSI48        (1)

// Peripheral clock sources
#define MICROPY_HW_RCC_RTC_CLKSOURCE    (RCC_RTCCLKSOURCE_LSE)

// Bus clock divider values
#define MICROPY_HW_CLK_AHB_DIV          (RCC_SYSCLK_DIV1)
#define MICROPY_HW_CLK_APB1_DIV         (RCC_HCLK_DIV1)
#define MICROPY_HW_CLK_APB2_DIV         (RCC_HCLK_DIV1)
#define MICROPY_HW_CLK_APB3_DIV         (RCC_HCLK_DIV1)

// USART1 config. Connected to ST-Link
#define MICROPY_HW_UART1_RX         (pin_A10)
#define MICROPY_HW_UART1_TX         (pin_A9)
// USART2 config
#define MICROPY_HW_UART2_RX         (pin_D6)
#define MICROPY_HW_UART2_TX         (pin_D5)
// USART3 config
#define MICROPY_HW_UART3_RX         (pin_B11)
#define MICROPY_HW_UART3_TX         (pin_B10)
// UART4 config
#define MICROPY_HW_UART4_RX         (pin_A1)
#define MICROPY_HW_UART4_TX         (pin_A0)
// LPUART config
#define MICROPY_HW_LPUART1_RX       (pin_G8)
#define MICROPY_HW_LPUART1_TX       (pin_G7)

// Select USART1 as REPL
#define MICROPY_HW_UART_REPL        PYB_UART_1
#define MICROPY_HW_UART_REPL_BAUD   115200

// SPI buses
// SPI1 config
#define MICROPY_HW_SPI1_NSS         (pin_D14)
#define MICROPY_HW_SPI1_SCK         (pin_A5)
#define MICROPY_HW_SPI1_MISO        (pin_A6)
#define MICROPY_HW_SPI1_MOSI        (pin_A7)
// SPI2 config
#define MICROPY_HW_SPI2_NSS         (pin_D0)
#define MICROPY_HW_SPI2_SCK         (pin_D1)
#define MICROPY_HW_SPI2_MISO        (pin_D3)
#define MICROPY_HW_SPI2_MOSI        (pin_D4)
// SPI3 config
#define MICROPY_HW_SPI3_NSS         (pin_C9)
#define MICROPY_HW_SPI3_SCK         (pin_C10)
#define MICROPY_HW_SPI3_MISO        (pin_C11)
#define MICROPY_HW_SPI3_MOSI        (pin_C12)

// USRSW is pulled low. Pressing the button makes the input go high.
#define MICROPY_HW_USRSW_PIN        (pin_C13)
#define MICROPY_HW_USRSW_PULL       (GPIO_NOPULL)
#define MICROPY_HW_USRSW_EXTI_MODE  (GPIO_MODE_IT_FALLING)
#define MICROPY_HW_USRSW_PRESSED    (1)

// LEDs
#define MICROPY_HW_LED1             (pin_G2)    // Red LED
#define MICROPY_HW_LED2             (pin_C7)    // Green LED
#define MICROPY_HW_LED3             (pin_B7)    // Blue LED
#define MICROPY_HW_LED_ON(pin)      (mp_hal_pin_high(pin))
#define MICROPY_HW_LED_OFF(pin)     (mp_hal_pin_low(pin))

// USB config
#define MICROPY_HW_USB_FS           (1)

// Board control config
#define MICROPY_BOARD_EARLY_INIT    board_early_init

void board_early_init(void);
