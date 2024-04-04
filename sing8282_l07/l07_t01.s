/*
-------------------------------------------------------
l07_t01.s
Subroutines for working with characters.
-------------------------------------------------------
Author: Jashandeep Singh
ID:     169018282
Email:  sing8282@mylaurier.ca
Date:    2024-03-21
-------------------------------------------------------
*/
.org    0x1000    // Start at memory location 1000
.text  // Code section
.global _start
_start:

//-------------------------------------------------------
// Constants
.equ UART_BASE, 0xff201000     // UART base address
.equ ENTER, 0x0a     // enter character
.equ VALID, 0x8000   // Valid data in UART mask



// Type a character into the UART to test
bl  ReadChar
mov r2, r0
ldr r4, =characterStr
bl  PrintString
bl  PrintChar
bl  PrintEnter

ldr r4, =isLetterStr
bl  PrintString
bl  isLetter
bl  PrintTrueFalse
bl  PrintEnter

ldr r4, =isLowerStr
bl  PrintString
bl  isLowerCase
bl  PrintTrueFalse
bl  PrintEnter

ldr r4, =isUpperStr
bl  PrintString
bl  isUpperCase
bl  PrintTrueFalse
bl  PrintEnter

_stop:
B    _stop



//-------------------------------------------------------
ReadChar:
/*
-------------------------------------------------------
Reads single character from UART.
-------------------------------------------------------
Uses:
  r1 - address of UART
Returns:
  r0 - value of character, null if UART Read FIFO empty
-------------------------------------------------------
*/
stmfd   sp!, {r1, lr}
ldr     r1, =UART_BASE  // Load UART base address
ldr     r0, [r1]        // read the UART data register
tst     r0, #VALID      // check if there is new data
moveq   r0, #0          // if no data, return 0
andne   r0, r0, #0x00FF // else return only the character
_ReadChar:
ldmfd   sp!, {r1, lr}
bx      lr

//-------------------------------------------------------
PrintChar:
/*
-------------------------------------------------------
Prints single character to UART.
-------------------------------------------------------
Parameters:
  r2 - address of character to print
Uses:
  r1 - address of UART
-------------------------------------------------------
*/
stmfd   sp!, {r1, lr}
ldr     r1, =UART_BASE  // Load UART base address
strb    r2, [r1]        // copy the character to the UART DATA field
ldmfd   sp!, {r1, lr}
bx      lr

//-------------------------------------------------------
PrintString:
/*
-------------------------------------------------------
Prints a null terminated string to the UART.
-------------------------------------------------------
Parameters:
  r4 - address of string
Uses:
  r1 - address of UART
  r2 - current character to print
-------------------------------------------------------
*/
stmfd   sp!, {r1-r2, r4, lr}
ldr     r1, =UART_BASE
psLOOP:
ldrb    r2, [r4], #1     // load a single byte from the string
cmp     r2, #0           // compare to null character
beq     _PrintString     // stop when the null character is found
strb    r2, [r1]         // else copy the character to the UART DATA field
b       psLOOP
_PrintString:
ldmfd   sp!, {r1-r2, r4, lr}
bx      lr

//-------------------------------------------------------
PrintEnter:
/*
-------------------------------------------------------
Prints the ENTER character to the UART.
-------------------------------------------------------
Uses:
  r2 - holds ENTER character
-------------------------------------------------------
*/
stmfd   sp!, {r2, lr}
mov     r2, #ENTER       // Load ENTER character
bl      PrintChar
ldmfd   sp!, {r2, lr}
bx      lr

//-------------------------------------------------------
PrintTrueFalse:
/*
-------------------------------------------------------
Prints "T" or "F" as appropriate
-------------------------------------------------------
Parameter
  r0 - input parameter of 0 (false) or 1 (true)
Uses:
  r2 - 'T' or 'F' character to print
-------------------------------------------------------
*/
stmfd   sp!, {r2, lr}
cmp     r0, #0           // Is r0 False?
moveq   r2, #'F'         // load "False" message
movne   r2, #'T'         // load "True" message
bl      PrintChar
ldmfd   sp!, {r2, lr}
bx      lr

//-------------------------------------------------------
isLowerCase:
/*
-------------------------------------------------------
Determines if a character is a lower case letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if lower case, False (0) otherwise
-------------------------------------------------------
*/
mov    r0, #0           // default False
cmp    r2, #'a'
blt    _isLowerCase     // less than 'a', return False
cmp    r2, #'z'
movle  r0, #1           // less than or equal to 'z', return True
_isLowerCase:
bx lr

//-------------------------------------------------------
isUpperCase:
/*
-------------------------------------------------------
Determines if a character is an upper case letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if upper case, False (0) otherwise
-------------------------------------------------------
*/
mov    r0, #0           // default False
cmp    r2, #'A'
blt    _isUpperCase     // less than 'A', return False
cmp    r2, #'Z'
movle  r0, #1           // less than or equal to 'Z', return True
_isUpperCase:
bx lr

//-------------------------------------------------------
isLetter:
/*
-------------------------------------------------------
Determines if a character is a letter.
-------------------------------------------------------
Parameters
  r2 - character to test
Returns:
  r0 - returns True (1) if letter, False (0) otherwise
-------------------------------------------------------
*/


//=======================================================

/*The current code fails because following the execution of 
the nested subroutine, the link register (lr) is updated to 
point to the return address of the nested subroutine, thus 
overwriting the upper subroutine's return address. This leads 
to failure. To resolve this issue, the return address of the 
parent subroutine must be preserved before calling the nested 
subroutine.*/
//=======================================================


//=======================================================

/*Before entering the nested subroutine,push the return address 
of the current subroutine onto the stack. This preserves the address, 
preventing it from being overwritten by the nested call.*/
stmfd   sp!, {lr}
//=======================================================

// given code: call the subroutine to check if lower or not.
bl      isLowerCase     // test for lowercase

//=======================================================
/*After the nested subroutine completes execution, 
the return address of the current subroutine is popped back 
into the link register (lr).*/
ldmfd   sp!, {lr} 
//=======================================================


// Verify if the result is still false; if it has already been confirmed, there's no need to check for lowercase.
cmp     r0, #0
bne isLetterEnd // if lower case, jump to end of subroutine


//=======================================================
/*Just like previous call-Before entering the nested subroutine,push the return address 
of the current subroutine onto the stack. This preserves the address, 
preventing it from being overwritten by the nested call.
This is only done if now is not lower*/
stmfd   sp!, {lr}
//=======================================================

bleq    isUpperCase     // not lowercase? Test for uppercase.

//=======================================================
/*Just Like Last Time-After the nested subroutine completes execution, 
the return address of the current subroutine is popped back 
into the link register (lr).*/
ldmfd   sp!, {lr} 
//=======================================================

isLetterEnd:
bx      lr

//-------------------------------------------------------
.data
characterStr:
.asciz "Char: "
isLetterStr:
.asciz "Letter: "
isLowerStr:
.asciz "Lower: "
isUpperStr:
.asciz "Upper: "
_Data:

.end