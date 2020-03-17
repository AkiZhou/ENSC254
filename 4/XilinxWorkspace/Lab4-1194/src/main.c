/*
 * main.c
 *
 *  Created on: Jul 2, 2019
 *      Author: wcs
 */


/* Example assembly project that reads from switches
 * and displays values on the LEDs of the ZedBoard
 */

/* Declare the asm_main() function as external as it will be provided
 * in an assembly language file.
 */
extern int asm_main();

int main() {
	return asm_main();
}
