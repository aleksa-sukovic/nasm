; Ask for two integers as input and print out their sum

%include "lib/asm_io.asm"

;
;   Initialized data (constants) are put in .data segment
;
segment .data
    prompt1 db "Enter a number: ", 0
    prompt2 db "Enter another number: ", 0
    outmsg1 db "You entered ", 0
    outmsg2 db " and ", 0
    outmsg3 db ", sum of these is ", 0

;
;   Uninitialized data is put in the .bss segment
;
segment .bss
;
;  These labels refer to double words used to store the inputs
;
    input1 resd 1 ; 1 uninitialized double word (4bytes)
    input2 resd 1 ; 1 uninitialized double word (4bytes)

;
;   Code is put inside .text segment
;
segment .text
    global asm_main
asm_main:
    enter 0,0 ; setup routine
    pusha     ; push all to stack

    mov eax, prompt1 ; print out prompt
    call print_string

    call read_int ; reading integer
    mov [input1], eax ; at location specified by input1 store the contents of eax register

    mov eax, prompt2 ; print out prompt
    call print_string

    call read_int ; read integer
    mov [input2], eax ; at location specified by label input2, store the contents of eax register

    mov eax, [input1] ; eax = dword at input1 location
    add eax, [input2] ; eax += dword at input2 location
    mov ebx, eax      ; ebx = eax

;
; Sum is kept at ebx register, now it's time to print out messages
;
    mov eax, outmsg1
    call print_string  ; prints out first message
    mov eax, [input1]
    call print_int     ; prints out first input
    mov eax, outmsg2
    call print_string  ; prints out second message
    mov eax, [input2]
    call print_int     ; prints out second input
    mov eax, outmsg3
    call print_string  ; print out third message
    mov eax, ebx
    call print_int     ; prints out the sum
    call print_nl

    popa
    mov eax, 0 ; return back to C
    leave
    ret