/*
-------------------------------------------------------
l04_t02.s
-------------------------------------------------------
Author:  Jashandeep Singh
ID:      169018282
Email:   sing8282@mylaurier.ca
Date:    2024-03-01
-------------------------------------------------------
calculate number of elements and number of bytes
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

LDR    R2, =Data    // Store address of start of list
LDR    R3, =_Data   // Store address of end of list

MOV R1,#0 	// intilize the sum variable
MOV R4,#0   // intilize the counter variable
MOV R5,#0   // Intilize counter for number of bytes

// calculate number of elements without using loop
SUBS R8,R3,R2  // end address of list - start address of list
LSR R8,R8,#2   // divide by 4 i.e size of element of list to get number of items
LSL R9,R8,#3    // multiply numbers of elements with 8 ie 8 bytes per word to get total number of bytes.



Loop:
	LDR    R0, [R2], #4   // post increment with write back
	ADD	   R1,R1,R0 	 //  calculate sum of elements
	ADD	   R4,R4,#1     //   counts number of elements in list
	MOV    R5,#0 
	ADD    R5, R4, LSL #3 // convert number of words to bytes
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