@ Code for Lab 5 for ENSC 254
@ Copyright (C) 2019 School of Engineering Science, SFU


@Declare the labels of the interrupt handler and the main routine as globals
.global asm_main
.global FIQHandler

#include "asm_include.h"
#include "macros.i"

.text

//FUNCTION asm_main
asm_main:
  PUSH {R4-R11, LR}
  BL OLED_clear
  BL OLED_welcome
  LDR R0, =0 @ total_events

  @Switch to FIQ mode
  LDR R1, =XREG_CPSR_FIQ_MODE
  MSR CPSR_c, R1

  @Initialize FIQ registers for the purposes
  @of the FIQ being able to use them
  LDR R9, =XPAR_AXI_GPIO_BTNS_BASEADDR  @ EOR R9, R9
  LDR R10, =XPAR_AXI_GPIO_LEDS_BASEADDR
;@  EOR R11, R11
;@  EOR R12, R12

  @Button interrupt on.
  LDR R8, =XGPIO_GIE_GINTR_ENABLE_MASK
  STR R8, [R9, #XGPIO_GIE_OFFSET]
  LDR R8, =XGPIO_IR_CH1_MASK
  STR R8, [R9, #XGPIO_IER_OFFSET]

	;@ The connections to the LEDs and switches are initially configured as inputs. This works well
	;@ for the switches but not so helpful for the LEDs.  Connections can be changed to outputs by
	;@ clearing their corresponding bits in the GPIO 'Tristate Register'. The
	;@ Tristate register is at an offset from the base address for GPIO ports.
	ldr R8, [R10, #XGPIO_TRI_OFFSET] ;@ Read the tristate register for the LEDs
	bic R8, #0xFF   				;@ Clear the first 8 tristate bits to enable the 8 LEDs as outputs
	str R8, [R10, #XGPIO_TRI_OFFSET]	;@ Write new value to LED tristate register to enable as outputs
  	str r0, [r10, #XGPIO_DATA_OFFSET]	;@ write 0 to LEDs to turn them off

  MOV R8, R0 @ total_events

  @Switch back to system mode
  LDR R1, =XREG_CPSR_SYSTEM_MODE
  MSR CPSR_c, R1

  MOV R1, #3
  BL OLED_print_R0_on_row_R1

  @Enable fast interrupts
  CPSIE f

  ;@ Load base addresses for and Slider Switch GPIO
  ldr r4, =XPAR_AXI_GPIO_SWS_BASEADDR		;@ load base address of Switches into r4

.poll:
	;@ The Data Register is located directly at the base address of the GPIO ports
	;@ so by reading the base address we can read from the data register.
	;@ Still a (zero) offset has been defined for the Data Register.
	ldr r6, [r4, #XGPIO_DATA_OFFSET]	;@ read slider switches
	mov	r6, r6, lsl #9					;@ scale value up
	mov r0, r6
	mov r1, #1
	BL OLED_print_R0_on_row_R1
	mov r0, r6
	BL fib_main
  	MOV R1, #2
  	BL OLED_print_R0_on_row_R1
  	B .poll

  	POP {R4-R11, PC}
//ENDFUNC main

FIQHandler:
  @ Reminder.  FIQ mode has its own versions of R8 through R12 (and R13 and R14)
  @ Also, notice how fast this hander is.

  @Clear the button interrupt here.
  LDR R12, [R9, #XGPIO_ISR_OFFSET]
  STR R12, [R9, #XGPIO_ISR_OFFSET]

  ADD R8, R8, #1 @ increment count of total interrupts

  str r8, [r10, #XGPIO_DATA_OFFSET]	;@write value to LED

  @ Dubious offset, I know. Still, here's the reference:
  @ http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0040d/Cacbacic.html

  @ The S at the end of SUBS causes the SPSR of the mode (FIQ in this case) to be put back in the CPSR
  SUBS	 	PC, LR, #4
