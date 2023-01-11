/*
    GNU linker script for STM32U575ZI
*/

/* Specify the memory areas */
MEMORY
{
    FLASH       (rx)    : ORIGIN = 0x08000000, LENGTH = 1024K    /* sectors 0-511 */
    FLASH_FS    (r)     : ORIGIN = 0x08100000, LENGTH = 1024K   /* sectors 512-1023 */
    RAM         (xrw)   : ORIGIN = 0x20000000, LENGTH = 768K
    SRAM4       (xrw)   : ORIGIN = 0x28000000, LENGTH = 16K     /* not contiguous with RAM */
}

/* produce a link error if there is not this amount of RAM for these sections */
_minimum_stack_size = 2K;
_minimum_heap_size = 16K;

/* Define the stack.  The stack is full descending so begins just above last byte of RAM,
   or bottom of FS cache..  Note that EABI requires the stack to be 8-byte aligned for a call. */

/* RAM extents for the garbage collector */
_ram_start = ORIGIN(RAM);
_ram_end = ORIGIN(RAM) + LENGTH(RAM);

_micropy_hw_internal_flash_storage_ram_cache_end = ORIGIN(SRAM4) + LENGTH(SRAM4); /* fs_cache in SRAM4 */
_micropy_hw_internal_flash_storage_ram_cache_start = ORIGIN(SRAM4); /* fs cache = 16K */

_estack = ORIGIN(RAM) + LENGTH(RAM) - _estack_reserve; /* stack in RAM */
_sstack = _estack - 16K; /* stack = 16K */

_heap_start = _ebss; /* heap starts just after statically allocated memory */
_heap_end = _sstack; /* 752K, tunable by adjusting stack size */

_micropy_hw_internal_flash_storage_start = ORIGIN(FLASH_FS);
_micropy_hw_internal_flash_storage_end   = ORIGIN(FLASH_FS) + LENGTH(FLASH_FS);

/* Memory layout for basic configuration:

    FLASH       .isr_vector
    FLASH       .text
    FLASH       .data

    RAM         .data
    RAM         .bss
    RAM         .heap
    RAM         .stack
*/

ENTRY(Reset_Handler)

/* define output sections */
SECTIONS
{
    /* The startup code goes first into FLASH */
    .isr_vector :
    {
        . = ALIGN(8);
        KEEP(*(.isr_vector)) /* Startup code */

        . = ALIGN(8);
    } >FLASH

    /* The program code and other data goes into FLASH */
    .text :
    {
        . = ALIGN(8);
        *(.text*)          /* .text* sections (code) */
        *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
    /*  *(.glue_7)   */    /* glue arm to thumb code */
    /*  *(.glue_7t)  */    /* glue thumb to arm code */

        . = ALIGN(8);
        _etext = .;        /* define a global symbol at end of code */
    } >FLASH

    /* This linker script fragment is intended to be included in SECTIONS. */

    /* For C++ exception handling */
    .ARM :
    {
        __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
    } >FLASH

    /* Used by the start-up code to initialise data */
    _sidata = LOADADDR(.data);

    /* Initialised data section, start-up code will copy it from flash to RAM */
    .data :
    {
        . = ALIGN(8);
        _sdata = .;
        *(.data*)
        . = ALIGN(8);
        _edata = .;
    } >RAM AT> FLASH

    /* Zeroed-out data section */
    .bss :
    {
        . = ALIGN(8);
        _sbss = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(8);
        _ebss = .;
    } >RAM

    /* This is to define the start of the heap, and make sure there is a minimum size */
    .heap :
    {
        . = ALIGN(8);
        . = . + _minimum_heap_size;
        . = ALIGN(8);
    } >RAM

    /* This checks there is enough RAM for the stack */
    .stack :
    {
        . = ALIGN(8);
        . = . + _minimum_stack_size;
        . = ALIGN(8);
    } >RAM
}

/* _bl_state symbol is used by MICROPY_HW_ENTER_BOOTLOADER_VIA_RESET, this is
   the end of stack address but is accessed as a different type. */
_bl_state = _estack;
