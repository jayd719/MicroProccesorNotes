/*
-------------------------------------------------------
l05_t01.s
-------------------------------------------------------
Author: Jashandeep Singh
ID:     169018282
Email:  sing8282@mylaurier.ca
Date:    2024-03-05
-------------------------------------------------------
Does a running total of an integer list.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r1, =Data    // Store address of start of list
ldr    r2, =_Data   // Store address of end of list
bl     list_total   // Call subroutine - total returned in r0

_stop:
b      _stop

//-------------------------------------------------------
list_total:
/*
-------------------------------------------------------
Totals values in a list.
Equivalent of: int total(*start, *end)
-------------------------------------------------------
Parameters:
  r1 - start address of list
  r2 - end address of list
Uses:
  r3 - temporary value
Returns:
  r0 - total of values in list
-------------------------------------------------------
*/

STMFD SP!,{r3}  // preserve the register- R3 used for tempory calculations
MOV R0,#0 	   // intialize varible for storing sum of elements
LOOP:
    LDR R3,[R1],#4
    ADD R0,R0,R3
    CMP R2,R1
    BNE LOOP

LDMFD SP!,{r3} // restore the resigtes
bx      lr // return to main program



.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end