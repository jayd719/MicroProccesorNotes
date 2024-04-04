/*
-------------------------------------------------------
l08_t02.s
-------------------------------------------------------
Author: Jashandeep Singh
ID:     160198282
Email:  sing8282@mylaurier.ca
Date:    2024-03-21
-------------------------------------------------------
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
*/
// Constants
.equ SIZE, 2 // Size of string buffer storage (bytes)

.org 0x1000   // Start at memory location 1000
.text         // Code section
.global _start
_start:

//=======================================================

mov r5,#SIZE

//=======================================================

ldr    r4, =First
bl    ReadString
ldr    r4, =Second
bl    ReadString
ldr    r4, =Third
bl     ReadString
ldr    r4, =Last
bl     ReadString

_stop:
b _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ ENTER, 0x0A            // The enter key code
.equ VALID, 0x8000          // Valid data in UART mask

ReadString:
/*
-------------------------------------------------------
Reads an ENTER terminated string from the UART.
-------------------------------------------------------
Parameters:
  r4 - address of string buffer
  r5 - size of string buffer
Uses:
  r0 - holds character to print
  r2 - current buffer size
  r1 - address of UART
-------------------------------------------------------
*/

//=======================================================

stmfd sp!, {r0-r2, r4}     // preserve temporary registers
stmfd sp!, {lr}            // preserve link register
ldr r1, =UART_BASE        // get address of UART
mov r2,#0

rsLOOP:
ldr  r0, [r1]      // read the UART data register
tst  r0, #VALID    // check if there is new data
beq  _ReadString   // if no data, exit subroutine
strb r0, [r4]      // store the character in memory
add  r4, r4, #1    // move to next byte in storage buffer
add r2,r2,#1
cmp r2,r5
beq  _ReadString   // if buffer size reached
b    rsLOOP
_ReadString:

ldmfd    sp!, {lr}                // pop back link register
ldmfd    sp!, {r0-r2, r4}        // pop back link register
//=======================================================


bx    lr                    // return from subroutine

.data
.align
// The list of strings
First:
.space  SIZE
Second:
.space SIZE
Third:
.space SIZE
Last:
.space SIZE
_Last:    // End of list address

.end