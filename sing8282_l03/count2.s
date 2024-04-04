/*
-------------------------------------------------------
count2.s
-------------------------------------------------------
Author: Jashandeep Singh	
ID:		169018282
Email:	sing8282@mylaurier.ca
Date: 	9 February 2024
-------------------------------------------------------
A simple count down program (bge)
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

// Store data in registers
ldr  r3, =COUNTER;  // Initialize a countdown value, move the address to r3
ldr r3, [r3] // read the value from address stored in r3

TOP:
sub r3, r3, #1 // Decrement the countdown value
cmp r3, #0  // Compare the countdown value to 0
bge TOP   // Branch to top under certain conditions


_stop:
b _stop

.data // Initialized data section
COUNTER:
.word 5 
.end