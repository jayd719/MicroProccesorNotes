/*
-------------------------------------------------------
intro.s
-------------------------------------------------------
Author: Jashandeep Singh
ID:169018282
Email: sing8282@mylaurier.ca
Date:
-------------------------------------------------------
Assign to and add contents of registers.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

mov r0, #0x9      // Store decimal 9 in register r0
mov r1, #14     // Store hex E (decimal 14) in register r1
add r2, r1, r0  // Add the contents of r0 and r1 and put result in r2

mov r3, #0x8 // Store decimal 8 in register r3
add r3, r3,r3 // Add the contents of r3 into r3 and put the result in r3


// below line will not be compiled
//add r4, #0x5,#0x4 // Add 5 and 4, and put the result in r4
add r4, r3,#0x4 // Add 5 and 4, and put the result in r4
// End program
_stop:
b _stop