/*
-------------------------------------------------------
l08_t03.s
-------------------------------------------------------
Author: Jashandeep Singh
ID:     160198282
Email:  sing8282@mylaurier.ca
Date:    2024-03-21
-------------------------------------------------------
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
*/
.org 0x1000   // Start at memory location 1000
.text         // Code section
.global _start
_start:

bl    EchoString

_stop:
b _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ VALID, 0x8000          // Valid data in UART mask
.equ ENTER, 0x0A            // The enter key code

EchoString:
/*
-------------------------------------------------------
Echoes a string from the UART to the UART.
-------------------------------------------------------
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/

//=======================================================
stmfd sp!, {r0-r1}     // preserve temporary registers
ldr r1, =UART_BASE 

LOOP:
    ldr  r0, [r1]      // read the UART data register
    tst  r0, #VALID    // check if there is new data
    beq  LOOP 
    ldr  r0, [r1]
    strb r0, [r1]
    cmp r0, #ENTER
    bne  LOOP                 

_EndString:
ldmfd    sp!, {r0-r1} 

//=======================================================
bx    lr               // return from subroutine

.end