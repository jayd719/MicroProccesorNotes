/*
-------------------------------------------------------
l08_t01.s
-------------------------------------------------------
Author: Jashandeep Singh
ID:     160198282
Email:  sing8282@mylaurier.ca
Date:    2024-03-21
-------------------------------------------------------
Uses a subroutine to write strings to the UART.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr r4, =First
bl  WriteString
ldr r4, =Second
bl  WriteString
ldr r4, =Third
bl  WriteString
ldr r4, =Last
bl  WriteString

_stop:
b    _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address

//=======================================================

.equ ENTER, 0x0a     // enter character


//=======================================================

WriteString:
/*
-------------------------------------------------------
Writes a null-terminated string to the UART, adds ENTER.
-------------------------------------------------------
Parameters:
  r4 - address of string to print
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/

//=======================================================

// sub routine prologe
stmfd   sp!, {r1-r2,r4}
stmfd   sp!, {lr}

ldr     r1, =UART_BASE // load the address of UART

LOOP:
ldrb    r2, [r4], #1     // load a single byte from the string
cmp     r2, #0           // compare to null character
beq     _printEnter    // print Enter when the null character is found
strb    r2, [r1]         // else copy the character to the UART DATA field
b       LOOP

_printEnter:
mov     r2, #ENTER 
strb    r2, [r1]

ldmfd    sp!, {lr}        // pop back link register
ldmfd    sp!, {r1-r2,r4}  // pop back the preserved registers
//=======================================================

bx    lr                 // return from subroutine

.data
.align
// The list of strings
First:
.asciz  "First string"
Second:
.asciz  "Second string"
Third:
.asciz  "Third string"
Last:
.asciz  "Last string"
_Last:    // End of list address

.end