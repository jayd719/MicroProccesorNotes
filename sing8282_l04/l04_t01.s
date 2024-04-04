/*
-------------------------------------------------------
l04_t01.s
-------------------------------------------------------
Author:  Jashandeep Singh
ID:      169018282
Email:   sing8282@mylaurier.ca
Date:    2024-03-01
-------------------------------------------------------
Calculate sum of all elements of list
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

LDR    R2, =Data    // Store address of start of list
LDR    R3, =_Data   // Store address of end of list

MOV R1,#0 	// intilize the sum variable
Loop:
	LDR    R0, [R2], #4  // post increment with write back
	ADD	   R1,R1,R0
	CMP    R3, R2
	BNE    Loop  

_stop:
b _stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end