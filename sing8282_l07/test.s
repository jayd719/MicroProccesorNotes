/*
-------------------------------------------------------
gcd_recursive.s
-------------------------------------------------------
Author:  David Brown
ID:      123456789
Email:   dbrown@wlu.ca
Date:    2023-07-31
-------------------------------------------------------
Working with stack frames and recursion.
Find the greatest common denominator of two numbers.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r1, =numbers    // get address of numbers
ldr    r2, [r1, #4]    // put second number into register (4 bytes past first number)
stmfd  sp!, {r2}       // push second number onto stack
ldr    r2, [r1]        // put first number into register
stmfd  sp!, {r2}       // push first number onto stack
bl     gcd             // call the subroutine
add    sp, sp, #8      // release the parameter memory from the stack
// Result in r0
str    r0, [r1, #8]    // write result back to memory (8 bytes past first number)

_stop:
b    _stop

//-------------------------------------------------------
gcd:
/*
-------------------------------------------------------
Finds the Greatest Common Denominator of two integers (recursive)
Uses simple recursive algorithm:

int gcd(a, b) {
    if(a == b) {
        return a;
    } else if(a > b) {
        return gcd(b, a - b);
    } else {
        return gcd(b, a);
    }
-------------------------------------------------------
Parameters:
  a - value of first number
  b - value of second number
Returns:
  r0 - GCD of a and b
Uses:
  r0 - value of a - return value
  r1 - value of b
-------------------------------------------------------
*/
stmfd   sp!, {fp}       // preserve frame pointer
mov     fp, sp          // save current stack top to frame pointer
// preserve other registers including lr because of recursive call
stmfd   sp!, {r1, lr}

// Copy parameters into registers
ldr     r0, [fp, #4]    // get a
ldr     r1, [fp, #8]    // get b

cmp     r0, r1
beq     _gcd            // a is the gcd: return in r0
subgt   r0, r0, r1      // a > b: gcd(b, a - b)
                        // else:  gcd(b, a)
stmfd   sp!, {r0}       // 2nd parameter - push a onto the stack
stmfd   sp!, {r1}       // 1st parameter - push b onto the stack
bl      gcd             // recursive call to subroutine
add     sp, sp, #8      // release parameter memory from stack

_gcd:
ldmfd   sp!, {r1, lr}   // pop preserved registers
ldmfd   sp!, {fp}       // pop frame pointer
bx      lr              // return from subroutine

//-------------------------------------------------------
.data  // Data section
.align
numbers:
.word 30, 12
result:
.space 4
.end