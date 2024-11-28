#include "py/mphal.h"
#include "boardctrl.h"

void board_early_init(void) {
    // configure the power control
    HAL_PWREx_EnableVddIO2();
    while (HAL_PWREx_ConfigSupply(PWR_SMPS_SUPPLY) != HAL_OK) {
    }
}

#if BUILDING_MBOOT
#include "mboot/mboot.h"
#include "boardctrl.h"
#include "irq.h"

void mboot_early_init(void) {
    if (query_irq() == IRQ_STATE_DISABLED) {
        enable_irq(IRQ_STATE_ENABLED);
    }
}

int board_mboot_get_reset_mode(uint32_t *initial_r0) {
    int reset_mode = BOARDCTRL_RESET_MODE_NORMAL;
    return reset_mode;
}

void board_mboot_state_change(int state, uint32_t arg) {
    mboot_state_change_default(state, arg);
}

#endif
