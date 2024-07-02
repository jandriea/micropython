#include "py/mphal.h"
#include "boardctrl.h"

void board_early_init(void) {
    HAL_PWREx_EnableVddIO2();
    while (HAL_PWREx_ConfigSupply(PWR_SMPS_SUPPLY) != HAL_OK){
    }
}
