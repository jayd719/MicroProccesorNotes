/*
-------------------------------------------------------
errors3.s
-------------------------------------------------------
Author: Jashandeep Singh	
ID:	169018282
Email:	sing8282@mylaurier.ca
Date: 	1 Feb 2024
-------------------------------------------------------
Assign to and add contents of registers.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

.text // code section
// Copy contents of first element of Vec1 to Vec2
ldr r0, =Vec1;
ldr r1, =Vec2;
ldr r2, [r0]
str r2, [r1]
// Copy contents of second element of Vec1 to Vec2
add r0, r0, #4
add r1, r1, #000 //this line is not required, because address of Vec stays same
ldr r2, [r0]
str r2, [r1]
// Copy contents of thrid element of Vec1 to Vec2
add r0, r0, #4
add r1, r1, #0000 // this line is not required, because address Vec stays same
ldr r2, [r0]
str r2, [r1]
// End program
_stop:
b _stop

.data // Initialized data section
Vec1:
.word 1, 2, 3

.bss // Uninitialized data section

Vec2:
.space 4 // Set aside 4 bytes for result
.end