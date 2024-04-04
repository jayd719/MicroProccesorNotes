/*
-------------------------------------------------------
swap.s
-------------------------------------------------------
Author:  David Brown
ID:      123456789
Email:   dbrown@wlu.ca
Date:    2024-02-22
-------------------------------------------------------
Working with stack frames and local variables.
Swaps values in memory locations.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r1, =y        // get address of second parameter
stmfd  sp!, {r1}     // push second parameter onto stack
ldr    r1, =x        // get address of first parameter
stmfd  sp!, {r1}     // push first parameter onto stack
bl     swap          // call subroutine
add    sp, sp, #8    // release parameter memory

_stop:
b      _stop

//-------------------------------------------------------
swap:
/*
-------------------------------------------------------
Swaps location of two values in memory.
Equivalent of: swap(*x, *y)
-------------------------------------------------------
Parameters:
  x - address of first value
  y - address of second value
Local variable
  temp (4 bytes on stack)
Uses:
  r0 - address of x
  r1 - address of y
  r2 - value to swap
-------------------------------------------------------
*/
stmfd   sp!, {fp}       // preserve frame pointer
mov     fp, sp          // save stack top to frame pointer
sub     sp, sp, #4      // set aside space for local variable temp
stmfd   sp!, {r0-r2}    // preserve temporary registers

ldr     r0, [fp, #4]    // get address of x
ldr     r1, [fp, #8]    // get address of y

ldr     r2, [r0]        // get value at x
str     r2, [fp, #-4]   // copy value of x to temp

ldr     r2, [r1]        // get value at y
str     r2, [r0]        // store value of y in x

ldr     r2, [fp, #-4]   // get temp
str     r2, [r1]        // store temp in y

ldmfd   sp!, {r0-r2}    // restore preserved registers
add     sp, sp, #4      // remove local storage
ldmfd   sp!, {fp}       // restore frame pointer
bx      lr              // return from subroutine

//-------------------------------------------------------
.data
.align
x:
.word    15
y:
.word    9

.end