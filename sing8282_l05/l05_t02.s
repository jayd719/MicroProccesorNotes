/*
-------------------------------------------------------
l05_t02.s
-------------------------------------------------------
Author: Jashandeep Singh
ID:     169018282
Email:  sing8282@mylaurier.ca
Date:    2024-03-05
-------------------------------------------------------
Calculates stats on an integer list.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

mov    r1, #0       // Initialize counters
mov    r2, #0
mov    r3, #0
ldr    r4, =Data    // Store address of start of list
ldr    r5, =_Data   // Store address of end of list
bl     list_stats   // Call subroutine - total returned in r0

_stop:
b      _stop

//-------------------------------------------------------
list_stats:
/*
-------------------------------------------------------
Counts number of positive, negative, and 0 values in a list.
Equivalent of: void stats(*start, *end, *zero, *positive, *negatives)
-------------------------------------------------------
Parameters:
  r1 - number of zero values
  r2 - number of positive values
  r3 - number of negative values
  r4 - start address of list
  r5 - end address of list
Uses:
  r0 - temporary value
-------------------------------------------------------
*/
STMFD SP!,{R0,R4,R5}

LOOP:
    LDR R0,[R4],#4
    CMP R0,#0
    ADDEQ R1,R1,#1 // if zero
    ADDGT R2,R2,#1 // if greater
    ADDLT R3,R3,#1 // if less than zero
    CMP R5,R4
    BNE LOOP

LDMFD SP!,{R0,R4,R5}
BX LR


.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end


// without preserving R4,R5 assembler alarms out

// with preserving R4,R5 assembler does not alarm out.