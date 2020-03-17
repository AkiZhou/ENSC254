
;@ Copyright (C) 2019 School of Engineering Science, SFU

#include "asm_include.h"
.include "../src/macros.i"
.include "../src/definitions.i"

;@ .data
;@ .align

.text
.align		;@align the variable to 4 bytes word boundary

FUNCTION asm_main
	;@ Use r3 to hold the base address of the Switch GPIO ports
	;@ Use r1 to hold the base address of LED GPIO ports
	;@ Use r2 as scratch

	;@ Load base addresses for LED GPIO and Switch GPIO
	ldr r3, =XPAR_AXI_GPIO_SWS_BASEADDR		;@ load base address of Switches into r0 -- ldr r0, [PC, #offset]
	ldr r1, =XPAR_AXI_GPIO_LEDS_BASEADDR	;@ load base address of LEDs into r1

	;@ The connections to the LEDs and switches are initially configured as inputs. This works well
	;@ for the switches but not so helpful for the LEDs.  Connections can be changed to outputs by
	;@ clearing their corresponding bits in the GPIO 'Tristate Register'. The
	;@ Tristate register is at an offset from the base address for GPIO ports.
	ldr r2, [r1, #XGPIO_TRI_OFFSET] ;@ Read the tristate register for the LEDs
	;@ fill this in   				;@ Clear the first 8 tristate bits to enable the 8 LEDs as outputs
	str r2, [r1, #XGPIO_TRI_OFFSET]	;@ Write new value to LED tristate register to enable as outputs

poll:
	;@ The Data Register is located directly at the base address of the GPIO ports
	;@ so by reading and writing the base address we can read from and write to the data register.
	;@ Still a (zero) offset has been defined for the Data Register.
	ldr r2, [r3, #XGPIO_DATA_OFFSET]	;@read switches
	str r2, [r1, #XGPIO_DATA_OFFSET]	;@write value to LED

	b poll ;@ Loop endlessly polling buttons and setting LEDs

	;@ An empty main project doing nothing
	;@ Follow the tutorial instruction and complete the main program to read from switches and update LEDs
	mov r0, #0
	mov pc, lr  ;@ Return from function call
ENDFUNC asm_main



