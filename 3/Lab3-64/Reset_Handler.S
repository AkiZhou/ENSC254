;@===========================================================================
;@ 
;@ Description : 64-bit code for Lab 3.
;@===========================================================================

;@ Tabs set for 8 characters for ASM files in Edit > Configuration

	.org 0	
	.text			;@ Store in ROM

Reset_Handler:
	.global Reset_Handler	;@ The entry point on reset
		
main:		
	;@ Pointers to the variables
	ldr r0, =var_a
	ldr r1, =var_b
	
	;@ Load a 64-bit 0 into variable var_a and 1 into var_b
	mov r12, #0;	@ Constant used for initializing the variables
	str r12, [r0, #0]	;@ Set the value of var_a
	str r12, [r1, #0]	;@ Set the value of var_b
	str r12, [r0, #4]

	mov r12, #1		;@ Constant used for initializing LSW of var_b
	str r12, [r1, #4]
	
	;@ Counter to specify how many terms we want to calculate
	mov r4, #90

loop:
	;@ Add the least-significant word (LSW) from each variable
	ldr 	r3, [r0, #4]	;@ Load the LSW of var_a	
	ldr 	r12, [r1, #4]	;@ Load the LSW of var_b
	str 	r12, [r0, #4]	;@ Move the LSW of var_b into the LSW of var_a

	;@ We add the two words without carry for the LSW.
	;@ We add the other words using a carry.
	;@ We set the status flags for subsequent operations
	adds 	r3, r3, r12	;@ Add LSWs, set status flags

	str 	r3, [r1, #4]	;@ Store the LSW of result into the LSW of var_b

	;@ Add the most significant word (MSW) from each variable, with the carry.
	ldr 	r3, [r0, #0]	;@ Load the MSW of var_a	
	ldr 	r12, [r1, #0]	;@ Load the MSW of var_b
	str 	r12, [r0, #0]	;@ Move the MSW of var_b into the MSW of var_a

	adcs 	r3, r3, r12	;@ Add MSWs using carry bit, set status flags
	;@ *** did it carry out (overflow)? ***
	
	str 	r3, [r1, #0]	;@ Store the MSW of result into the MSW of var_b

;@	<??????????>		;@ Decrement the loop counter (r4)
;@	<??????????>		;@ Branch to "loop" if we haven't finished

done:
	b 	done		;@ Program done! Loop forever.
	
	.data			;@ Store in RAM			
var_a:	.space 	8		;@ Variable A (64-bit)
var_b:	.space 	8		;@ Variable B (64-bit)

	.end			;@ End of program	
