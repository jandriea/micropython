/*
    Linker script fragment for mboot on an STM32xxx MCU.
    This needs the following MEMORY sections to be defined: FLASH_BL, RAM.
*/

/* produce a link error if there is not this amount of RAM for these sections */
_minimum_stack_size = 8K;

/* Define tho top end of the stack.  The stack is full descending so begins just
   above last byte of RAM.  Note that EABI requires the stack to be 8-byte
   aligned for a call. */
_estack = ORIGIN(RAM) + LENGTH(RAM);

ENTRY(Reset_Handler)

SECTIONS
{
    /* The startup code goes first into FLASH */
    .isr_vector :
    {
        . = ALIGN(8);
        KEEP(*(.isr_vector)) /* Startup code */
        . = ALIGN(8);
    } >FLASH_BL

    /* The program code and other data goes into FLASH */
    .text :
    {
        . = ALIGN(8);
        *(.text*)
        *(.rodata*)
        . = ALIGN(8);
        _etext = .;
    } >FLASH_BL

    /* used by the startup to initialize data */
    _sidata = LOADADDR(.data);

    /* Initialized data section */
    .data :
    {
        . = ALIGN(8);
        _sdata = .;
        *(.data*)

        . = ALIGN(8);
        _edata = .;
    } >RAM AT> FLASH_BL

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

    /* Uninitialized data section */
    .nozero_bss (NOLOAD) :
    {
        . = ALIGN(8);
        *(.nozero_bss*)
        . = ALIGN(8);
    } >RAM

    /* this just checks there is enough RAM for the stack */
    .stack :
    {
        . = ALIGN(8);
        . = . + _minimum_stack_size;
        . = ALIGN(8);
    } >RAM

    .ARM.attributes 0 : { *(.ARM.attributes) }
}
